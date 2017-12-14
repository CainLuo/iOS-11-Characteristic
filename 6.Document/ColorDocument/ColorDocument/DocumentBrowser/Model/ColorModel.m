//
//  ColorModel.m
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "ColorModel.h"

@implementation ColorModel

- (instancetype)initColorModelWithRedValue:(NSInteger)redValue
                                greenValue:(NSInteger)greenValue
                                 blueValue:(NSInteger)blueValue {
    
    self = [super init];
    
    if (self) {
        
        self.redValue   = redValue;
        self.greenValue = greenValue;
        self.blueValue  = blueValue;
    }
    
    return self;
}

- (ColorModel *)lighterColorWithToAdd:(NSInteger)toAdd {
    
    NSInteger redValue   = [self lighter:self.redValue toAdd:toAdd];
    NSInteger greenValue = [self lighter:self.greenValue toAdd:toAdd];
    NSInteger blueValue  = [self lighter:self.blueValue toAdd:toAdd];

    return [self initColorModelWithRedValue:redValue greenValue:greenValue blueValue:blueValue];
}

- (NSInteger)lighter:(NSInteger)component
               toAdd:(NSInteger)toAdd {
    
    return MIN(component + toAdd, 255);
}

@end
