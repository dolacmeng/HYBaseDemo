//
//  HYHttpTool.h
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYHttpTool : NSObject


/// 网络请求
/// @param action 接口名称
/// @param parameters 参数
/// @param success 成功回调
/// @param failure 失败回调
+(void)createAsynchronousRequest:(NSString *)action parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)(void))failure;

@end

NS_ASSUME_NONNULL_END
