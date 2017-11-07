//
//  TableViewCellModel.h
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellModel : NSObject <NSItemProviderReading, NSCoding>

- (instancetype)initTitleString:(NSString *)title;

@property (nonatomic, copy) NSString *titleString;

@end
