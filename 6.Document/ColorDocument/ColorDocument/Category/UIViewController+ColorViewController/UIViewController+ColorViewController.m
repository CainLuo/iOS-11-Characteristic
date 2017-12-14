//
//  UIViewController+ColorViewController.m
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "UIViewController+ColorViewController.h"

@implementation UIViewController (ColorViewController)

- (void)showAlertViewControllerWithTitle:(NSString *)title
                                 message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

@end
