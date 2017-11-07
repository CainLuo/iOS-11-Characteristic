//
//  MenuManager.m
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "MenuManager.h"

@interface MenuManager () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *targetView;

@end;

@implementation MenuManager

- (instancetype)initWithView:(UIView *)view {
    
    self = [super init];
    
    if (self) {
        
        self.targetView = view;
    }
    
    return self;
}

#pragma mark - UILongPressGestureRecognizer
- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    
    if (!_longPressGestureRecognizer) {
        
        _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(longPressGestureRecognizerAction:)];
    }
    
    return _longPressGestureRecognizer;
}

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            
            CGPoint pressLocation = [sender locationInView:self.targetView];
            
            [self.targetView becomeFirstResponder];
            
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            
            CGRect rect = CGRectZero;
            
            rect.origin = pressLocation;
            rect.size = CGSizeMake(10, 10);
            
            [menuController setTargetRect:rect
                                   inView:self.targetView];
            [menuController setMenuVisible:YES
                                  animated:YES];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            [[UIMenuController sharedMenuController] setMenuVisible:NO
                                                           animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - tapGestureRecognizer
- (UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (!_tapGestureRecognizer) {
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(tapGestureRecognizerAction:)];
        
        _tapGestureRecognizer.delegate = self;
    }
    
    return _tapGestureRecognizer;
}

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO
                                                   animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return [[UIMenuController sharedMenuController] isMenuVisible];
}

@end
