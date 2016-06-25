//
//  GameModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "GameModel.h"

@interface GameModel ()

@property (nonatomic, strong) id                                    gameData;

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


@end
