//
//  LBUserDefaults.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LBUserDefaults.h"

@implementation LBUserDefaults
#pragma mark - 用户信息缓存
static NSString *loginInfoSaveKey = @"loginInfo";
+ (void)setUserDic:(NSValue *)userDic
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (!userDic) {
        [userdefaults removeObjectForKey:loginInfoSaveKey];
    }else{
//        NSString *jsonStr = [NSString jsonStringWithDictionary:userDic];
//        [userdefaults setObject:jsonStr forKey:loginInfoSaveKey];
        [userdefaults setObject:userDic forKey:loginInfoSaveKey];
    }
    [userdefaults synchronize];
}

+(NSDictionary *)getUserDic
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *userDic = [userdefaults objectForKey:loginInfoSaveKey];
    if (!userDic) {
        return nil;
    }
    return userDic;
}

#pragma mark - 游戏数字缓存
+ (void)saveNewGameNumber:(NSNumber *)number sceneName:(NSString *)sceneName
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (sceneName) {
        [userdefaults setObject:number forKey:sceneName];
    }else{
        [userdefaults removeObjectForKey:sceneName];
    }
    [userdefaults synchronize];
}

+ (NSNumber *)getNewGanmeNumberWithSceneName:(NSString *)sceneName
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [userdefaults objectForKey:sceneName];
    return number;
}

@end
