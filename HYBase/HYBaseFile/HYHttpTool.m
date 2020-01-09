//
//  HYHttpTool.m
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import "HYHttpTool.h"
#import "AFNetworking.h"
#import "YYKit.h"

static AFHTTPSessionManager *manager;

@implementation HYHttpTool

+(void)createAsynchronousRequest:(NSString *)action parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)(void))failure{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/app/",[self getHttpPrefix]]];
    
    
    if (!manager || ![manager.baseURL isEqual:url]) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    }
    
    //添加用户信息等参数
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [temp setObject:[HYPassport sharedPassport].authToken?:@"" forKey:@"authToken"];
//    [temp setObject:@"ios" forKey:@"deviceType"];
    
    //去除参数值前后空格
    for(NSString *key in [temp allKeys]){
        NSString *value = [temp objectForKey:key];
        if([value isKindOfClass:[NSString class]]){
            NSString *newValue = [value stringByTrim];
            if (![value isEqualToString:newValue]) {
                NSLog(@"检测到有多余空格，value(%@),newValue(%@)",value,newValue);
                [temp setObject:newValue forKey:key];
            }
        }
    }

    //添加时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*100;
    [temp setObject:[NSString stringWithFormat:@"%.0f",a] forKey:@"timestrap"];
    
    //参数排序
//    NSArray *paraKeys = [[temp allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    NSMutableString *paraStr = [NSMutableString string];
//    for (NSString *key in paraKeys) {
//        NSString *value = [temp objectForKey:key]?:@"";
//        [paraStr appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
//    }
//    NSString *paraResutlStr = [paraStr substringToIndex:paraStr.length-1];
    
    //打印
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@%@?",url,action];
    NSArray *keyArr = [parameters allKeys];
    for (NSString *key in keyArr) {
        [str appendString:[NSString stringWithFormat:@"%@=%@&",key,parameters[key]]];
    }
    NSRange range = NSMakeRange(str.length-1, 1);
    [str deleteCharactersInRange:range];
    NSLog(@"提交:%@",str);

    //发送请求
    [manager POST:action parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if([[responseObject objectForKey:@"code"] intValue] == -3){
            //其它设备登录
        }else{
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        NSLog(@"error: %@, \n error.localizedDescription: %@", error, [error localizedDescription]);
    }];
}

+(NSString*)getHttpPrefix{
    return @"http://dianmian.lingyitrade.com";
}

@end
