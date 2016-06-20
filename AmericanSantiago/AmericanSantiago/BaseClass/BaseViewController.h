//
//  BaseViewController.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBTranslationController;

@interface BaseViewController : UIViewController

//@property (strong, nonatomic) NSMutableArray *viewControllers;
//@property (strong, nonatomic) BaseViewController *currentViewController;
@property (strong, nonatomic) LBTranslationController *translationController;
//@property (strong, nonatomic) LBTranslationViewController *tran;


@end
