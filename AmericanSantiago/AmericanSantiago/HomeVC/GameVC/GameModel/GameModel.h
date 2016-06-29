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


- (void) getGameData;
- (void) getNewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId;

@end
