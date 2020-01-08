//
//  HYBaseTableView.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseTableView : UITableView

@property(nonatomic,assign) NSInteger pageNo;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,strong) UIView *emptyView;

/** 设置下拉刷新
 * @block 下拉刷新block
 */
-(void)refreshWithBlock:(void(^)(void))block;

/** 设置上垃加载更多
 * @block 下拉刷新block
 */
-(void)loadMoreWithBlock:(void(^)(void))block;

/** 开始刷新 */
-(void)refreshBegin;

/** 设置刷新结束 */
-(void)refreshEnd;

/** 设置刷新结束并提示已经加载完 */
-(void)refreshEndWithNoMoreData;

/** 取消已经加载完 */
-(void)resetRefreshEndWithNoMoreData;

/** 加载更多结束 */
-(void)loadMoreEnd;

/** 暂时隐藏加载更多 */
-(void)hideLoadMore;

/** 显示加载更多 */
-(void)showLoadMore;

-(void)showEmptyViewWithText:(NSString*)text;
-(void)hideEmptyViewWithText;
@end


NS_ASSUME_NONNULL_END
