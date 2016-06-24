//
//  LoginModel.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (nonatomic, strong, readonly) id                            loginData;
@property (nonatomic, strong, readonly) id                            registerData;



- (void) loginWithUsername: (NSString *) username Password:(NSString *) password;
- (void)registerWithUsername:(NSString *)username Password:(NSString *)password nickname:(NSString *) nickname birthday:(NSString *)birthday gender:(NSString *)gender character:(NSString *)character name:(NSString *) name;

@end
