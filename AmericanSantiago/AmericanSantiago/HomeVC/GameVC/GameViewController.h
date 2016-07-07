//
//  GameViewController.h
//  AmericanSantiago
//
//  Created by Mervin on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "BaseViewController.h"

@interface GameViewController : BaseViewController

@property (nonatomic, strong) NSString                      * urlString;

@property (strong, nonatomic) NSDictionary *gameDic;
@property (strong, nonatomic) NSString *subjectId;//课程id,如果存在则是选择课程。

@end
