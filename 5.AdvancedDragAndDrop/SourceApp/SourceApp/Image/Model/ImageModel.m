//
//  ImageModel.m
//  SourceApp
//
//  Created by Cain Luo on 2017/12/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ImageModel.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define IMAGE_TYPE @"com.image.model"

@implementation ImageModel

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image {
    
    self.title = title;
    self.image = image;

    self = [super init];

    return self;
}

- (instancetype)initWithImageModel:(ImageModel *)imageModel {
    
    self.title = imageModel.title;
    self.image = imageModel.image;
    
    return self;
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    UIImage *image  = [UIImage imageWithData:[aDecoder decodeObjectForKey:@"image"]];
    NSString *title = [aDecoder decodeObjectForKey:@"title"];

    return [self initWithTitle:title image:image];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:UIImagePNGRepresentation(self.image)
                  forKey:@"image"];
    [aCoder encodeObject:self.title
                  forKey:@"title"];
}

#pragma mark - Item Provider Reading Protocol
+ (nullable instancetype)objectWithItemProviderData:(NSData *)data
                                     typeIdentifier:(NSString *)typeIdentifier
                                              error:(NSError **)outError {
    if ([typeIdentifier isEqualToString:IMAGE_TYPE]) {
        
        ImageModel *imageModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return [[self alloc] initWithImageModel:imageModel];
    }
    
    return nil;
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    
    return @[IMAGE_TYPE];
}

#pragma mark - Item Provider Writing Protocol
- (nullable NSProgress *)loadDataWithTypeIdentifier:(NSString *)typeIdentifier
                   forItemProviderCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypePNG]) {
        
        NSData *imageData = UIImagePNGRepresentation(self.image);
        
        if (imageData) {
            
            completionHandler(imageData, nil);
        } else {
            
            completionHandler(nil, nil);
        }
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypePlainText]) {
        
        completionHandler([self.title dataUsingEncoding:NSUTF8StringEncoding], nil);
        
    } else if ([typeIdentifier isEqualToString:IMAGE_TYPE]) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        
        completionHandler(data, nil);
    }
    
    return nil;
}

+ (NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    
    return @[IMAGE_TYPE, (__bridge NSString *)kUTTypePNG, (__bridge NSString *)kUTTypePlainText];
}

@end
