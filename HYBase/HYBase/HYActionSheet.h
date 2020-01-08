//
//  HYActionSheet.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HYActionSheetBlock)(NSInteger index);

@interface HYActionSheet : UIView


/// 获取默认的ActionSheet
/// @param titles 提示问题
/// @param block 回调
+ (instancetype)sheetWithTitles:(NSArray*)titles block:(HYActionSheetBlock)block;


/// 获取默认的ActionSheet
/// @param title 标题
/// @param cancelTitle 取消按钮文字
/// @param titles 选项文字数组
/// @param block 选择回调
+ (instancetype)sheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherTitles:(NSArray*)titles block:(HYActionSheetBlock)block;


/// 获取ActionSheet 带有副标题
/// @param title 标题
/// @param cancelTitle 取消按钮文字
/// @param titles 选项文字数组
/// @param subTitles 副标题
/// @param block 选择回调
+ (instancetype)sheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherTitles:(NSArray*)titles subTitles:(NSArray*)subTitles block:(HYActionSheetBlock)block;


/// 显示ActionSheet
- (void)show;


/// 隐藏ActionSheet
- (void)cancel;


@end

NS_ASSUME_NONNULL_END
