//
//  TableViewCell.m
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "TableViewCell.h"
#import "MenuManager.h"

@interface TableViewCell ()

@property (nonatomic, strong) MenuManager *menuManager;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addGestureRecognizer:self.menuManager.longPressGestureRecognizer];
        [self addGestureRecognizer:self.menuManager.tapGestureRecognizer];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self addGestureRecognizer:self.menuManager.longPressGestureRecognizer];
        [self addGestureRecognizer:self.menuManager.tapGestureRecognizer];
    }
    
    return self;
}

- (void)setModel:(TableViewCellModel *)model {
    
    if (model) {
        
        _model = model;
        
        self.textLabel.text = [NSString stringWithFormat:@"IndexPath: %@", model.titleString];
    }
}

- (MenuManager *)menuManager {
    
    if (!_menuManager) {
        
        _menuManager = [[MenuManager alloc] initWithView:self];
    }
    
    return _menuManager;
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (BOOL)canPerformAction:(SEL)action
              withSender:(id)sender {
    
    return action == @selector(copy:);
}

- (void)copy:(id)sender {
    
    if (self.model == nil) {
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    
    [[UIPasteboard generalPasteboard] setData:data
                            forPasteboardType:CELL_TYPE];
}

@end
