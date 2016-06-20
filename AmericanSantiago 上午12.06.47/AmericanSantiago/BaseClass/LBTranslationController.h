//
//  LBTranslationController.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTranslationController : UIViewController

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) BaseViewController *rootViewController;
@property (strong, nonatomic) BaseViewController *currentViewController;

- (instancetype)initWithRootViewController:(BaseViewController *)rootViewController;

- (void)pushViewController:(BaseViewController *)viewController;

- (void)popViewController;

- (void)popToRootViewController;

- (void)popToViewController:(BaseViewController *)aViewController;

@end
