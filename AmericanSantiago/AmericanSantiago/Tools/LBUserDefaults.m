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

#pragma mark -- 取出用户信息
+(NSDictionary *)getUserDic
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [userdefaults objectForKey:loginInfoSaveKey];
    if (!userDic) {
        return nil;
    }
    return userDic;
}

#pragma mark - 当前选择课程
static NSString *currentClassNameKey = @"currentCalss";
+ (void)saveCurrentClass:(NSString *)currentClassName
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (currentClassName) {
        [userdefaults setObject:currentClassName forKey:currentClassNameKey];
    }else{
        [userdefaults removeObjectForKey:currentClassNameKey];
    }
    [userdefaults synchronize];
}

+ (NSString *)getCurrentCalss
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentCalss = [userdefaults objectForKey:currentClassNameKey];
    return currentCalss;
}

#pragma mark - 当前教学点游戏列表缓存
+ (NSString *)currentConceptGamesKey
{
    NSString *currentConceptGamesKey = @"currentConceptGamesKey";
    NSDictionary *userDic = [self getUserDic];
    NSString *key = [NSString stringWithFormat:@"%@_%@",userDic[@"username"],currentConceptGamesKey];
    return key;
    
    NSString * currentCouceptGamesKey1 = @"currentConceptGamesKey";
    NSDictionary * userDic1 = [self getUserDic];
    
}

+ (void)saveCurrentConceptGamesArray:(NSArray *)currentConceptGamesArray
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [self currentConceptGamesKey];
    NSString *jsonStr = [NSString jsonStringWithArray:currentConceptGamesArray];
    if (jsonStr) {
        [userdefaults setObject:jsonStr forKey:key];
    }else{
        [userdefaults removeObjectForKey:key];
    }
    [userdefaults synchronize];
}

+ (NSArray *)getCurrentConceptGamesArray
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [self currentConceptGamesKey];
    NSString *jsonStr = [userdefaults objectForKey:key];
    if (jsonStr) {
        return [jsonStr objectFromJSONString];
    }
    return nil;
}

+ (void)removeCurrentConceptGameWithSceneName:(NSString *)sceneName
{
    NSMutableArray *currentConceptGamesArray = [NSMutableArray arrayWithArray:[self getCurrentConceptGamesArray]];
    for (NSDictionary *conceptGameDic in currentConceptGamesArray) {
        if ([conceptGameDic[@"scene"] isEqualToString:sceneName]) {
            [currentConceptGamesArray removeObject:conceptGameDic];
            [self saveCurrentConceptGamesArray:currentConceptGamesArray];
            return;
        }
    }
}

#pragma mark - 游戏数字缓存(最新游戏)
+ (NSString *)newSceneGamesArrayKeyWithSceneName:(NSString *)sceneName
{
    NSString *newSceneGamesArrayKey = @"newSceneGamesArray";
    NSDictionary *userDic = [self getUserDic];
    NSString *key = [NSString stringWithFormat:@"%@_%@_%@",userDic[@"name"],sceneName,newSceneGamesArrayKey];
    return key;
}

+ (void)saveNewSceneGamesArray:(NSArray *)newSceneGamesArray sceneName:(NSString *)sceneName
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [self newSceneGamesArrayKeyWithSceneName:sceneName];
    NSString *jsonStr = [NSString jsonStringWithArray:newSceneGamesArray];
    if (jsonStr) {
        [userdefaults setObject:jsonStr forKey:key];
    }else{
        [userdefaults removeObjectForKey:key];
    }
    [userdefaults synchronize];
}

+ (NSArray *)getNewSceneGanmesArrayWithSceneName:(NSString *)sceneName
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [self newSceneGamesArrayKeyWithSceneName:sceneName];
    NSString *jsonStr = [userdefaults objectForKey:key];
    if (jsonStr) {
        return [jsonStr objectFromJSONString];
    }
    return nil;
}
//增加新的场景游戏，（已有的不会增加）
+ (void)addSaveNewSceneGamesArray:(NSArray *)newSceneGamesArray sceneName:(NSString *)sceneName
{
    NSArray * lastArray = [self getNewSceneGanmesArrayWithSceneName:sceneName];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (lastArray) {
        tempArray = [NSMutableArray arrayWithArray:lastArray];
    }
    if (newSceneGamesArray) {
        for (NSDictionary *newGameDic in newSceneGamesArray) {
            NSInteger index = [tempArray indexOfObject:newGameDic];
            if (index == NSNotFound) {
                [tempArray addObject:newGameDic];
            }
        }
        //        [tempArray addObjectsFromArray:newSceneGamesArray];
    }
    [self saveNewSceneGamesArray:tempArray sceneName:sceneName];
}

+ (void)removeNewGameDic:(NSDictionary *)newGameDic sceneName:(NSString *)sceneName
{
    NSArray *lastArray = [self getNewSceneGanmesArrayWithSceneName:sceneName];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (lastArray) {
        tempArray = [NSMutableArray arrayWithArray:lastArray];
    }
    if (newGameDic) {
        for (NSDictionary *gameDic in tempArray) {
            if ([gameDic[@"id"] isEqualToString:newGameDic[@"id"]]) {
                [tempArray removeObject:gameDic];
                [self saveNewSceneGamesArray:tempArray sceneName:sceneName];
                break;
            }
        }
    }
    if (tempArray.count == 0) {
        //删除当前课程的缓存，。
        [self removeCurrentConceptGameWithSceneName:sceneName];
    }
}

#pragma mark - 清空缓存
+ (void)clearUserDefaults
{
    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
}

@end
