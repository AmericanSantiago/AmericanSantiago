//
//  FigureVC.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/26.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "FigureModel.h"

@interface FigureModel ()

@property (nonatomic, strong) id                        updateInfoData;

@end

@implementation FigureModel

#pragma mark -- 更新人物数据
- (void) updateInfoWithNickname: (NSString *) nickname Name:(NSString *) name Birthday:(NSString *)birthday Gender:(NSString *)gender Charactertype: (NSString *)charactertype username:(NSString *) username
{
    NSString * urlString = @"/UpdateInfo";
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"nickname":nickname,
                                 @"name":name,
                                 @"birthday":birthday,
                                 @"gender":gender,
                                 @"character_type":charactertype,
                                 @"username":username,
                                 };
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            self.updateInfoData = resultDic;
//            NSLog(@"HTTP Response Body  updateInfoData == : %@", resultDic);
        }
    }];
    
}


@end
