//
//  TableViewCellModel.m
//  2.UIKitDemo
//
//  Created by Cain Luo on 2017/11/6.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel

@dynamic readableTypeIdentifiersForItemProvider;

- (instancetype)initTitleString:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        self.titleString = title;
    }
    
    return self;
}

+ (instancetype)objectWithItemProviderData:(NSData *)data
                            typeIdentifier:(NSString *)typeIdentifier
                                     error:(NSError * _Nullable __autoreleasing *)outError {
    
    if ([typeIdentifier isEqualToString:CELL_TYPE]) {
        
        TableViewCellModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return [[self alloc] initTitleString:model.titleString];
    }
    
    return nil;
}

+ (NSArray *)readableTypeIdentifiersForItemProvider {
    return @[CELL_TYPE];
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.titleString = [aDecoder decodeObjectForKey:@"titleString"];
    }
    
    return self;
}

@end
