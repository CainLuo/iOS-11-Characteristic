//
//  ListController.m
//  LayoutDemo
//
//  Created by Cain Luo on 2017/11/8.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListController.h"
#import "LayoutController.h"
#import "ScrollController.h"
#import "StackViewController.h"

@interface ListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.title = NSStringFromClass(self.class);
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.tableView.refreshControl addTarget:self
                                      action:@selector(refreshControllerAction)
                            forControlEvents:UIControlEventValueChanged];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.navigationItem.searchController = searchController;
//    self.navigationItem.hidesSearchBarWhenScrolling = NO;

    // 修改安全区域
//    self.additionalSafeAreaInsets = UIEdgeInsetsMake(100, 50, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    // Insets
//    self.tableView.separatorInsetReference = UITableViewSeparatorInsetFromAutomaticInsets;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 30, 0, 30);
}

- (void)refreshControllerAction {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.refreshControl endRefreshing];
    });
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    NSLog(@"%f", self.view.safeAreaInsets.top);
    NSLog(@"%f", self.view.safeAreaInsets.left);
}

- (UITableView *)tableView {
    
    if (!_tableView) {
    
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return 20;
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

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    if (indexPath.row == 0) {
        
        LayoutController *layoutController = [[LayoutController alloc] init];

        [self.navigationController pushViewController:layoutController
                                             animated:YES];
    } else if (indexPath.row == 1) {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Scroll"
                                                             bundle:nil];
        
        ScrollController *scrollController = [storyboard instantiateViewControllerWithIdentifier:@"ScrollController"];

        [self.navigationController pushViewController:scrollController
                                             animated:YES];
    } else if (indexPath.row == 2) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Stack"
                                                             bundle:nil];
        
        StackViewController *stackViewController = [storyboard instantiateViewControllerWithIdentifier:@"StackViewController"];
        
        [self.navigationController pushViewController:stackViewController
                                             animated:YES];
    }
}

@end
