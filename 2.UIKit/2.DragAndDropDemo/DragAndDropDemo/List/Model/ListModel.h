//
//  ListModel.h
//  DragAndDropDemo
//
//  Created by Cain Luo on 2017/11/7.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject <NSItemProviderReading, NSItemProviderWriting>

- (instancetype)initWithTitleString:(NSString *)titleString;

@property (nonatomic, copy) NSString *titleString;

@end
