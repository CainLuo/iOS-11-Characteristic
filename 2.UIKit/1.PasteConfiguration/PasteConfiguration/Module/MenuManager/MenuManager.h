//
//  MenuManager.h
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuManager : NSObject

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end
