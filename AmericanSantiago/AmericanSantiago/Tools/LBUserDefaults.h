//
//  LBUserDefaults.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBUserDefaults : NSObject
#pragma mark - 用户信息缓存
+ (void)setUserDic:(NSValue *)userDic;
+(NSDictionary *)getUserDic;

@end
