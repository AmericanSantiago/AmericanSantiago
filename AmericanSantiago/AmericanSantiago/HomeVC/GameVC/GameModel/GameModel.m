//
//  GameModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "GameModel.h"

@interface GameModel ()

@property (nonatomic, strong) id                                    gameNewData;
@property (nonatomic, strong) id                                    gameData;
@property (nonatomic, strong) id                                    conceptFinishData;

@property (nonatomic, strong) id                                     finishGameData;

@end


@implementation GameModel

#pragma mark -- 获取游戏详情
- (void) getGameData
{
    NSString * urlString = @"/Math/AF_AS_0dot2/school_classroom_13_26_01/index.html";
    // JSON Body
    NSDictionary* bodyObject = @{
                                 
                                 
                                 };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (errorString) {
            self.gameData = resultDic;
            NSLog(@"HTTP Response Body  gameData == : %@", resultDic);
            
            
        }
    }];
    
}

#pragma mark -- 获取新解锁游戏列表
- (void) getNewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId
{
    NSString * urlString = @"/GetNewGames";
    NSDictionary* bodyObject = @{
                                 @"username":username,
                                 @"subjectId":subjectId};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.gameNewData = resultDic;
//            NSLog(@"HTTP Response Body  gameNewData == : %@", resultDic);
        }
    }];
    
}

#pragma mark -- 获取新解锁游戏列表
- (void) sendConceptFinishWithUsername: (NSString *) username subjectId:(NSString *) subjectId
{
    NSString * urlString = @"/GetNewGames";
    NSDictionary* bodyObject = @{
                                 @"username":username,
                                 @"subjectId":subjectId};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.gameNewData = resultDic;
//            NSLog(@"HTTP Response Body  gameNewData == : %@", resultDic);
        }
    }];
    
}

#pragma mark - 完成当前场景
- (void)getConceptFinishDataWithSubjectId:(NSString *)subjectId Username: (NSString *) username complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete
{
    //通知后台游戏完成
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    NSString * urlString = @"/ConceptFinish";
    NSDictionary* bodyObject = @{
//                                 @"username":userDic[@"username"],
                                 @"username":username,
                                 @"subjectId":subjectId};
//    NSLog(@"123321   ===   %@",bodyObject);
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (complete) {
            complete(resultDic,errorString);
        }
        if (!errorString) {
            self.conceptFinishData = resultDic;
        }
    }];
}

#pragma mark -- 单个游戏完成后，告诉后台
- (void) sendFinishedGameDataWithUsername:(NSString *)username gameId:(NSString *)gameId complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete
{
    //通知后台游戏完成
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    NSString * urlString = @"/SendGameLog";
    NSDictionary* bodyObject = @{
                                 //                                 @"username":userDic[@"username"],
                                 @"username":username,
                                 @"gameId":gameId,
                                @"success":@"true",
                                 @"duration":@100,              //int类型
                                 @"clickCount":@200            //int类型
                                 };
    
    //    NSLog(@"123321   ===   %@",bodyObject);
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (complete) {
            complete(resultDic,errorString);
        }
        if (!errorString) {
            self.conceptFinishData = resultDic;
        }
    }];

    
}




@end
