//
//  ListModelCoordinator.h
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ListDataModel.h"

@interface ListModelCoordinator : NSObject

- (instancetype)initWithSource:(ListModelType)source;

- (UIDragItem *)dragItemForIndexPath:(NSIndexPath *)indexPath;

- (void)calculateDestinationIndexPaths:(NSIndexPath *)indexPath
                                 count:(NSInteger)count;

@property (nonatomic, assign, getter=isReordering) BOOL reordering;
@property (nonatomic, assign) BOOL dragCompleted;

@property (nonatomic, strong) NSMutableArray *sourceIndexes;

@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *sourceIndexPaths;

@property (nonatomic, strong) NSArray<NSIndexPath *> *destinationIndexPaths;

@property (nonatomic, strong) ListDataModel *listModel;

@property (nonatomic, assign) ListModelType source;
@property (nonatomic, assign) ListModelType destination;

@end
