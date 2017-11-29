//
//  ListModelCoordinator.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListModelCoordinator.h"

@implementation ListModelCoordinator

- (BOOL)isReordering {

    return self.source == self.destination;
}

- (instancetype)initWithSource:(ListModelType)source {
    
    self = [super init];
    
    if (self) {
        
        self.source = source;
    }
    
    return self;
}

- (NSMutableArray<NSIndexPath *> *)sourceIndexPaths {
    
    if (!_sourceIndexPaths) {
        
        _sourceIndexPaths = [NSMutableArray array];
    }
    
    return _sourceIndexPaths;
}

- (NSMutableArray *)sourceIndexes {
    
    if (!_sourceIndexes) {
        
        _sourceIndexes = [NSMutableArray array];
        
        [_sourceIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [_sourceIndexes addObject:@(obj.item)];
        }];
    }
    
    return _sourceIndexes;
}

- (UIDragItem *)dragItemForIndexPath:(NSIndexPath *)indexPath {
    
    [self.sourceIndexPaths addObject:indexPath];
        
    return [[UIDragItem alloc] initWithItemProvider:[[NSItemProvider alloc] init]];
}

- (void)calculateDestinationIndexPaths:(NSIndexPath *)indexPath
                                 count:(NSInteger)count {
    
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:indexPath.item
                                                            inSection:0];
    
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithObject:destinationIndexPath];
    
    self.destinationIndexPaths = [indexPathArray copy];
}

@end
