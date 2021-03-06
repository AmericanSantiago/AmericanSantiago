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
@property (nonatomic, strong, readonly) id                        nextConceptData;

@property (nonatomic, strong, readonly) id                        gameLogData;

@property (nonatomic, strong, readonly) id                        allUnlockedGamesData;

- (void) getGetUnlockedGamesWithUsername:(NSString *) username SubjectId:(NSString *)subjectId SceneType:(NSString *)sceneType;
#pragma mark -- 获取下一个教学知识点游戏
- (void) getNextConceptWithUsername:(NSString *) username SubjectId:(NSString *)subjectId;


//- (void) getAllUnlockedGamesUsername: (NSString *) username subjectId:(NSString *) subjectId;       //加载全部解锁游戏

@end
