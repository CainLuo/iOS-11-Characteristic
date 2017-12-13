//
//  ImageModel.h
//  SourceApp
//
//  Created by Cain Luo on 2017/12/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageModel : NSObject <NSItemProviderReading, NSItemProviderWriting, NSCoding>

- (instancetype)initWithImageModel:(ImageModel *)imageModel;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end
