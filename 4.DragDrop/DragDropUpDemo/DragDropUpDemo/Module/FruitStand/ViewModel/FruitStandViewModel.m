//
//  FruitStandViewModel.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/26.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "FruitStandViewModel.h"
#import "FruitStandController.h"

@interface FruitStandViewModel ()

@property (nonatomic, weak) FruitStandController *fruitStandController;

@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;

@end

@implementation FruitStandViewModel

- (instancetype)initFruitStandViewModelWithController:(UIViewController *)controller {
    
    self = [super init];
    
    if (self) {
        self.fruitStandController = (FruitStandController *)controller;
    }
    
    return self;
}

- (ListDataModel *)getDataModelWithIndexPath:(NSIndexPath *)indexPath
                                     context:(ListModelType)context {
    
    NSArray *dataSource = self.dataSource[context];
    
    ListDataModel *model = dataSource[indexPath.row];
    
    return model;
}

- (NSMutableArray *)deleteModelWithIndexes:(NSArray *)indexes
                                   context:(ListModelType)context {
    
    NSMutableArray *array = [NSMutableArray array];
    
    [indexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger idex = [obj integerValue];
        
        ListDataModel *dataModel = self.dataSource[context][idex];
        
        [array addObject:dataModel];
    }];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource[context] removeObject:obj];
    }];
    
    return array;
}

- (void)insertModelWithDataSource:(NSArray *)dataSource
                          context:(ListModelType)context
                            index:(NSInteger)index {
    
    [self.dataSource[context] insertObjects:dataSource
                                  atIndexes:[NSIndexSet indexSetWithIndex:index]];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data"
                                                                                          ofType:@"json"]];
        
        NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                  options:NSJSONReadingMutableLeaves
                                                                    error:nil];
        
        NSArray *data = jsonArray[@"data"];
        
        for (NSArray *dataArray in data) {
            
            [_dataSource addObject:[NSArray yy_modelArrayWithClass:[ListDataModel class]
                                                              json:dataArray]];
        }
    }
    
    return _dataSource;
}

@end
