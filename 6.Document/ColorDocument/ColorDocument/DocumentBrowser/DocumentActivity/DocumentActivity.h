//
//  DocumentActivity.h
//  ColorDocument
//
//  Created by Mac on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorDocument.h"

@interface DocumentActivity : UIActivity

@property (nonatomic, strong) ColorDocument *colorDocument;

- (instancetype)initDocumentActivityWithColorDocument:(ColorDocument *)colorDocument;

@end
