//
//  ScrollController.m
//  LayoutDemo
//
//  Created by Cain Luo on 2017/11/8.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ScrollController.h"

@interface ScrollController ()

@property (weak, nonatomic) IBOutlet UIView *tipsView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSStringFromClass(self.class);
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    
    CGFloat scrollIndicatorMargin = 8;
    
    self.tipsView.layer.cornerRadius = 8;
    
    [self.tipsView.leadingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.leadingAnchor
                                                constant:scrollIndicatorMargin].active = YES;
    
    [self.tipsView.trailingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.trailingAnchor
                                                constant:-scrollIndicatorMargin].active = YES;
    
    [self.tipsView.bottomAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.bottomAnchor
                                                constant:-scrollIndicatorMargin].active = YES;
    
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(0,
                                                     0,
                                                     self.tipsView.frame.size.height + scrollIndicatorMargin,
                                                     scrollIndicatorMargin);
    
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

@end
