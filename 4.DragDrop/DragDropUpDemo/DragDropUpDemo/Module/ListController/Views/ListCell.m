//
//  ListCell.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListCell.h"

@interface ListCell ()

@property (weak, nonatomic) IBOutlet UILabel *fruitNameLabel;

@end

@implementation ListCell

- (void)configCellWithModel:(ListDataModel *)model {
    
    if (model) {
        
        self.fruitNameLabel.text = model.name;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
