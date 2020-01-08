//
//  HYBaseTableView.m
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import "HYBaseTableView.h"
#import "MJRefresh.h"

@implementation HYBaseTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.tableFooterView = [UIView new];
}

-(void)refreshWithBlock:(void(^)(void))block{
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo=1;
        [weakSelf hideEmptyViewWithText];
        [weakSelf.mj_footer setHidden:NO];
        block();
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"卖力加载中..." forState:MJRefreshStateRefreshing];
    header.automaticallyChangeAlpha = YES;
    self.mj_header = header;
}

-(void)refreshBegin{
    [self.mj_footer setHidden:YES];
    [self.mj_header beginRefreshing];
}

-(void)loadMoreWithBlock:(void(^)(void))block{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo++;
        block();
    }];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已全部加载完" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

-(void)refreshEnd{
     [self.mj_header endRefreshing];
}

-(void)refreshEndWithNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

-(void)resetRefreshEndWithNoMoreData{
    [self.mj_footer resetNoMoreData];
}

-(void)loadMoreEnd{
    [self.mj_footer endRefreshing];
}

-(void)hideLoadMore{
    self.mj_footer.hidden = YES;
}

-(void)showLoadMore{
    self.mj_footer.hidden = NO;
}

-(NSInteger)pageNo{
    if (_pageNo == 0) {
        return 1;
    }
    return _pageNo;
}


-(UIView*)emptyView{
    if (_emptyView == nil) {
        _emptyView = [[UIView alloc] initWithFrame:self.bounds];
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.width/2-100, kSCREENW, 20)];
        [text setFont:[UIFont systemFontOfSize:16]];
        [text setTextColor:[UIColor grayColor]];
        [text setTextAlignment:NSTextAlignmentCenter];
        text.tag = [@"tipText" hash];
        [_emptyView addSubview:text];
    }
    return _emptyView;
}

-(void)showEmptyViewWithText:(NSString*)text{
    self.mj_footer.hidden = YES;
    UILabel *label = [self.emptyView viewWithTag:[@"tipText" hash]];
    label.text = text;
    self.tableFooterView = self.emptyView;
}

-(void)hideEmptyViewWithText{
    self.tableFooterView = [UIView new];
}


@end

