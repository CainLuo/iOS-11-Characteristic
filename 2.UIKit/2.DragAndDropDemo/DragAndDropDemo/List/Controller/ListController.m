//
//  ListController.m
//  DragAndDropDemo
//
//  Created by Cain Luo on 2017/11/7.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListController.h"
#import "ListModel.h"

@interface ListController () <UITableViewDelegate, UITableViewDataSource,
                              UITableViewDragDelegate, UITableViewDropDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ListModel *model1 = [[ListModel alloc] initWithTitleString:@"Name 1"];
    ListModel *model2 = [[ListModel alloc] initWithTitleString:@"Name 2"];
    ListModel *model3 = [[ListModel alloc] initWithTitleString:@"Name 3"];
    ListModel *model4 = [[ListModel alloc] initWithTitleString:@"Name 4"];
    ListModel *model5 = [[ListModel alloc] initWithTitleString:@"Name 5"];
    ListModel *model6 = [[ListModel alloc] initWithTitleString:@"Name 6"];
    ListModel *model7 = [[ListModel alloc] initWithTitleString:@"Name 7"];
    
    [self.dataSource addObjectsFromArray:@[model1, model2, model3, model4, model5, model6, model7]];
    
    [self.view addSubview:self.tableView];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        _tableView.dragDelegate = self;
        _tableView.dropDelegate = self;
        _tableView.dragInteractionEnabled = YES;
    }
    
    return _tableView;
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    
    ListModel *model = self.dataSource[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"IndexPath: %@", model.titleString];
    
    return cell;
}

#pragma mark - Table View Drag Delegate
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView
        itemsForBeginningDragSession:(id<UIDragSession>)session
                         atIndexPath:(NSIndexPath *)indexPath {
    
    ListModel *model = self.dataSource[indexPath.row];
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:model];
    
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    
    return @[dragItem];
}

#pragma mark - Table View Drop Delegate
- (void)tableView:(UITableView *)tableView
performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator {
    
    if (!coordinator) {
        return;
    }
    
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    
    [tableView performBatchUpdates:^{
        
        [coordinator.items enumerateObjectsUsingBlock:^(id<UITableViewDropItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (!obj) {
                return;
            }
            
            NSIndexPath *indexPath = obj.sourceIndexPath;
            
            ListModel *model = self.dataSource[indexPath.row];
            
            [self.dataSource removeObject:model];
            [self.dataSource insertObject:model
                                  atIndex:destinationIndexPath.row];
            
            [tableView moveRowAtIndexPath:indexPath
                              toIndexPath:destinationIndexPath];
        }];
        
    } completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView
canHandleDropSession:(id<UIDropSession>)session {
    return [session canLoadObjectsOfClass:ListModel.class];
}

- (UITableViewDropProposal *)tableView:(UITableView *)tableView
                  dropSessionDidUpdate:(id<UIDropSession>)session
              withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath {
    
    return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove
                                                           intent:UITableViewDropIntentInsertAtDestinationIndexPath];
}

@end
