//
//  CQToast.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQToast.h"
#import <Masonry.h>

// 如果没有设置，toast的默认展示时间为2秒
static NSTimeInterval defaultShowTime = 2;
// 默认背景颜色
static UIColor *defaultBackgroundColor;

@implementation CQToast

#pragma mark - 纯文本toast提示

/** 纯文本toast提示 */
+ (void)showWithMessage:(NSString *)message {
    [CQToast showWithMessage:message duration:defaultShowTime];
}

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    defaultBackgroundColor = defaultBackgroundColor ?: [[UIColor blackColor] colorWithAlphaComponent:0.9];
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = defaultBackgroundColor;
    bgView.layer.cornerRadius = 5;
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.top.left.mas_equalTo(label).mas_offset(-20);
        make.bottom.right.mas_equalTo(label).mas_offset(20);
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(140);
        make.center.mas_equalTo(label.superview);
    }];
    
    // duration秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - 图文toast提示
/** 图文toast提示 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName {
    [CQToast showWithMessage:message image:imageName duration:defaultShowTime];
}

+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration {
    defaultBackgroundColor = defaultBackgroundColor ?: [[UIColor blackColor] colorWithAlphaComponent:0.9];
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = defaultBackgroundColor;
    bgView.layer.cornerRadius = 5;
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:22];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(label.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - 默认设置

/** 设置默认展示时间 */
+ (void)setDefaultShowTime:(NSTimeInterval)time {
    defaultShowTime = time;
}

/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)color {
    defaultBackgroundColor = color;
}

@end
