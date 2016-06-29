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
@property (nonatomic, strong) id                            logoutData;


@end

@implementation LoginModel

#pragma mark -- 登录
- (void) loginWithUsername: (NSString *) username Password:(NSString *) password
{
    NSString * urlString = @"/Login";
    NSDictionary* bodyObject = @{@"username":username,
                                 @"password":password};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.loginData = resultDic;
//            NSLog(@"HTTP Response Body  loginData == : %@", resultDic);
        }
    }];
    
}

#pragma mark -- 登出
- (void) logoutWithUsername: (NSString *) username
{
    NSString * urlString = @"/Logout";
    NSDictionary* bodyObject = @{@"username":username};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.logoutData = resultDic;
//            NSLog(@"HTTP Response Body  logoutData == : %@", resultDic);
        }
    }];
    
}



#pragma mark -- 注册
- (void)registerWithUsername:(NSString *)username Password:(NSString *)password nickname:(NSString *) nickname birthday:(NSString *)birthday gender:(NSString *)gender character:(NSString *)character name:(NSString *) name
{

        NSString * urlString = @"/Register";

        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"username":username,
                                     @"password":password,
                                     @"nickname":nickname,
                                     @"birthday":birthday,
                                     @"gender":gender,
                                     @"character":character,
                                     @"name":name,
                                     };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.registerData = resultDic;
//            NSLog(@"HTTP Response Body  registerData == : %@", resultDic);
        }
    }];
    
}




@end
