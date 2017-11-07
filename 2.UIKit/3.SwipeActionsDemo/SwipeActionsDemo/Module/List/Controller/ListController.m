//
//  ListController.m
//  SwipeActionsDemo
//
//  Created by Cain Luo on 2017/11/7.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListController.h"

@interface ListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"IndexPath: %ld", indexPath.row];
    
    return cell;
}

#pragma mark - Table View Swipe Actions Configuration
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *contextualAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                   title:@"Add"
                                                                                 handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                     
                                                                                     NSLog(@"Add");
                                                                                 }];
    
    contextualAction.backgroundColor = [UIColor brownColor];
    
    UISwipeActionsConfiguration *swipeActionsCOnfiguration = [UISwipeActionsConfiguration configurationWithActions:@[contextualAction]];
    
    return swipeActionsCOnfiguration;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *contextualAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                   title:@"Copy"
                                                                                 handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                     
                                                                                     NSLog(@"Copy");
                                                                                 }];
    
    contextualAction.backgroundColor = [UIColor blackColor];
    
    UISwipeActionsConfiguration *swipeActionsCOnfiguration = [UISwipeActionsConfiguration configurationWithActions:@[contextualAction]];
    
    return swipeActionsCOnfiguration;
}

@end
