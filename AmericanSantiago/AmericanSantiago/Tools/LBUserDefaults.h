//
//  LBUserDefaults.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBUserDefaults : NSObject
#pragma mark - 用户信息缓存
+ (void)setUserDic:(NSValue *)userDic;
+(NSDictionary *)getUserDic;

#pragma mark - 当前选择课程
+ (void)saveCurrentClass:(NSString *)currentClassName;
+ (NSString *)getCurrentCalss;

#pragma mark - 当前教学点游戏列表缓存
+ (void)saveCurrentConceptGamesArray:(NSArray *)currentConceptGamesArray;
+ (NSArray *)getCurrentConceptGamesArray;
+ (void)removeCurrentConceptGameWithSceneName:(NSString *)sceneName;

#pragma mark - 游戏数字缓存
+ (void)saveNewSceneGamesArray:(NSArray *)newSceneGamesArray sceneName:(NSString *)sceneName;
+ (NSArray *)getNewSceneGanmesArrayWithSceneName:(NSString *)sceneName;
+ (void)addSaveNewSceneGamesArray:(NSArray *)newSceneGamesArray sceneName:(NSString *)sceneName;
+ (void)removeNewGameDic:(NSDictionary *)newGameDic sceneName:(NSString *)sceneName;

#pragma mark - 清空缓存
+ (void)clearUserDefaults;
@end
