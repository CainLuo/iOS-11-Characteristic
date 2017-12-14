//
//  UIImage+ColorImage.h
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CLImage)(UIImage *image);

@interface UIImage (ColorImage)

+ (UIImage *)cl_getImageWithColor:(UIColor *)color;

@end
