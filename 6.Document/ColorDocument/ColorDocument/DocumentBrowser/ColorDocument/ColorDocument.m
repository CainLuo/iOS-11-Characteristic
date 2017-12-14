//
//  ColorDocument.m
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "ColorDocument.h"

@implementation ColorDocument

- (BOOL)loadFromContents:(id)contents
                  ofType:(NSString *)typeName
                   error:(NSError * _Nullable __autoreleasing *)outError {
    
    NSData *data = (NSData *)contents;
    
    if (!data) {
        
        return NO;
    }
    
    NSString *colorText = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
    
    
    if (colorText.length) {
        
        NSArray *colorValues = [colorText componentsSeparatedByString:@","];
        
        NSInteger redValue   = [colorValues[0] integerValue];
        NSInteger greenValue = [colorValues[1] integerValue];
        NSInteger blueValue  = [colorValues[2] integerValue];
        
        self.colorModel = [[ColorModel alloc] initColorModelWithRedValue:redValue
                                                              greenValue:greenValue
                                                               blueValue:blueValue];
    } else {
        
        NSLog(@"文件格式错误");
    }
    
    return YES;
}

- (id)contentsForType:(NSString *)typeName
                error:(NSError * _Nullable __autoreleasing *)outError {
    
    ColorModel *colorModel = self.colorModel;
    
    if (!colorModel) {
        
        return @"没有颜色";
    }
    
    NSString *colorString = [NSString stringWithFormat:@"%ld,%ld,%ld", colorModel.redValue, colorModel.greenValue, colorModel.blueValue];
    
    NSData *data = [colorString dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

- (NSString *)stringRepresentation {
    
    ColorModel *colorModel = self.colorModel;
    
    if (!colorModel) {
        
        return @"没有颜色";
    }
    
    return [NSString stringWithFormat:@"R: %ld, G: %ld, B: %ld", colorModel.redValue, colorModel.greenValue, colorModel.blueValue];
}

- (NSDictionary *)fileAttributesToWriteToURL:(NSURL *)url
                            forSaveOperation:(UIDocumentSaveOperation)saveOperation
                                       error:(NSError * _Nullable __autoreleasing *)outError {
    
    ColorModel *colorModel = self.colorModel;
    
    if (!colorModel) {
        
        return nil;
    }
    
    CGFloat redValue = colorModel.redValue;
    CGFloat greenValue = colorModel.greenValue;
    CGFloat blueValue = colorModel.blueValue;

    UIColor *color = [UIColor colorWithRed:redValue / 255.0
                                     green:greenValue / 255.0
                                      blue:blueValue / 255.0
                                     alpha:1.0];
    
    UIImage *colorImage = [UIImage cl_getImageWithColor:color];
        
    NSDictionary *dictionary = @{NSURLHasHiddenExtensionKey:@(YES),
                                 NSURLThumbnailDictionaryKey:@{NSThumbnail1024x1024SizeKey:colorImage}};
    
    return dictionary;
}

@end
