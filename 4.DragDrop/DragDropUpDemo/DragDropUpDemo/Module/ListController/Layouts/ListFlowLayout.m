//
//  ListFlowLayout.m
//  DragDropUpDemo
//
//  Created by Cain Luo on 2017/11/11.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "ListFlowLayout.h"

@implementation ListFlowLayout

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    
    if (self.collectionView.bounds.size.width != newBounds.size.width && self.collectionView.bounds.size.height != newBounds.size.height) {
        
        return context;
    } else {
        
        UICollectionViewFlowLayoutInvalidationContext *invalidationContext = (UICollectionViewFlowLayoutInvalidationContext *)context;
        
        invalidationContext.invalidateFlowLayoutDelegateMetrics = YES;
        
        return invalidationContext;
    }
}

@end
