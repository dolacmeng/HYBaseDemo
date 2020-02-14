//
//  HYPassport.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBasePassport : NSObject

@property(nonatomic,strong) NSString *authToken;

/// 单例
+ (instancetype)sharedPassport;

/// 退出登录
- (void)logout;

@end

NS_ASSUME_NONNULL_END
