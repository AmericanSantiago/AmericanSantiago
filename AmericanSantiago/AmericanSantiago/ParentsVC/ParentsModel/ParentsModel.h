//
//  ParentsModel.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentsModel : NSObject

@property (nonatomic ,strong, readonly) id                        learningStatisticsData;


- (void) getLearningStatisticsWithUsername:(NSString *) username rangeType:(NSNumber *) rangeType;

@end
