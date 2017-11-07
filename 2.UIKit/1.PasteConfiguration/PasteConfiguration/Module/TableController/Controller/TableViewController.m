//
//  TableViewController.m
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "TableViewCellModel.h"

#import "PasteViewController.h"
#import "MenuManager.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MenuManager *menuManager;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.menuManager.longPressGestureRecognizer];
    [self.view addGestureRecognizer:self.menuManager.tapGestureRecognizer];
    
    [self.view addSubview:self.tableView];
    
    TableViewCellModel *model1 = [[TableViewCellModel alloc] initTitleString:@"Name 1"];
    TableViewCellModel *model2 = [[TableViewCellModel alloc] initTitleString:@"Name 2"];
    TableViewCellModel *model3 = [[TableViewCellModel alloc] initTitleString:@"Name 3"];
    TableViewCellModel *model4 = [[TableViewCellModel alloc] initTitleString:@"Name 4"];

    self.dataSource = @[model1, model2, model3, model4];
    
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        
        _tableView.delegate   = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (MenuManager *)menuManager {
    
    if (!_menuManager) {
        
        _menuManager = [[MenuManager alloc] initWithView:self.view];
    }
    
    return _menuManager;
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];

    if (!cell) {
        
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"TableViewCell"];
    }
    
    TableViewCellModel *model = self.dataSource[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];

    PasteViewController *pasteViewController = [[PasteViewController alloc] init];

    [self.navigationController pushViewController:pasteViewController
                                         animated:YES];
}

@end
