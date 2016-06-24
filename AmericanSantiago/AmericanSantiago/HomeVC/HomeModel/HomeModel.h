//
//  HomeModel.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic ,strong, readonly) id                        unlockedGamesData;
@property (nonatomic, strong, readonly) id                        GetNextConceptData;

@property (nonatomic, strong, readonly) id                        gameLogData;

@property (nonatomic, strong, readonly) id                        allUnlockedGamesData;

- (void) getGetUnlockedGamesWithUsername:(NSString *) username SubjectId:(NSString *)subjectId SceneType:(NSString *)sceneType;
- (void) getGetNextConceptWithUsername:(NSString *) username SubjectId:(NSString *)subjectId;


- (void) sendGameLogWithUsername:(NSString *) username conceptId:(NSString *)conceptId gameId:(NSString *)gameId learningType:(NSString * )learningType duration:(NSString *)duration clickCount:(NSString *)clickCount log:(NSString *)log;


- (void) getAllUnlockedGamesUsername: (NSString *) username subjectId:(NSString *) subjectId;       //加载全部解锁游戏

@end
