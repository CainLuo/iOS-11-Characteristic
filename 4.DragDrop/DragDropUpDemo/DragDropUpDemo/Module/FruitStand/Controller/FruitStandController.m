//
//  FruitStandController.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "FruitStandController.h"
#import "ListController.h"
#import "FruitStandViewModel.h"

@interface FruitStandController ()

@property (nonatomic, strong) FruitStandViewModel *fruitStandViewModel;

@end

@implementation FruitStandController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    NSString *segueIdentifier = segue.identifier;
    ListController *controller = (ListController *)segue.destinationViewController;
    
    if ([segueIdentifier isEqualToString:@"StandIdetifier"]) {
        
        controller.tipsString          = @"水果摊";
        controller.context             = ListModelStandType;
        controller.fruitStandViewModel = self.fruitStandViewModel;

    } else {
        
        controller.tipsString          = @"购物车";
        controller.context             = ListModelShoppingType;
        controller.fruitStandViewModel = self.fruitStandViewModel;
    }
}

- (FruitStandViewModel *)fruitStandViewModel {
    
    if (!_fruitStandViewModel) {
        
        _fruitStandViewModel = [[FruitStandViewModel alloc] initFruitStandViewModelWithController:self];
    }
    
    return _fruitStandViewModel;
}

@end
