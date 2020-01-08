//
//  HYPassport.m
//  HYBase
//
//  Created by JackXu on 2020/1/8.
//  Copyright © 2020 JXRice. All rights reserved.
//

#import "HYPassport.h"
#import <objc/runtime.h>

@implementation HYPassport

@dynamic authToken;

+ (instancetype)sharedPassport {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - runtime
+ (BOOL)resolveInstanceMethod:(SEL)selector{
    NSString *selectorString = NSStringFromSelector(selector);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self,
                        selector,
                        (IMP)autoDictionarySetter,
                        "v@:@");
    }else{
        class_addMethod(self,
                        selector,
                        (IMP)autoDictionaryGetter,
                        "@@:");
    }
    
    return YES;
}

id autoDictionaryGetter(id self,SEL _cmd){
    NSString *key = NSStringFromSelector(_cmd);
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    return [data objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value){
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    if(value != nil && ![value isKindOfClass:[NSNull class]]){
        [data setObject:value?:@"" forKey:key];
    }
}

- (void)logout{
    self.authToken = @"";
}

@end
