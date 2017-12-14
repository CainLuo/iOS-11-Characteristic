//
//  DocumentActivity.m
//  ColorDocument
//
//  Created by Mac on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "DocumentActivity.h"

@implementation DocumentActivity

- (instancetype)initDocumentActivityWithColorDocument:(ColorDocument *)colorDocument {
    
    self = [super init];

    if (self) {
        
        self.colorDocument = colorDocument;
    }
    
    return self;
}

+ (UIActivityCategory)activityCategory {
    
    return UIActivityCategoryAction;
}

- (UIActivityType)activityType {
    return @"ColorBrowserCopy";
}

- (NSString *)activityTitle {
    
    return @"Color Copy";
}

- (UIImage *)activityImage {
    
    return [UIImage imageNamed:@"copy_activity_icon"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    return YES;
}

- (void)performActivity {
    
    [self.colorDocument openWithCompletionHandler:^(BOOL success) {
        
        if (success) {
            
            NSString *string = [self.colorDocument stringRepresentation];
            
            if (string) {
                
                [UIPasteboard generalPasteboard].string = string;
                
                [self activityDidFinish:YES];
            }
        }
    }];
}

@end
