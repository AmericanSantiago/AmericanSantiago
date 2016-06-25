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

@end
