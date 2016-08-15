//
//  ReviewModel.h
//  AmericanSantiago
//
//  Created by Mervin on 16/8/2.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewModel : NSObject

@property (nonatomic, strong, readonly) id                    reviewGameData;


- (void) getReviewGamesWithUsername: (NSString *) username subjectId:(NSString *) subjectId sceneType:(NSString *)sceneType;

@end
