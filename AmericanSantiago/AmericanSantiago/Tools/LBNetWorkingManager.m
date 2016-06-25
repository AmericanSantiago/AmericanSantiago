//
//  LBNetWorkingManager.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/20.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LBNetWorkingManager.h"

@implementation LBNetWorkingManager

//POST
+(NSURLSessionDataTask *)loadPostAfNetWorkingWithUrl:(NSString *)urlString andParameters:(NSDictionary *)params complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete{
    ShowNetworkActivityIndicator();
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
    NSURLSessionDataTask *task = [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        HideNetworkActivityIndicator();
        NSError *error;
        if (error) {
            complete(nil,@"服务器错误");
            
            [UIButton stopAllButtonAnimationWithErrorMessage:@"服务器错误"];
        }else{
            if (responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    complete((NSDictionary *)responseObject,nil);
                }else{
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                    NSLog(@"error -- %@",error.localizedDescription);
                    if (!dic) {
                        NSLog(@"返回的结果不是json :%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                        complete(nil,@"服务器错误");
                        [UIButton stopAllButtonAnimationWithErrorMessage:@"服务器返回数据错误"];
                    }else{
                        complete(dic,nil);
                    }
                }
            }else{
                NSLog(@"服务器无返回值");
                complete(nil,@"服务器错误");
                [UIButton stopAllButtonAnimationWithErrorMessage:@"服务器无返回"];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error2 -- %@",error.localizedDescription);
        NSLog(@"错误描述%@",[error localizedDescription]);
        NSLog(@"%@",@(error.code));
        
//        com.alamofire.serialization.response.error.data
//        com.alamofire.serialization.response.error.data
        NSData *data = [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        id object = [string objectFromJSONString];
        NSLog(@"错误信息%@",object);
        NSLog(@"-douban-%@",object[@"data"]);
        NSString *errorMessage = object[@"data"][@"message"];
        complete(nil,errorMessage);
        if (!errorMessage) {
            errorMessage = @"服务器无响应";
        }
        [UIButton stopAllButtonAnimationWithErrorMessage:errorMessage];
    }];
    return task;
}

+(NSURLSessionDataTask *)loadGetAfNetWorkingWithUrl:(NSString *)urlString andParameters:(NSMutableDictionary *)params complete:(void (^)(NSDictionary *resultDic,NSString *errorString))complete{
    ShowNetworkActivityIndicator();
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
    NSURLSessionDataTask *task = [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        HideNetworkActivityIndicator();
        NSError *error;
        if (error) {
            complete(nil,@"服务器错误");
        }else{
            if (responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    complete((NSDictionary *)responseObject,nil);
                }else{
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                    if (!dic) {
                        NSLog(@"返回的结果不是json :%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                        complete(nil,@"服务器错误");
                    }else{
                        complete(dic,nil);
                    }
                }
            }else{
                NSLog(@"服务器无返回值");
                complete(nil,@"服务器错误");
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSData *data = [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        id object = [string objectFromJSONString];
        NSLog(@"错误信息%@",object);
        NSLog(@"-douban-%@",object[@"data"]);
        NSString *errorMessage = object[@"data"][@"message"];
        complete(nil,errorMessage);
        if (!errorMessage) {
            errorMessage = @"服务器无响应";
        }
        [UIButton stopAllButtonAnimationWithErrorMessage:errorMessage];
    }];
    return task;
}


@end
