
//
//  ParentsModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ParentsModel.h"

@interface ParentsModel ()

@property (nonatomic ,strong) id                        learningStatisticsData;

@end

@implementation ParentsModel

#pragma mark -- 获取学生学习统计数据
- (void) getLearningStatisticsWithUsername:(NSString *) username rangeType:(NSNumber *) rangeType
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 
                                 @"username":username,
                                 @"rangeType":rangeType
                                 
                                 };
    
    NSString * urlString = @"/GetLearningStatistics";

    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.learningStatisticsData = resultDic;
            NSLog(@"HTTP Response Body  learningStatisticsData == : %@", resultDic);
        }
    }];
    
}



@end
