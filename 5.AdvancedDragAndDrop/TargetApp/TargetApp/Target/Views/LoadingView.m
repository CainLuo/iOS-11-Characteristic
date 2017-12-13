//
//  LoadingView.m
//  TargetApp
//
//  Created by Cain Luo on 2017/12/13.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, strong) NSProgress *progress;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
                     progress:(NSProgress *)progress {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.progress = progress;
        
        [self.progress addObserver:self
                        forKeyPath:@"fractionCompleted"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
        
        [self addConstraintsWithSuperView];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    NSProgress *progress = (NSProgress *)object;
    
    if (!progress) {
        return;
    }
    
    NSInteger percentComplete = round(progress.fractionCompleted * 100);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.progressLabel.text = [NSString stringWithFormat:@"%ld%%", percentComplete];
    });
}

- (UIVisualEffectView *)blurView {
    
    if (!_blurView) {
        
        UIBlurEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        _blurView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
        _blurView.frame = self.bounds;
        _blurView.translatesAutoresizingMaskIntoConstraints = YES;
    }
    
    return _blurView;
}

- (UILabel *)progressLabel {
    
    if (!_progressLabel) {
        
        _progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
        
        _progressLabel.text          = @"0%";
        _progressLabel.font          = [UIFont systemFontOfSize:60];
        _progressLabel.textColor     = [UIColor whiteColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _progressLabel;
}

- (void)addConstraintsWithSuperView {
    
    [self addSubview:self.blurView];
    [self addSubview:self.progressLabel];
}

- (void)dealloc {
    
    [self.progress removeObserver:self
                       forKeyPath:@"fractionCompleted"];
}

@end
