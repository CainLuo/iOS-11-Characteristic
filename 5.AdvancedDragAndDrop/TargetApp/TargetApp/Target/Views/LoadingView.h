//
//  LoadingView.h
//  TargetApp
//
//  Created by Cain Luo on 2017/12/13.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     progress:(NSProgress *)progress;

@end
