//
//  UIView+HYView.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HYView)


/// 设置圆角
/// @param cornerRadii 圆角大小
/// @param corner 哪些角
-(void)setCornerWithRadii:(CGSize)cornerRadii byRoundCornorners:(UIRectCorner)corner;


/// 添加点击事件
/// @param target target
/// @param action action
- (UIGestureRecognizer*)addTarget:(id)target tapAction:(SEL)action;

/// x值
-(CGFloat)x;

/// y值
-(CGFloat)y;

/// 宽度
-(CGFloat)width;

/// 高度
-(CGFloat)height;

/// 设置x值
/// @param pointX x值
-(void)setX:(CGFloat)pointX;

/// 设置y值
/// @param pointY y值
-(void)setY:(CGFloat)pointY;

/// 设置宽度
/// @param width 宽
-(void)setWidth:(CGFloat)width;


/// 设置高度
/// @param height 高
-(void)setHeight:(CGFloat)height;


/// 获取view对应的UIViewController
- (UIViewController *)getController;

@end

NS_ASSUME_NONNULL_END
