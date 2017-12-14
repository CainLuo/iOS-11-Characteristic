//
//  DocumentBrowserController.h
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ColorDocument.h"

@interface DocumentBrowserController : UIDocumentBrowserViewController

- (void)presentColorControllerWithDocument:(ColorDocument *)colorDocument;

@end
