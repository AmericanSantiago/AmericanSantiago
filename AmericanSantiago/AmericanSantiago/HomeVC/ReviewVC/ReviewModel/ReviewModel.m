//
//  ReviewModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/8/2.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ReviewModel.h"

@interface ReviewModel()

@property (nonatomic, strong) id                    reviewGameData;

@end

@implementation ReviewModel


#pragma mark -- 获取复习游戏列表
- (void) getReviewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId sceneType:(NSString *)sceneType
{
    NSString * urlString = @"/GetUnlockedGames";
    NSDictionary* bodyObject = @{
                                 @"username":username,
                                 @"subjectId":subjectId,
                                 @"sceneType":sceneType
                                 };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.reviewGameData = resultDic;
            NSLog(@"HTTP Response Body  reviewGameData == : %@", resultDic);
            
        }
    }];
    
}



@end
