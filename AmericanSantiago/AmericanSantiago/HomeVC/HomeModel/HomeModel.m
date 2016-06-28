//
//  HomeModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "HomeModel.h"

@interface HomeModel()

@property (nonatomic, strong) id                        unlockedGamesData;
@property (nonatomic, strong) id                        GetNextConceptData;

@property (nonatomic, strong) id                        gameLogData;

@property (nonatomic, strong) id                        allUnlockedGamesData;

@end

@implementation HomeModel

#pragma mark -- 获取已解锁游戏列表(在场景中)
- (void) getGetUnlockedGamesWithUsername:(NSString *) username SubjectId:(NSString *)subjectId SceneType:(NSString *)sceneType
{
    NSString * urlString = @"/GetUnlockedGames";
        // JSON Body
    NSDictionary* bodyObject = @{@"username":username,
                                 @"subjectId":subjectId,
                                 @"sceneType":sceneType,
                                 };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.unlockedGamesData = resultDic;
            NSLog(@"HTTP Response Body  unlockedGamesData == : %@", resultDic);
        }
    }];
}

#pragma mark -- 获取下一个教学知识点游戏
- (void) getGetNextConceptWithUsername:(NSString *) username SubjectId:(NSString *)subjectId
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"username":username,
                                 @"subjectId":subjectId,
                                 };
    
    NSString * urlString = @"/GetNextConcept";
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.GetNextConceptData = resultDic;
            NSLog(@"HTTP Response Body  GetNextConceptData == : %@", resultDic);
        }
    }];
    
}


#pragma mark -- 获取全部解锁游戏列表
- (void) getAllUnlockedGamesUsername: (NSString *) username subjectId:(NSString *) subjectId
{
    NSString * urlString = @"/GetAllUnlockedGames";
    NSDictionary* bodyObject = @{
                                 @"username":username,
                                 @"subjectId":subjectId};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.allUnlockedGamesData = resultDic;
            NSLog(@"HTTP Response Body  allUnlockedGamesData == : %@", resultDic);
        }
    }];
    
}



@end
