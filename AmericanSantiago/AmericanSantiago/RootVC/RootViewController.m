

//
//  RootViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "RootViewController.h"
#import "RootLeftView.h"
#import "BaseViewController.h"

#import "HomeViewController.h"
#import "FigureViewController.h"
#import "ParentsViewController.h"
#import "SetViewController.h"
#import "ScreenshotViewController.h"

@interface RootViewController ()<RootLeftViewDelegate>

@property (strong, nonatomic) RootLeftView *leftView;
@property (strong, nonatomic) LBTranslationController *currentViewController;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation RootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        LBTranslationController *homeTC = [[LBTranslationController alloc]initWithRootViewController:homeVC];
        
        FigureViewController *figureVC = [[FigureViewController alloc]init];
        LBTranslationController *figureTC = [[LBTranslationController alloc]initWithRootViewController:figureVC];
        
        ParentsViewController *parentsVC = [[ParentsViewController alloc]init];
        LBTranslationController *parentsTC = [[LBTranslationController alloc]initWithRootViewController:parentsVC];
        
        SetViewController *setVC = [[SetViewController alloc]init];
        LBTranslationController *setTC = [[LBTranslationController alloc]initWithRootViewController:setVC];
        
//        ScreenshotViewController *screenshotVC = [[ScreenshotViewController alloc]init];
//        LBTranslationController *screenshotTC = [[LBTranslationController alloc]initWithRootViewController:screenshotVC];
        
        self.viewControllers = @[homeTC,figureTC,parentsTC,setTC];
        [self selectedWithIndex:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.contentView];
}
#pragma mark - 各种Getter
- (RootLeftView *)leftView
{
    if (!_leftView) {
        _leftView = [[RootLeftView alloc]init];
        _leftView.delegate = self;
    }
    return _leftView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftView.frame),0,MAINSCRREN_W-self.leftView.frame.size.width,MAINSCRREN_H)];
        _contentView.backgroundColor = [UIColor grayColor];
    }
    return _contentView;
}

#pragma mark - setter
- (void)setCurrentViewController:(LBTranslationController *)currentViewController
{
    [self.contentView addSubview:currentViewController.view];
    [self addChildViewController:currentViewController];
    [currentViewController didMoveToParentViewController:self];
    
    if (_currentViewController) {
        [_currentViewController.view removeFromSuperview];
        [_currentViewController removeFromParentViewController];
        [_currentViewController willMoveToParentViewController:self];
    }
    _currentViewController = currentViewController;
}


#pragma mark - RootLeftViewDelegate
- (void)selectedWithIndex:(NSInteger)index
{
    if (self.viewControllers.count > 0) {
        if (index == 4) {
            
            return;
        }
        else{
            self.currentViewController = self.viewControllers[index];
        }
        
    }
}

- (void)selectedBackBtn:(UIButton *)sender
{
    [self.currentViewController.currentViewController.translationController popViewController];
}

#pragma mark - 按钮方法

#pragma mark - 自定义方法



@end
