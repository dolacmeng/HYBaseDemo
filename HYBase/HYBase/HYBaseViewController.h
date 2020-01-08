//
//  HYBaseViewController.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseViewController : UIViewController

/// 显示加载菊花
/// @param text 加载文字提示
-(void)showHudWithText:(NSString *)text;


/// 隐藏加载菊花
-(void)hideHud;


/// Toast提醒
/// @param text Toast文字
-(void)showToastWithText:(NSString *)text;


/// 显示对话框（只有一个确定按钮，点击关闭对话框）
/// @param content 对话框文字
-(void)showDialog:(NSString*)content;


/// 显示对话框
/// @param content 对话框文字
/// @param title 确定按钮文字
/// @param cancelTitle 取消按钮文字
/// @param confrim 确定点击回调
/// @param cancel 取消点击回调
-(void)showDialog:(NSString *)content confirmTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle confirm:(void(^)(void))confrim cancel:(void(^)(void))cancel;


/// 获取当前控制器
+ (UIViewController *)getCurrentVC;


/// 返回多个控制器
/// @param count 页面个数
-(void)popMoreVC:(NSInteger)count;


/// 替换当前控制器
/// @param vc 需要替换的新控制器
-(void)replaceVC:(UIViewController*)vc;

@end

NS_ASSUME_NONNULL_END
