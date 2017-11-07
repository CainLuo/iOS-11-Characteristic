//
//  ListModel.m
//  DragAndDropDemo
//
//  Created by Cain Luo on 2017/11/7.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (instancetype)initWithTitleString:(NSString *)titleString {
    
    self = [super init];
    
    if (self) {
        
        self.titleString = titleString;
    }
    
    return self;
}

#pragma mark - Item Provider Reading Protocol
+ (nullable instancetype)objectWithItemProviderData:(NSData *)data
                                     typeIdentifier:(NSString *)typeIdentifier
                                              error:(NSError **)outError {
    if ([typeIdentifier isEqualToString:LIST_TYPE]) {
        
        ListModel *modelData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return [[self alloc] initWithTitleString:modelData.titleString];
    }
    
    return nil;
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    
    return @[LIST_TYPE];
}

#pragma mark - Item Provider Writing Protocol
- (nullable NSProgress *)loadDataWithTypeIdentifier:(NSString *)typeIdentifier
                   forItemProviderCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    if ([typeIdentifier isEqualToString:LIST_TYPE]) {
        
        NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:self];
        
        completionHandler(modelData, nil);
    }
    
    return nil;
}

+ (NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    
    return @[LIST_TYPE];
}

@end
