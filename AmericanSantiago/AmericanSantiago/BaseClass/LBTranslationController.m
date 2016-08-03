//
//  LBTranslationController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LBTranslationController.h"

@interface LBTranslationController ()

//@property (strong, nonatomic) BaseViewController *tempVC;

@end

@implementation LBTranslationController

- (instancetype)initWithRootViewController:(BaseViewController *)rootViewController
{
    self = [super init];
    if (self) {
        
        self.viewControllers = [NSMutableArray array];
        self.rootViewController = rootViewController;
//        self.tempVC = rootViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = BASESCRREN_B;
    self.currentViewController = self.rootViewController;
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
    
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    
}
#pragma mark - 各种Getter

#pragma mark - setter

- (void)setCurrentViewController:(BaseViewController *)currentViewController
{
    currentViewController.translationController= self;
    [self.view addSubview:currentViewController.view];
    [self addChildViewController:currentViewController];
    [currentViewController didMoveToParentViewController:self];
    
    if (_currentViewController) {
        [_currentViewController removeFromParentViewController];
        [_currentViewController.view removeFromSuperview];
        [_currentViewController willMoveToParentViewController:self];
    }
    _currentViewController = currentViewController;
}


#pragma mark - 按钮方法

#pragma mark - 自定义
- (void)pushViewController:(BaseViewController *)viewController
{
    
    [self.viewControllers addObject:self.currentViewController];
    self.currentViewController = viewController;
    
//    [UIView animateWithDuration:0.3 animations:^{
//
//    }];
    
}

- (void)popViewController
{
    if (self.viewControllers.count) {
        BaseViewController *lastVC = [self.viewControllers lastObject];
        self.currentViewController = lastVC;
        [self.viewControllers removeObject:self.currentViewController];
    }
}

- (void)popToRootViewController
{
    if (self.viewControllers.count) {
        BaseViewController *lastVC = [self.viewControllers firstObject];
        self.currentViewController = lastVC;
//        [self.viewControllers removeObject:self.currentViewController];
        [self.viewControllers removeAllObjects];
    }
}

- (void)popToViewController:(BaseViewController *)aViewController
{
    for (BaseViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:[aViewController class]]) {
            self.currentViewController = viewController;
            [self.viewControllers removeObject:self.currentViewController];
        }
    }
}

@end
