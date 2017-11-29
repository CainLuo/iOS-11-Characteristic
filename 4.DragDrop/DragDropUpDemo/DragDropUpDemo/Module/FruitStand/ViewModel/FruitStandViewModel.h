//
//  FruitStandViewModel.h
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/26.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ListDataModel.h"

@interface FruitStandViewModel : NSObject

- (instancetype)initFruitStandViewModelWithController:(UIViewController *)controller;

@property (nonatomic, strong, readonly) NSMutableArray *dataSource;

- (ListDataModel *)getDataModelWithIndexPath:(NSIndexPath *)indexPath
                                     context:(ListModelType)context;

- (NSMutableArray *)deleteModelWithIndexes:(NSArray *)indexes
                                   context:(ListModelType)context;

- (void)insertModelWithDataSource:(NSArray *)dataSource
                          context:(ListModelType)contexts
                            index:(NSInteger)index;

@end
