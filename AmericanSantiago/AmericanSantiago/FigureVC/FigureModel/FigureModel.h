//
//  FigureVC.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/26.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FigureModel : NSObject

@property (nonatomic, strong, readonly) id                        updateInfoData;

- (void) updateInfoWithNickname: (NSString *) nickname Name:(NSString *) name Birthday:(NSString *)birthday Gender:(NSString *)gender Charactertype: (NSString *)charactertype;


@end
