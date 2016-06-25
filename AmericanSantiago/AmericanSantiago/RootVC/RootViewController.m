

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
@property (strong, nonatomic) RootLeftView *rightView;
@property (strong, nonatomic) UIButton *lastBtn;

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
        UIButton *tempBtn = (UIButton *)[self.leftView viewWithTag:BUTTON_TAG];
//        [tempBtn setTitle:@"主页" forState:UIControlStateNormal];
        [self selectedActionBtn:tempBtn];
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
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
}
#pragma mark - 各种Getter
- (RootLeftView *)leftView
{
    if (!_leftView) {
        _leftView = [[RootLeftView alloc]initTitles:@[@"主页",@"截图",@"返回"]];
        _leftView.delegate = self;
        [_leftView setOriginX:FLEXIBLE_NUM(35)];
        [_leftView setOriginY:FLEXIBLE_NUM(69)];
    }
    return _leftView;
}

- (RootLeftView *)rightView
{
    if (!_rightView) {
        _rightView = [[RootLeftView alloc]initTitles:@[@"人物",@"家长",@"设置"]];
        _rightView.delegate = self;
        [_rightView setOriginX:MAINSCRREN_W - FLEXIBLE_NUM(35)-FLEXIBLE_NUM(61)];
        [_rightView setOriginY:FLEXIBLE_NUM(69)];
    }
    return _rightView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:MAINSCRREN_B];
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
- (void)selectedActionBtn:(UIButton *)sender
{
    UIButton *homeBtn = (UIButton *)[self.leftView viewWithTag:BUTTON_TAG];
    
    if (self.lastBtn != sender) {
        self.lastBtn.selected = NO;
        sender.selected = YES;
        self.lastBtn = sender;
        NSArray *titleArray = @[@"主页",@"人物",@"家长",@"设置"];
        NSInteger index = [titleArray indexOfObject:sender.titleLabel.text];
        if (index != NSNotFound) {
            self.currentViewController = self.viewControllers[index];
            if (index == 0) {
                LBTranslationController *homeTC = [self.viewControllers firstObject];
                [homeTC popToRootViewController];
            }
        }
    }
    else if (self.lastBtn == homeBtn) {
        [self.currentViewController.currentViewController.translationController popToRootViewController];
//        LBTranslationController *homeTC = [self.viewControllers firstObject];
//        [homeTC popToRootViewController];
    }
    
    
}

- (void)selectedScreenshotBtn:(UIButton *)sender
{
    [AppDelegate showHintLabelWithMessage:@"截图成功!"];

    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//保存到相册
    
    CGRect rect = self.view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
}

- (void)selectedBackBtn:(UIButton *)sender
{
    [self.currentViewController.currentViewController.translationController popViewController];
}

#pragma mark - 按钮方法

#pragma mark - 自定义方法



@end
