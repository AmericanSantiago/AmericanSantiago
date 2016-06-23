//
//  HomeModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "HomeModel.h"

@interface HomeModel()

@property (nonatomic, strong) id                        unlockedGamesData;
@property (nonatomic, strong) id                        GetNextConceptData;

@property (nonatomic, strong) id                        gameLogData;

@end

@implementation HomeModel

#pragma mark -- 获取已解锁游戏列表
- (void) getGetUnlockedGamesWithUsername:(NSString *) username SubjectId:(NSString *)subjectId SceneType:(NSString *)sceneType
{
    NSString * urlString = @"/GetUnlockedGames";
        // JSON Body
    NSDictionary* bodyObject = @{@"username":username,
                                 @"subjectId":subjectId,
                                 @"sceneType":sceneType,
                                 };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (errorString) {
            self.unlockedGamesData = resultDic;
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
//                                 @"subjectId":subjectId,
//                                 @"sceneType":sceneType,
//                                 
//                                 };
//    
//    
//    //    NSDictionary * dic1 = @{@"username":@"123456",@"password":@"123456",@"nickname":@"mwk",@"birthday":@"19930102",@"gender":@"0",@"character":@"boy"};
//    
//    NSString * urlString = @"/GetUnlockedGames";
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
//                                                                             self.unlockedGamesData = object;
//                                                                             
//                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
//                                                                             NSLog(@"HTTP Response Body  gameListData == : %@", object);
//                                                                             
//                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                                             NSLog(@"HTTP Request failed: %@", error);
//                                                                         }];
//    
//    [manager.operationQueue addOperation:operation];
    
}

#pragma mark -- 获取下一个教学知识点游戏
- (void) getGetNextConceptWithUsername:(NSString *) username SubjectId:(NSString *)subjectId
{

    // JSON Body
    NSDictionary* bodyObject = @{
                                 
                                 @"username":username,
                                 @"subjectId":subjectId,
                                 
                                 };
    
    NSString * urlString = @"/GetNextConcept";
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (errorString) {
            self.GetNextConceptData = resultDic;
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
//                                 @"subjectId":subjectId,
//                                 
//                                 };
//    
//    NSString * urlString = @"/GetNextConcept";
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
//                                                                             self.GetNextConceptData = object;
//                                                                             
//                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
//                                                                             NSLog(@"HTTP Response Body  GetNextConceptData == : %@", object);
//                                                                             
//                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                                             NSLog(@"HTTP Request failed: %@", error);
//                                                                         }];
//    
//    [manager.operationQueue addOperation:operation];
    
}

#pragma mark -- 发送用户游戏反馈
- (void) sendGameLogWithUsername:(NSString *) username conceptId:(NSString *)conceptId gameId:(NSString *)gameId learningType:(NSString * )learningType duration:(NSString *)duration clickCount:(NSString *)clickCount log:(NSString *)log
{

    // JSON Body
    NSDictionary* bodyObject = @{
                                 
                                 @"username":username,
                                 @"conceptId":conceptId,
                                 @"gameId":gameId,
                                 @"learningType":learningType,
                                 @"clickCount":clickCount,
                                 @"log":log,
                                 
                                 
                                 };
    
    NSString * urlString = @"/L";

    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (errorString) {
            self.gameLogData = resultDic;
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
//                                 @"conceptId":conceptId,
//                                 @"gameId":gameId,
//                                 @"learningType":learningType,
//                                 @"clickCount":clickCount,
//                                 @"log":log,
//                                 
//                                 
//                                 };
//    
//    NSString * urlString = @"/L";
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
//                                                                             self.gameLogData = object;
//                                                                             
//                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
//                                                                             NSLog(@"HTTP Response Body  gameLogData == : %@", object);
//                                                                             
//                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                                             NSLog(@"HTTP Request failed: %@", error);
//                                                                         }];
//    
//    [manager.operationQueue addOperation:operation];
    
}





@end
