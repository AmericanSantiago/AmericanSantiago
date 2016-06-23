//
//  LoginModel.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LoginModel.h"

@interface LoginModel ()

@property (nonatomic, strong) id                            registerData;
@property (nonatomic, strong) id                            loginData;

@end

@implementation LoginModel

#pragma mark -- 登录
- (void) loginWithUsername: (NSString *) username Password:(NSString *) password
{
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // JSON Body
        NSDictionary* bodyObject = @{
    
                                             @"username":username,
                                             @"password":password,
                                             
                                     };
    
    
//    NSDictionary * dic1 = @{@"username":@"123456",@"password":@"123456",@"nickname":@"mwk",@"birthday":@"19930102",@"gender":@"0",@"character":@"boy"};
    
    NSString * urlString = @"/Login";
    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URL
                                                                                parameters:bodyObject
                                                                                     error:NULL];
    
    //    NSLog(@"===============%@",bodyObject);
    //    NSLog(@"+++++++++++++++%@",request);
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             
                                                                             
                                                                             NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                                             //                                                                             NSLog(@"fuck- ----- %@",string);
                                                                             id object = [string  objectFromJSONString];
                                                                             self.loginData = object;
                                                                             
                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body  loginData == : %@", object);
                                                                             
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];

}




#pragma mark -- 注册
- (void)registerWithUsername:(NSString *)username Password:(NSString *)password nickname:(NSString *) nickname birthday:(NSString *)birthday gender:(NSString *)gender character:(NSString *)character
{
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // JSON Body
        NSDictionary* bodyObject = @{
    
                                             @"username":username,
                                             @"password":password,
                                             @"nickname":nickname,
                                             @"birthday":birthday,
                                             @"gender":gender,
                                             @"character":character,
                                     };
    
    
//    NSDictionary * dic1 = @{@"username":@"123456",@"password":@"123456",@"nickname":@"mwk",@"birthday":@"19930102",@"gender":@"0",@"character":@"boy"};
    
    NSString * urlString = @"/Register";
    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URL
                                                                                parameters:bodyObject
                                                                                     error:NULL];

        NSLog(@"===============%@",bodyObject);
    //    NSLog(@"+++++++++++++++%@",request);
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             
                                                                             
                                                                             NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                                             //                                                                             NSLog(@"fuck- ----- %@",string);
                                                                             id object = [string  objectFromJSONString];
                                                                             self.registerData = object;
                                                                             
                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body  registerData == : %@", object);
                                                                             
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
}




@end
