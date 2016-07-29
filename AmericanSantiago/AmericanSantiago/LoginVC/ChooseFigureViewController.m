//
//  ChooseFigureViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ChooseFigureViewController.h"
#import "LoginModel.h"

@interface ChooseFigureViewController ()

@property (nonatomic, strong) UIButton                      * ensureButton;
@property (nonatomic, strong) LoginModel                * loginModel;

@property (nonatomic, strong) UIImageView               * figureImageView;
@property (nonatomic, strong) UIButton                          * leftButton;
@property (nonatomic ,strong) UIButton                          * rightButton;

@property (nonatomic, strong) NSString                          * character;                        //人物设定

@end

@implementation ChooseFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
        [_loginModel removeObserver:self forKeyPath:@"registerData"];
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"registerData"]) {
        if ([[_loginModel.registerData valueForKey:@"errorCode"] integerValue]== 0) {
            
            //先保存用户信息，再跳转
//            [LBUserDefaults setUserDic:[_loginModel.registerData valueForKey:@"data"]];
            [[NSUserDefaults standardUserDefaults] setObject:[_loginModel.registerData valueForKey:@"data"] forKey:@"userInfo"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"注册失败");
            [AppDelegate showHintLabelWithMessage:@"注册失败~"];
        }
        
        
    }
    
    
    
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
    self.title = @"注册";
    
    _loginModel = [[LoginModel alloc] init];
    [_loginModel addObserver:self forKeyPath:@"registerData" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"注册选择人物bg.png"]];
    [self.view addSubview:backgroundView];
    
    
    _character = @"girl";
    _figureImageView = ({
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(150), FLEXIBLE_NUM(60), FLEXIBLE_NUM(FLEXIBLE_NUM(750)), FLEXIBLE_NUM(600))];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(FLEXIBLE_NUM(600)), FLEXIBLE_NUM(500))];
        imageView.center = CGPointMake(MAINSCRREN_W/2, MAINSCRREN_H/2);
//        imageView.backgroundColor = [UIColor yellowColor];
        [imageView clipsToBounds];
        [imageView setImage:[UIImage imageNamed:@"girl"]];
        [self.view addSubview:imageView];
        imageView;
    });
    
    _leftButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(180), FLEXIBLE_NUM(330), FLEXIBLE_NUM(90), FLEXIBLE_NUM(90))];
        [button setImage:[UIImage imageNamed:@"黄向右@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.view addSubview:button];
        button;
    });
    
    _rightButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(770), FLEXIBLE_NUM(330), FLEXIBLE_NUM(90), FLEXIBLE_NUM(90))];
        [button setImage:[UIImage imageNamed:@"黄向左@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    _ensureButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(380), FLEXIBLE_NUM(550), FLEXIBLE_NUM(280), FLEXIBLE_NUM(70))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(34), FLEXIBLE_NUM(34), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    
}


#pragma mark -- buttonClick
- (void) backButtonClicked:(UIButton *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) leftButtonClick:(UIButton *) sender
{
    [_figureImageView setImage:[UIImage imageNamed:@"girl"]];
    _rightButton.hidden = NO;
    _leftButton.hidden = YES;
    _character = @"girl";
    
}

- (void) rightButtonClick:(UIButton *) sender
{
    [_figureImageView setImage:[UIImage imageNamed:@"boy"]];
    _rightButton.hidden = YES;
    _leftButton.hidden = NO;
    _character = @"boy";
    
}

- (void) ensureButtonClick:(UIButton *) sender
{
    [_loginModel registerWithUsername:_userName Password:_passwd nickname:_studentName birthday:_birthday gender:_gender character:_character name:_studentName];
    
    
    
}



@end
