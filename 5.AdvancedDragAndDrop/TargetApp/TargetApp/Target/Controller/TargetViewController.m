//
//  TargetViewController.m
//  TargetApp
//
//  Created by Cain Luo on 2017/12/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "TargetViewController.h"
#import "ImageModel.h"
#import "LoadingView.h"

@interface TargetViewController () <UIDropInteractionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSProgress *progress;

@property (nonatomic, strong) ImageModel *imageModel;

@property (nonatomic, strong) LoadingView *loadingView;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearButton.springLoaded = YES;
    
    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    
    [self.view addInteraction:dropInteraction];
    
    [self display];
}

- (IBAction)clearAction:(UIButton *)sender {
    
    self.imageModel = nil;
    self.titleLabel.text = @"";
    
    [self display];
}

- (void)display {
    
    if (!self.imageModel) {
     
        self.imageView.image = nil;
        self.titleLabel.text = @"";
        
        return;
    }
    
    self.imageView.image = self.imageModel.image;
    self.titleLabel.text = self.imageModel.title;
}

#pragma mark - UIDropInteractionDelegate
- (BOOL)dropInteraction:(UIDropInteraction *)interaction
       canHandleSession:(id<UIDropSession>)session {
    
    return [session canLoadObjectsOfClass:[ImageModel class]];
}

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction
                   sessionDidUpdate:(id<UIDropSession>)session {
    
    return [[UIDropProposal alloc] initWithDropOperation:UIDropOperationCopy];
}

- (void)dropInteraction:(UIDropInteraction *)interaction
            performDrop:(id<UIDropSession>)session {
    
    UIDragItem *dropItem = session.items.lastObject;
    
    if (!dropItem) {
        
        return;
    }
    
    session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyleNone;
    
    self.progress = [dropItem.itemProvider loadObjectOfClass:[ImageModel class]
                                           completionHandler:^(id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
        
                                               self.imageModel = (ImageModel *)object;

                                               if (!self.imageModel) {
                                                   
                                                   return;
                                               }
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                   [self display];
                                                   
                                                   [self.loadingView removeFromSuperview];
                                                   self.loadingView = nil;
                                               });
                                           }];
}

- (void)dropInteraction:(UIDropInteraction *)interaction
                   item:(UIDragItem *)item
willAnimateDropWithAnimator:(id<UIDragAnimating>)animator {
    
    NSProgress *progress    = self.progress;
    UIView *interactionView = interaction.view;
    
    if (!interactionView || !progress) {
        
        return;
    }
    
    self.loadingView = [[LoadingView alloc] initWithFrame:interactionView.bounds
                                                 progress:progress];
    
    [interactionView addSubview:self.loadingView];
}

@end
