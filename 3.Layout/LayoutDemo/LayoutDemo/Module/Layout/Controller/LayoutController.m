//
//  LayoutController.m
//  LayoutDemo
//
//  Created by Cain Luo on 2017/11/8.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "LayoutController.h"

@interface LayoutController ()

@end

@implementation LayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSStringFromClass(self.class);
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
}

@end
