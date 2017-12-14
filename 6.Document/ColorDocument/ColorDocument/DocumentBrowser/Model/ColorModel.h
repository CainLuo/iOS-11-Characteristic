//
//  ColorModel.h
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorModel : NSObject

@property (nonatomic, assign) NSInteger redValue;
@property (nonatomic, assign) NSInteger greenValue;
@property (nonatomic, assign) NSInteger blueValue;

- (ColorModel *)lighterColorWithToAdd:(NSInteger)toAdd;

- (instancetype)initColorModelWithRedValue:(NSInteger)redValue
                                greenValue:(NSInteger)greenValue
                                 blueValue:(NSInteger)blueValue;

@end
