//
//  ImageDragView.m
//  SourceApp
//
//  Created by Cain Luo on 2017/12/12.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ImageDragView.h"

@implementation ImageDragView

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image {
 
    self = [super initWithFrame:CGRectMake(0, 0, 200, 240)];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.font = [UIFont systemFontOfSize:18];
        
        [NSLayoutConstraint activateConstraints:@[[imageView.widthAnchor constraintEqualToConstant:180],
                                                  [imageView.heightAnchor constraintEqualToConstant:180]]];
        
        titleLabel.text = title;

        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[titleLabel, imageView]];
        
        stackView.alignment     = UIStackViewAlignmentCenter;
        stackView.axis          = UILayoutConstraintAxisVertical;
        stackView.clipsToBounds = YES;
        
        stackView.frame = CGRectMake(self.bounds.origin.x,
                                     self.bounds.origin.y,
                                     self.bounds.size.width,
                                     self.bounds.size.height - 20);

        [self addSubview:stackView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
    }
    
    return self;
}

@end
