//
//  ImageViewController.m
//  SourceApp
//
//  Created by Cain Luo on 2017/12/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageModel.h"
#import "ImageDragView.h"

@interface ImageViewController () <UIDragInteractionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) ImageModel *imageModel;

@end

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.imageModel) {
        
        self.titleLabel.text = self.imageModel.title;
        self.imageView.image = self.imageModel.image;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.userInteractionEnabled = YES;
    
    UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    
    [self.view addInteraction:dragInteraction];
}

#pragma mark - UIDragInteractionDelegate
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction
                  itemsForBeginningSession:(id<UIDragSession>)session {
    
    ImageModel *imageModel = self.imageModel;
    
    if (!imageModel) {
        return @[];
    }
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:imageModel];
    
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    
    return @[dragItem];
}

#pragma mark - 拖动时的预览页面设置
- (UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction
                     previewForLiftingItem:(UIDragItem *)item
                                   session:(id<UIDragSession>)session {
    
    UIView *dragView = interaction.view;
    
    ImageModel *imageModel = self.imageModel;

    if (!dragView && !imageModel) {
        
        return [[UITargetedDragPreview alloc] initWithView:interaction.view];
    }
    
    ImageDragView *imageDragView = [[ImageDragView alloc] initWithTitle:self.imageModel.title
                                                                  image:self.imageModel.image];
    
    UIDragPreviewParameters *dragPreviewParameters = [[UIDragPreviewParameters alloc] init];
    
    dragPreviewParameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:imageDragView.bounds
                                                                   cornerRadius:20];
    
    CGPoint dragPoint = [session locationInView:dragView];
    
    UIDragPreviewTarget *dragPreviewTarget = [[UIDragPreviewTarget alloc] initWithContainer:dragView
                                                                                     center:dragPoint];
    
    return [[UITargetedDragPreview alloc] initWithView:imageDragView
                                            parameters:dragPreviewParameters
                                                target:dragPreviewTarget];
}

- (UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction
                  previewForCancellingItem:(UIDragItem *)item
                               withDefault:(UITargetedDragPreview *)defaultPreview {
    
    UIView *superView = self.imageView.superview;
    
    if (!superView) {
        
        return defaultPreview;
    }
    
    UIDragPreviewTarget *dragPreviewTarget = [[UIDragPreviewTarget alloc] initWithContainer:superView
                                                                                     center:self.imageView.center];
    
    return [[UITargetedDragPreview alloc] initWithView:self.imageView
                                            parameters:[[UIDragPreviewParameters alloc] init]
                                                target:dragPreviewTarget];
}

#pragma mark - 是否要限制拖动
- (BOOL)dragInteraction:(UIDragInteraction *)interaction
sessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session {
    
    return NO;
}

#pragma mark - 添加动画效果
- (void)dragInteraction:(UIDragInteraction *)interaction
willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator
                session:(id<UIDragSession>)session {
    
    [animator addAnimations:^{
        
        self.imageView.alpha = 0.25;
    }];
}

- (void)dragInteraction:(UIDragInteraction *)interaction
                session:(id<UIDragSession>)session
    didEndWithOperation:(UIDropOperation)operation {
    
    if (operation == UIDropOperationCopy) {
        
        self.imageView.alpha = 1.0;
    }
}

- (void)dragInteraction:(UIDragInteraction *)interaction
                   item:(UIDragItem *)item
willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    
    [animator addAnimations:^{
        
        self.imageView.alpha = 1.0;
    }];
}

#pragma mark - Image Model
- (ImageModel *)imageModel {
    
    if (!_imageModel) {
        
        _imageModel = [[ImageModel alloc] init];
        
        _imageModel.title = @"这是一个大笑的表情";
        _imageModel.image = [UIImage imageNamed:@"1.jpg"];
    }
    
    return _imageModel;
}

@end
