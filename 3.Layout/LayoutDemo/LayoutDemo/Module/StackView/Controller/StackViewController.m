//
//  StackViewController.m
//  LayoutDemo
//
//  Created by Cain Luo on 2017/11/9.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "StackViewController.h"

@interface StackViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIImageView *sunImageView;

@property (nonatomic, assign) BOOL action;

@property (nonatomic, assign) CGFloat customSpacing;

@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sunImageView.adjustsImageSizeForAccessibilityContentSizeCategory = YES;
    
    self.title = NSStringFromClass(self.class);
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;

    self.action = YES;
    self.customSpacing = 40;
}

- (IBAction)changeAction:(UIButton *)sender {
    
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.5
                                                          delay:0
                                                        options:UIViewAnimationOptionCurveEaseInOut
                                                     animations:^{
        
                                                         if (self.action) {
                                                             
                                                             [self.stackView setCustomSpacing:self.customSpacing
                                                                                    afterView:self.sunImageView];
                                                         } else {
                                                             
                                                             [self.stackView setCustomSpacing:0
                                                                                    afterView:self.sunImageView];
                                                         }
                                                         
                                                         self.action = !self.action;
                                                         
                                                     } completion:nil];
}

@end
