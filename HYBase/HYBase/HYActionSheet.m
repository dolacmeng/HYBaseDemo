//
//  HYActionSheet.m
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import "HYActionSheet.h"
#import "UIView+HYView.h"

#define PCColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

CGFloat const HYActionSheetLeftMargin = 5;
CGFloat const HYActionSheetTopMargin = 5;
CGFloat const HYActionSheetButtonHeight = 50;
CGFloat const HYActionSheetButtonHeightAndPadding = 50.5;
CGFloat const HYActionSheetItemViewWithSubTitleHeightAndPadding = 60.5;

@interface HYActionSheet()

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *cancelTitle;
@property(nonatomic,copy) NSArray *otherTitles;
@property(nonatomic,copy) NSArray *subTitles;
@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,copy) HYActionSheetBlock block;

@end

@implementation HYActionSheet

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor= [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.5];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(clickBg:)];
        [self addGestureRecognizer:tap];
    
    }
    return self;
}

+ (instancetype)sheetWithTitles:(NSArray*)titles block:(HYActionSheetBlock)block{
    return [self sheetWithTitle:nil cancelTitle:nil otherTitles:titles block:block];
}

+ (instancetype)sheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherTitles:(NSArray*)titles block:(HYActionSheetBlock)block{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    HYActionSheet *sheet = [[HYActionSheet alloc] initWithFrame:window.bounds];
    sheet.title = title;
    sheet.cancelTitle = cancelTitle;
    sheet.otherTitles = titles;
    sheet.subTitles = nil;
    sheet.block = block;
    [sheet setUpView];
    return sheet;
}

+ (instancetype)sheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherTitles:(NSArray*)titles subTitles:(NSArray*)subTitles block:(HYActionSheetBlock)block{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    HYActionSheet *sheet = [[HYActionSheet alloc] initWithFrame:window.bounds];
    sheet.title = title;
    sheet.cancelTitle = cancelTitle;
    sheet.otherTitles = titles;
    sheet.subTitles = subTitles;
    sheet.block = block;
    [sheet setUpView];
    return sheet;
}

- (void)setUpView{
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:scrollView];
    
    __block CGFloat commonY = 0.f;
    CGFloat labelH = 0.0;
    //标题
    if (self.title) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font= [UIFont systemFontOfSize:15];
        titleLabel.textColor= [UIColor blackColor];
        titleLabel.numberOfLines=0;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.text=self.title;
        titleLabel.backgroundColor = [UIColor whiteColor];
        labelH = [self.title boundingRectWithSize:CGSizeMake(self.bounds.size.width -2 * HYActionSheetLeftMargin, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:titleLabel.font}
                                              context:nil].size.height + 20;
        titleLabel.frame = CGRectMake(0,commonY-1,self.bounds.size.width,labelH);
        [contentView addSubview:titleLabel];
//        commonY += (labelH+1);
    }

    //选项
    if (self.subTitles == nil) {
        [self.otherTitles enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item isKindOfClass:[NSString class]]) {
                UIButton *button = [self buttonWithTitle:item y:commonY];
                button.tag = idx;
                [scrollView addSubview:button];
                commonY += HYActionSheetButtonHeightAndPadding;
            }else if([item isKindOfClass:[UIView class]]){
                UIView *view = (UIView*)item;
                view.x = 0;
                view.y = commonY;
                commonY += view.height;
                [scrollView addSubview:view];
            }
        }];
    }else{
        NSCAssert(self.otherTitles.count == self.subTitles.count, @"self.otherTitles.count must equal to self.subTitles.count!");
        for (int i = 0; i<self.otherTitles.count; i++) {
            UIView *view = [self viewWithTitle:self.otherTitles[i] subTitle:self.subTitles[i] index:i];
            [contentView addSubview:view];
            commonY += HYActionSheetItemViewWithSubTitleHeightAndPadding;
        }
       
    }
    
    [scrollView setFrame:CGRectMake(0, labelH, self.bounds.size.width, MIN(commonY,400))];
    [scrollView setContentSize:CGSizeMake(self.bounds.size.width, commonY)];
    
    //取消按钮
    UIButton *canelButton = [self buttonWithTitle:self.cancelTitle?:@"取消" y:MIN(commonY, 400)+labelH+10];
    canelButton.tag = -1;
    [contentView addSubview:canelButton];
    
    //设置acitonSheet的frame，隐藏在屏幕之下
    contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, MIN(commonY, 400)+labelH+HYActionSheetButtonHeight+10);
    
}

- (void)show{
    
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y - self.contentView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }];
    
}

- (void)cancel{
    
    CGRect frame= self.contentView.frame;
    frame.origin.y+=frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame=frame;
        self.alpha=0.1;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


#pragma mark - Action

- (void)clickButton:(UIButton*)button{
    if (self.block) {
        self.block(button.tag);
    }
    [self cancel];
}

- (void)clickBg:(UITapGestureRecognizer*)tap{
    [self cancel];
}


#pragma mark - priate method
-(UIView*)viewWithTitle:(NSString*)title subTitle:(NSString*)subTitle index:(NSInteger)index{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, index * HYActionSheetItemViewWithSubTitleHeightAndPadding, self.bounds.size.width, HYActionSheetItemViewWithSubTitleHeightAndPadding-0.5)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, view.frame.size.width, 34)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = index==0?[UIColor colorWithRed:0.0/255.0 green:166.0/255.0 blue:255.0/255.0 alpha:1.f]:[self colorWithHex:333333];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)-8, titleLabel.frame.size.width, 32)];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textColor = [UIColor grayColor];
    subTitleLabel.text = subTitle;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:subTitleLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
    button.tag = index;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
-(UIButton*)buttonWithTitle:(NSString*)title y:(CGFloat)y{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, y, self.bounds.size.width, HYActionSheetButtonHeight)];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[self colorWithHex:333333] forState:0];
    [button setTitle:title forState:0];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

- (UIColor *)colorWithHex:(unsigned)hex
{
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0 green:((hex & 0xFF00) >> 8) / 255.0 blue:(hex & 0xFF) / 255.0 alpha:1];
}


@end
