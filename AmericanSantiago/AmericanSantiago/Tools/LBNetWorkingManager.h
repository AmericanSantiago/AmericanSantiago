//
//  LBNetWorkingManager.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/20.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBNetWorkingManager : NSObject

//POST
+(NSURLSessionDataTask *)loadPostAfNetWorkingWithUrl:(NSString *)urlString andParameters:(NSMutableDictionary *)params complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete;

+(NSURLSessionDataTask *)loadGetAfNetWorkingWithUrl:(NSString *)urlString andParameters:(NSMutableDictionary *)params complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete;

@end
