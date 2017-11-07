//
//  PasteViewController.m
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "PasteViewController.h"
#import "MenuManager.h"
#import "TableViewCellModel.h"

@interface PasteViewController ()

@property (nonatomic, strong) UITextField *targetTextField;

@property (nonatomic, strong) MenuManager *menuManager;

@end

@implementation PasteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.targetTextField];
    [self.view addGestureRecognizer:self.menuManager.longPressGestureRecognizer];
    [self.view addGestureRecognizer:self.menuManager.tapGestureRecognizer];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPasteConfiguration *pasteConfiguration = [[UIPasteConfiguration alloc] initWithAcceptableTypeIdentifiers:@[CELL_TYPE]];
        
    self.pasteConfiguration = pasteConfiguration;
}

- (UITextField *)targetTextField {
    
    if (!_targetTextField) {
        
        _targetTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 30)];
        
        _targetTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        [_targetTextField addTarget:self
                             action:@selector(targetTextFieldAction:)
                   forControlEvents:UIControlEventEditingChanged];
        [_targetTextField becomeFirstResponder];
    }
    
    return _targetTextField;
}

- (void)targetTextFieldAction:(UITextField *)textField {
    
    NSLog(@"%@", textField.text);
}

- (MenuManager *)menuManager {
    
    if (!_menuManager) {
        
        _menuManager = [[MenuManager alloc] initWithView:self.view];
    }
    
    return _menuManager;
}

- (void)pasteItemProviders:(NSArray<NSItemProvider *> *)itemProviders {
    
    for (NSItemProvider *item in itemProviders) {
        
        [item loadObjectOfClass:TableViewCellModel.class
              completionHandler:^(id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                 
                 if (object) {
                     
                     TableViewCellModel *model = (TableViewCellModel *)object;
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         self.targetTextField.text = [NSString stringWithFormat:@"复制的内容: %@", model.titleString];
                     });
                 }
             }];
    }
}

@end
