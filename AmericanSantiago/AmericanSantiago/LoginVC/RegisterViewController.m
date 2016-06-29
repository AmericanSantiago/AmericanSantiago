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
#import "SRMonthPicker.h"

@interface RegisterViewController ()<SRMonthPickerDelegate, UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) LoginModel                        * loginModel;

@property (nonatomic ,strong) UITextField                           * userNameTextField;
@property (nonatomic ,strong) UITextField                           * passwdTextField;
@property (nonatomic ,strong) UITextField                           * ensurePasswdTextField;
@property (nonatomic ,strong) UITextField                           * studentNameTextField;
@property (nonatomic ,strong) UITextField                           * birthdayTextField;
@property (nonatomic ,strong) UITextField                           * genderTextField;
@property (nonatomic, strong) UIButton                                  * ensureButton;

@property (strong, nonatomic)SRMonthPicker                  *monthPicker;

@property (nonatomic, strong) UIPickerView                      * pickerView;
@property (nonatomic, strong) NSArray                               * genderArray;

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
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(154), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
//        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _passwdTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(152 + 70), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _ensurePasswdTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(152 + 135), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _studentNameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(376), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _birthdayTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(353 + 85), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    //SRMonthPicker
    //添加一个时间选择器
    self.monthPicker = [[SRMonthPicker alloc] init];
    self.monthPicker.monthPickerDelegate = self;
    
    // Set the label to show the date
    self.birthdayTextField.text = [NSString stringWithFormat:@"%@", [self formatDate:self.monthPicker.date]];
    
    // Some options to play around with
    self.monthPicker.maximumYear = @2020;
    self.monthPicker.minimumYear = @1900;
    self.monthPicker.yearFirst = YES;
    
    //当光标移动到文本框的时候，召唤时间选择器
    self.birthdayTextField.inputView=_monthPicker;

    _genderTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(450), FLEXIBLE_NUM(354 + 145), FLEXIBLE_NUM(270), FLEXIBLE_NUM(34))];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(25)];
        //        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField;
    });
    
    _pickerView = ({
        UIPickerView * pickerView = [[UIPickerView alloc] init];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [pickerView reloadAllComponents];               //刷新pickerView
        pickerView;
    });
    _genderArray = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
    _genderTextField.inputView = _pickerView;
    
    
    _ensureButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(380), FLEXIBLE_NUM(565), FLEXIBLE_NUM(280), FLEXIBLE_NUM(70))];
        button.backgroundColor = [UIColor clearColor];
        
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
    
    
}

//返回列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _genderArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_genderArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _genderTextField.text = [_genderArray objectAtIndex:row];
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


#pragma mark - SRMonthPickerDelegate
- (NSString*)formatDate:(NSDate *)date
{
    // A convenience method that formats the date in Month-Year format
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    return [formatter stringFromDate:date];
}

- (void)monthPickerWillChangeDate:(SRMonthPicker *)monthPicker
{
    // Show the date is changing (with a 1 second wait mimicked)
    self.birthdayTextField.text = [NSString stringWithFormat:@"%@", [self formatDate:monthPicker.date]];
}

- (void)monthPickerDidChangeDate:(SRMonthPicker *)monthPicker
{
    // All this GCD stuff is here so that the label change on -[self monthPickerWillChangeDate] will be visible
    dispatch_queue_t delayQueue = dispatch_queue_create("com.simonrice.SRMonthPickerExample.DelayQueue", 0);
    
    dispatch_async(delayQueue, ^{
        // Wait 1 second
        //        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.birthdayTextField.text = [NSString stringWithFormat:@"%@", [self formatDate:self.monthPicker.date]];
        });
    });
    
    
    
}

#pragma mark -- 点击背景回收键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
