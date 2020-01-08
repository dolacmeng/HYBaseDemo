//
//  HYBaseViewController.m
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import "HYBaseViewController.h"
#import "MBProgressHUD.h"

@interface HYBaseViewController ()

@property(nonatomic,strong) MBProgressHUD *hud;

@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//显示HUD
-(void)showHudWithText:(NSString *)text{
    [self.view endEditing:YES];
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!ws.hud) {
            ws.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
        ws.hud.margin = 25.f;
        ws.hud.labelFont = [UIFont fontWithName:@"PingFangSC-Light" size:15];
        ws.hud.mode = MBProgressHUDModeIndeterminate;
        ws.hud.labelText = text;
    });
}

//隐藏hud
-(void)hideHud{
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws.hud hide:YES];
        ws.hud = nil;
    });
}

//显示Toast
-(void)showToastWithText:(NSString *)text{
    [self.view endEditing:YES];
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    [self.view addSubview:_hud];
    _hud.labelText = text;
    _hud.mode = MBProgressHUDModeText;
    _hud.margin = 20.f;
    _hud.labelFont =  [UIFont fontWithName:@"PingFangSC-Light" size:15];
    //显示时间
    _hud.minShowTime = 1.0f;
    [_hud show:YES];
    [_hud hide:YES];
    _hud = nil;
}

-(void)showDialog:(NSString*)content{
    UIAlertController *dialog = [UIAlertController alertControllerWithTitle:@"提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [dialog addAction:confirm];
    [self presentViewController:dialog animated:YES completion:nil];
}

-(void)showDialog:(NSString *)content confirmTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle confirm:(void(^)(void))confrim cancel:(void(^)(void))cancel{
    UIAlertController *dialog = [UIAlertController alertControllerWithTitle:@"提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle?:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cancel();
        }];
        [dialog addAction:cancelAction];
    }
    
    if (title.length) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:title?:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            confrim();
        }];
        [dialog addAction:confirmAction];
    }
    
    [self presentViewController:dialog animated:YES completion:nil];
}

-(void)popMoreVC:(NSInteger)count{
    NSUInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-count)] animated:YES];
}
-(void)replaceVC:(UIViewController*)vc{
    [self replaceVC:vc animated:YES];
}

-(void)replaceVC:(UIViewController*)vc animated:(BOOL)animated{
    // 获取当前路由的控制器数组
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    // 获取档期控制器在路由的位置
    int index = (int)[vcArray indexOfObject:self];
    if (index >= 0) {
        // 移除当前路由器
        [vcArray removeObjectAtIndex:index];
        // 添加新控制器
        [vcArray addObject:vc];
        // 重新设置当前导航控制器的路由数组
        [self.navigationController setViewControllers:vcArray animated:animated];
    }
}

//获取当前控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIView class]]) {
        nextResponder = window.rootViewController;
    }
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
        if ([result isKindOfClass:[UITabBarController class]]) {
            result = ((UITabBarController*)nextResponder).selectedViewController;
        }
        if ([result isKindOfClass:[UINavigationController class]]) {
            result = ((UINavigationController*)result).topViewController;
        }
    }else
        result = window.rootViewController;
    
    return result;
}

@end
