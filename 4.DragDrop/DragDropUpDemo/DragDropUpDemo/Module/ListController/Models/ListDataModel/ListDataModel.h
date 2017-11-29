//
//  ListDataModel.h
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ListModelType) {
    
    ListModelStandType = 0,
    ListModelShoppingType
};

@interface ListDataModel : NSObject

@property (nonatomic, copy) NSString *name;

@end
