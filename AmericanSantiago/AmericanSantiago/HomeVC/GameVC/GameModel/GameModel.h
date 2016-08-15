//
//  GameModel.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic, strong,readonly) id                                    gameData;
@property (nonatomic, strong, readonly) id                                    gameNewData;
@property (nonatomic, strong, readonly) id                                    conceptFinishData;

@property (nonatomic, strong, readonly) id                                     finishGameData;

- (void) getGameData;
- (void) getNewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId;


#pragma mark - 完成当前场景
- (void)getConceptFinishDataWithSubjectId:(NSString *)subjectId Username: (NSString *) username complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete;

- (void) sendFinishedGameDataWithUsername:(NSString *)username gameId:(NSString *)gameId complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete;


@end
