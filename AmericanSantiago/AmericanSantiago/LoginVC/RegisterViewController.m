//
//  RegisterViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginModel.h"
#import "ChooseFigureViewController.h"

@interface RegisterViewController ()

@property (nonatomic, strong) LoginModel                        * loginModel;

@property (nonatomic ,strong) UITextField                           * userNameTextField;
@property (nonatomic ,strong) UITextField                           * passwdTextField;
@property (nonatomic ,strong) UITextField                           * ensurePasswdTextField;
@property (nonatomic ,strong) UITextField                           * studentNameTextField;
@property (nonatomic ,strong) UITextField                           * birthdayTextField;
@property (nonatomic ,strong) UITextField                           * genderTextField;

@property (nonatomic, strong) UIButton                                  * ensureButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
//    [_loginModel removeObserver:self forKeyPath:@"registerData"];
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
    self.title = @"注册";
    
    _loginModel = [[LoginModel alloc] init];
    
    
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
//    [backgroundView setImage:[UIImage imageNamed:@"登录注册bg.png"]];
    [backgroundView setImage:[UIImage imageNamed:@"注册全.png"]];
    [self.view addSubview:backgroundView];
    
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(150), FLEXIBLE_NUM(120), FLEXIBLE_NUM(735), FLEXIBLE_NUM(500))];
//    backView.backgroundColor = [UIColor colorWithRed:249/255.0 green:174/255.0 blue:216/255.0 alpha:1];
//    backView.layer.cornerRadius = FLEXIBLE_NUM(10);
//    backView.layer.borderColor = [[UIColor colorWithRed:178/255.0 green:92/255.0 blue:110/255.0 alpha:1] CGColor];
//    backView.layer.borderWidth = FLEXIBLE_NUM(5);
//    [self.view addSubview:backView];
    
    
    _userNameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(150), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
//        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _passwdTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(145 + 70), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _ensurePasswdTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(150 + 135), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _studentNameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(370), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _birthdayTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(350 + 85), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _genderTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(350 + 145), FLEXIBLE_NUM(270), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _ensureButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(380), FLEXIBLE_NUM(565), FLEXIBLE_NUM(280), FLEXIBLE_NUM(70))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
    
    
}

#pragma mark -- buttonClick
- (void) ensureButtonClick:(UIButton *) sender
{
    if ([_passwdTextField.text isEqualToString:_ensurePasswdTextField.text]) {
        
        ChooseFigureViewController * chooseVC = [[ChooseFigureViewController alloc] init];
        chooseVC.userName = _userNameTextField.text;
        chooseVC.passwd = _passwdTextField.text;
        chooseVC.studentName = _studentNameTextField.text;
        chooseVC.birthday = _birthdayTextField.text;
        chooseVC.gender = _genderTextField.text;
        [self.navigationController pushViewController:chooseVC animated:YES];
        
    }
    

    
}



@end
