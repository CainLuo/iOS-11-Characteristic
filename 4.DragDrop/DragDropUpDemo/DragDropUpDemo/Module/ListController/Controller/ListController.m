//
//  ListController.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListController.h"
#import "ListCell.h"
#import "ListModelCoordinator.h"

#import "FruitStandViewModel.h"

@interface ListController () <UICollectionViewDelegate, UICollectionViewDataSource,
                              UICollectionViewDragDelegate, UICollectionViewDropDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate     = self;
    self.collectionView.dataSource   = self;
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
    
    self.titleLabel.text = self.tipsString;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    NSArray *array = self.fruitStandViewModel.dataSource[self.context];
    
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell"
                                                                   forIndexPath:indexPath];
    
    ListDataModel *model = [self.fruitStandViewModel getDataModelWithIndexPath:indexPath
                                                                       context:self.context];
    
    [listCell configCellWithModel:model];
    
    return listCell;
}

#pragma mark - Collection View Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.frame.size.width, 100);
}

#pragma mark - Collection View Drag Delegate
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView
             itemsForBeginningDragSession:(id<UIDragSession>)session
                              atIndexPath:(NSIndexPath *)indexPath {

    ListModelCoordinator *listModelCoordinator = [[ListModelCoordinator alloc] initWithSource:self.context];

    ListDataModel *dataModel = self.fruitStandViewModel.dataSource[self.context][indexPath.row];
    
    listModelCoordinator.listModel = dataModel;
    
    session.localContext = listModelCoordinator;

    return @[[listModelCoordinator dragItemForIndexPath:indexPath]];
}

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView
              itemsForAddingToDragSession:(id<UIDragSession>)session
                              atIndexPath:(NSIndexPath *)indexPath
                                    point:(CGPoint)point {

    if ([session.localContext class] == [ListModelCoordinator class]) {

        ListModelCoordinator *listModelCoordinator = (ListModelCoordinator *)session.localContext;

        return @[[listModelCoordinator dragItemForIndexPath:indexPath]];
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView
     dragSessionDidEnd:(id<UIDragSession>)session {

    if ([session.localContext class] == [ListModelCoordinator class]) {

        ListModelCoordinator *listModelCoordinator = (ListModelCoordinator *)session.localContext;

        listModelCoordinator.source        = self.context;
        listModelCoordinator.dragCompleted = YES;

        if (!listModelCoordinator.isReordering) {
            
            [collectionView performBatchUpdates:^{
                
                [collectionView deleteItemsAtIndexPaths:listModelCoordinator.sourceIndexPaths];
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - Collection View Drop Delegate
- (BOOL)collectionView:(UICollectionView *)collectionView
  canHandleDropSession:(id<UIDropSession>)session {
    
    return session.localDragSession != nil ? YES : NO;
}

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView
                            dropSessionDidUpdate:(id<UIDropSession>)session
                        withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    
    return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationMove
                                                                intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {

    if (!coordinator.session.localDragSession.localContext) {

        return;
    }

    ListModelCoordinator *listModelCoordinator = (ListModelCoordinator *)coordinator.session.localDragSession.localContext;

    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:[collectionView numberOfItemsInSection:0]
                                                            inSection:0];

    NSIndexPath *indexPath = coordinator.destinationIndexPath ? : destinationIndexPath;
    
    [listModelCoordinator calculateDestinationIndexPaths:indexPath
                                                   count:coordinator.items.count];

    listModelCoordinator.destination = self.context;

    [self moveItemWithCoordinator:listModelCoordinator
performingDropWithDropCoordinator:coordinator];
}

#pragma mark - Private Method
- (void)moveItemWithCoordinator:(ListModelCoordinator *)listModelCoordinator
performingDropWithDropCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {

    NSArray *destinationIndexPaths = listModelCoordinator.destinationIndexPaths;

    if (listModelCoordinator.destination != self.context || !destinationIndexPaths) {

        return;
    }
    
    NSMutableArray *dataSourceArray = [self.fruitStandViewModel deleteModelWithIndexes:listModelCoordinator.sourceIndexes
                                                                               context:listModelCoordinator.source];

    [coordinator.items enumerateObjectsUsingBlock:^(id<UICollectionViewDropItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSIndexPath *sourceIndexPath      = listModelCoordinator.sourceIndexPaths[idx];
        NSIndexPath *destinationIndexPath = destinationIndexPaths[idx];

        [self.collectionView performBatchUpdates:^{

            [self.fruitStandViewModel insertModelWithDataSource:@[dataSourceArray[idx]]
                                                        context:listModelCoordinator.destination
                                                          index:destinationIndexPath.item];
            
            if (listModelCoordinator.isReordering) {
                
                [self.collectionView moveItemAtIndexPath:sourceIndexPath
                                             toIndexPath:destinationIndexPath];

            } else {

                [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
            }

        } completion:^(BOOL finished) {

        }];

        [coordinator dropItem:obj.dragItem
            toItemAtIndexPath:destinationIndexPath];

    }];

    listModelCoordinator.dragCompleted = YES;
}

@end
