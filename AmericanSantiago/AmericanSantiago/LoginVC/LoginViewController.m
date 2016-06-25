//
//  LoginViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/20.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
#import "RegisterViewController.h"
#import "RootViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField                       * userNameTextField;
@property (nonatomic, strong) UITextField                       * passwdTextField;

@property (nonatomic, strong) UIButton                          * registerButton;
@property (nonatomic ,strong) UIButton                          * loginButton;

@property (nonatomic, strong) LoginModel                    * loginModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_loginModel removeObserver:self forKeyPath:@"registerData"];
    [_loginModel removeObserver:self forKeyPath:@"loginData"];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loginData"]) {
        if ([[_loginModel.loginData valueForKey:@"errorCode"] integerValue] == 0) {
            
            RootViewController *rootViewController = [[RootViewController alloc] init];
            [WINDOW.rootViewController presentViewController:rootViewController animated:YES completion:^{
                WINDOW.rootViewController = rootViewController;
                [AppDelegate showHintLabelWithMessage:@"登录成功~"];
                //            [[NSUserDefaults standardUserDefaults] setObject:[_loginModel.loginData valueForKey:@"data"] forKey:@"loginInfo"];
                [LBUserDefaults setUserDic:[_loginModel.loginData valueForKey:@"data"]];
                
                //            [WINDOW.rootViewController dismissViewControllerAnimated:YES completion:^{
            }];
        }else{
            [AppDelegate showHintLabelWithMessage:@"登录失败~"];
        }
        
        
    }
    
    
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
    self.title = @"登录";
    
    _loginModel = [[LoginModel alloc] init];
    [_loginModel addObserver:self forKeyPath:@"registerData" options:NSKeyValueObservingOptionNew context:nil];
    [_loginModel addObserver:self forKeyPath:@"loginData" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    self.view.frame = MAINSCRREN_B;
    FLEXIBLE_FONT(self.view);
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"登录注册bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    NSArray * titleArray = [[NSArray alloc] initWithObjects:@"用户名",@"密   码", nil];
    for (int i = 0; i < 2; i ++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(370), FLEXIBLE_NUM(140) + FLEXIBLE_NUM(120) * i, FLEXIBLE_NUM(340), FLEXIBLE_NUM(90))];
        [imageView setImage:[UIImage imageNamed:@"用户名密码@3x"]];
        [self.view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(390), FLEXIBLE_NUM(155) + FLEXIBLE_NUM(120) * i, FLEXIBLE_NUM(100), FLEXIBLE_NUM(50))];
        label.text = titleArray[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];
        [self.view addSubview:label];
        
    }
    
    _userNameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(480), FLEXIBLE_NUM(155), FLEXIBLE_NUM(220), FLEXIBLE_NUM(50))];
//        textField.backgroundColor = [UIColor yellowColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(28)];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    _passwdTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(480), FLEXIBLE_NUM(155 + 120), FLEXIBLE_NUM(220), FLEXIBLE_NUM(50))];
//        textField.backgroundColor = [UIColor yellowColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(28)];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _registerButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(370), FLEXIBLE_NUM(275 + 100), FLEXIBLE_NUM(150), FLEXIBLE_NUM(75))];
        [button setBackgroundImage:[UIImage imageNamed:@"注册@3x"] forState:UIControlStateNormal];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _loginButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(370 + 190), FLEXIBLE_NUM(275 + 100), FLEXIBLE_NUM(150), FLEXIBLE_NUM(75))];
        [button setBackgroundImage:[UIImage imageNamed:@"登录@3x"] forState:UIControlStateNormal];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
}
#pragma mark - 各种Getter


#pragma mark - 按钮方法
- (void) loginButtonClick: (UIButton *) sender
{
    
    [_loginModel loginWithUsername:_userNameTextField.text Password:_passwdTextField.text];

    
}

- (void) registerButtonClick: (UIButton *) sender
{
    
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
//    [_loginModel registerWithUsername:@"123456" Password:@"123" nickname:@"mwk" birthday:@"19930102" gender:@"0" character:@"boy"];
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    
    
}

#pragma mark - 自定义方法



@end
