
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
- (void) getLearningStatisticsWithUsername:(NSString *) username
{
    // JSON Body
    NSDictionary* bodyObject = @{
                                 
                                 @"username":username,
                                 
                                 };
    
    NSString * urlString = @"/GetLearningStatistics";

    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (errorString) {
            self.learningStatisticsData = resultDic;
        }
    }];
//    // Create manager
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    // JSON Body
//    NSDictionary* bodyObject = @{
//                                 
//                                 @"username":username,
//                                 
//                                 };
//    
//    NSString * urlString = @"/GetLearningStatistics";
//    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
//    
//    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
//                                                                                 URLString:URL
//                                                                                parameters:bodyObject
//                                                                                     error:NULL];
//    
//    //    NSLog(@"===============%@",bodyObject);
//    //    NSLog(@"+++++++++++++++%@",request);
//    
//    // Fetch Request
//    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
//                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                                             
//                                                                             
//                                                                             NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//                                                                             //NSLog(@"fuck- ----- %@",string);
//                                                                             id object = [string  objectFromJSONString];
//                                                                             self.learningStatisticsData = object;
//                                                                             
//                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
//                                                                             NSLog(@"HTTP Response Body  learningStatisticsData == : %@", object);
//                                                                             
//                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                                             NSLog(@"HTTP Request failed: %@", error);
//                                                                         }];
//    
//    [manager.operationQueue addOperation:operation];
    
}



@end
