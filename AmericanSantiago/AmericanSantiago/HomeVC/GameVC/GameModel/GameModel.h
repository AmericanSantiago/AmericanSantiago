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


- (void) getGameData;
- (void) getNewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId;


#pragma mark - 完成当前场景
- (void)getConceptFinishDataWithSubjectId:(NSString *)subjectId complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete;
@end
