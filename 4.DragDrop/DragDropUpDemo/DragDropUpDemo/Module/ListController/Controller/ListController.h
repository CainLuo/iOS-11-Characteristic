//
//  ListController.h
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDataModel.h"
#import "FruitStandViewModel.h"

@interface ListController : UIViewController

@property (nonatomic, strong) NSString *tipsString;

@property (nonatomic, assign) ListModelType context;

@property (nonatomic, strong) FruitStandViewModel *fruitStandViewModel;

@end
