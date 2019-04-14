//
//  CQLoading.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQLoading.h"
#import <Masonry.h>

@interface CQLoading ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation CQLoading

+ (void)showOnView:(UIView *)view {
    [CQLoading showOnView:view info:@""];
}

+ (void)showOnView:(UIView *)view info:(NSString *)info {
    // 先将view上的loading移除
    [CQLoading removeFromView:view];
    
    // 后台返回null，不展示文本（后台不返回null到底有多难？）
    if ([info isKindOfClass:[NSNull class]]) {
        [CQLoading showOnView:view];
        return;
    }
    
    // 正常流程
    CQLoading *loading = [[CQLoading alloc] initWithInfo:info];
    [view addSubview:loading];
    [loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(view);
    }];
}

+ (void)removeFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isMemberOfClass:[CQLoading class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (instancetype)initWithInfo:(NSString *)info {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];;
        
        //------- image view -------//
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        //------- info label -------//
        self.infoLabel = [[UILabel alloc] init];
        [self addSubview:self.infoLabel];
        self.infoLabel.text = info;
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(220);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
            make.centerX.mas_equalTo(self);
        }];
        
        //------- 旋转动画 -------//
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 1;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT;
        [self.imageView.layer addAnimation:animation forKey:nil];
    }
    return self;
}

@end
