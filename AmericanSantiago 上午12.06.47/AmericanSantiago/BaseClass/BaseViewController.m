//
//  BaseViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()



@end

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.frame = BASESCRREN_B;
    }
    return self;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//}

#pragma mark - getter

#pragma mark - setter

//- (void)setCurrentViewController:(BaseViewController *)currentViewController
//{
//    [self.view addSubview:currentViewController.view];
//    [self addChildViewController:currentViewController];
//    [currentViewController didMoveToParentViewController:self];
//    
//    if (_currentViewController) {
//        [_currentViewController removeFromParentViewController];
//        [_currentViewController.view removeFromSuperview];
//        [_currentViewController willMoveToParentViewController:self];
//    }
//    _currentViewController = currentViewController;
//}

#warning -- 测试，。正式使用时删除该方法
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleLabel = [self.view viewWithTag:LABEL_TAG+99];
    if (!titleLabel) {
        titleLabel = [[UILabel alloc]initWithFrame:BASESCRREN_B];
        titleLabel.backgroundColor = _B6B6B6;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.tag = LABEL_TAG+99;
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:titleLabel];
    }
}



@end
