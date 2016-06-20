//
//  LoginViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/20.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.title = @"登录";
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    self.view.frame = MAINSCRREN_B;
    FLEXIBLE_FONT(self.view);
}
#pragma mark - 各种Getter


#pragma mark - 按钮方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *urlStr = @"/Login";
    NSDictionary *dic = @{@"username":@"123456",@"password":@"123456"};
    
    
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlStr andParameters:dic complete:^(NSDictionary *resultDic, NSString *errorString) {
       
        NSLog(@"%@",resultDic);
        
    }];
}

#pragma mark - 自定义方法



@end
