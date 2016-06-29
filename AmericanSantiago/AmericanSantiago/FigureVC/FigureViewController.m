//
//  FigureViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "FigureViewController.h"
#import "FigureModel.h"

@interface FigureViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton                            * boyButton;
@property (nonatomic, strong) UIButton                            * girlButton;

@property (nonatomic ,strong) UIButton                             * genderButton;
@property (nonatomic, strong) UIImageView                   * figerImageView;//人物图View
@property (nonatomic ,strong) NSString                         * buttonIndex;

@property (nonatomic, strong) UITextField                       * nameTextField;
@property (nonatomic, strong) UITextField                       * nicknameTextField;
@property (nonatomic, strong) UITextField                       * birthdayTextField;
@property (nonatomic ,strong) UITextField                       * ageTextField;
@property (nonatomic ,strong) UITextField                       * genderTextField;

@property (nonatomic ,strong) UIDatePicker                   * datePicker;

@property (nonatomic ,strong) UIButton                              * ensureButton;
@property (nonatomic, strong) FigureModel                       * figureModel;

@end

@implementation FigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"人物";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_figureModel removeObserver:self forKeyPath:@"updateInfoData"];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"updateInfoData"]) {
        if ([[_figureModel.updateInfoData valueForKey:@"errorCode"] integerValue] == 0) {
            [AppDelegate showHintLabelWithMessage:@"修改成功!"];
        }else{
            [AppDelegate showHintLabelWithMessage:@"修改失败!"];
            
        }
        
        
    }
    
    
}

- (void)initializeDataSource
{
    _figureModel = [[FigureModel alloc] init];
    [_figureModel addObserver:self forKeyPath:@"updateInfoData" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)initializeUserInterface
{
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
//    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView setImage:[UIImage imageNamed:@"排版girl-bg.png"]];
//    backgroundView.alpha = 0.6;
    [self.view addSubview:backgroundView];
    
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    
    //框
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(120), FLEXIBLE_NUM(100), FLEXIBLE_NUM(450), FLEXIBLE_NUM(500))];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = FLEXIBLE_NUM(15);
    view1.layer.borderWidth = FLEXIBLE_NUM(5);
    view1.layer.masksToBounds = YES;
    view1.clipsToBounds = YES;
    view1.layer.borderColor = [[UIColor orangeColor] CGColor];
    [self.view addSubview:view1];
    
    NSArray * titleArray = [[NSArray alloc] initWithObjects:@"全名",@"昵称",@"生日",@"年龄",@"性别" ,nil];
    for (int i = 0; i < 5; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(40), FLEXIBLE_NUM(40) + FLEXIBLE_NUM(90) * i, FLEXIBLE_NUM(150), FLEXIBLE_NUM(40))];
        label.text = titleArray[i];
//        label.textColor = [UIColor colorWithRed:208/255.0 green:168/255.0 blue:72/255.0 alpha:1];
        label.textColor = [UIColor orangeColor];
//        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];

        label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(30)];
        [view1 addSubview:label];
    }
    
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
    
    _nameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(140), FLEXIBLE_NUM(40), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.text = [userDic valueForKey:@"username"];
        [view1 addSubview:textField];
        textField;
    });
    
    _nicknameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(140), FLEXIBLE_NUM(130), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.text = [userDic valueForKey:@"nickname"];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [view1 addSubview:textField];
        textField;
    });
    
    _birthdayTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(140), FLEXIBLE_NUM(220), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.textAlignment = NSTextAlignmentCenter;
        textField.text = [userDic valueForKey:@"birthday"];
        textField.delegate = self;
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [view1 addSubview:textField];
        textField;
    });
    
    _ageTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(140), FLEXIBLE_NUM(310), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.userInteractionEnabled = NO;
        [view1 addSubview:textField];
        textField;
    });
    
    _genderTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(140), FLEXIBLE_NUM(400), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.userInteractionEnabled = NO;
        textField.text = @"男";
        [view1 addSubview:textField];
        textField;
    });
    if ([[userDic valueForKey:@"gender"] integerValue] == 0) {
        _genderTextField.text = @"男";
    }else{
        _genderTextField.text = @"女";
    }
    
    
    //UIDatePicker
    //添加一个时间选择器
    _datePicker=[[UIDatePicker alloc]init];
    _datePicker.tag = 123321;
    [_datePicker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventValueChanged];
    [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    _datePicker.datePickerMode=UIDatePickerModeDate;

    NSDate * localData = [NSDate date];
    _datePicker.maximumDate = localData;

    
    //当光标移动到文本框的时候，召唤时间选择器
    self.birthdayTextField.inputView=_datePicker;
    
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //人物
    _figerImageView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(350), FLEXIBLE_NUM(70), FLEXIBLE_NUM(750), FLEXIBLE_NUM(600))];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"boy.png"];
        [self.view addSubview:imageView];
        imageView;
    });
    
    _buttonIndex = @"1";
    _genderButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(870), FLEXIBLE_NUM(320), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        button.tag = 321;
        [button setBackgroundImage:[UIImage imageNamed:@"向左@3x"] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(genderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _ensureButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(335), FLEXIBLE_NUM(650), FLEXIBLE_NUM(250), FLEXIBLE_NUM(70))];
        [button setBackgroundImage:[UIImage imageNamed:@"用户名密码@3x"] forState:UIControlStateNormal];
        [button setTitle:@"确  认  修  改" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    //计算年龄
    NSString *birth = _birthdayTextField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",age);
    _ageTextField.text = [NSString stringWithFormat:@"%d岁",age];
    
    
}

#pragma mark -- buttonClick
- (void) genderButtonClick: (UIButton *) sender
{
    NSLog(@"buttonIndex == %@",_buttonIndex);
    if ([_buttonIndex isEqualToString:@"1"]) {
        [_figerImageView setImage:[UIImage imageNamed:@"girl.png"]];
        _buttonIndex = @"0";
        _genderTextField.text = @"女";
        [_genderButton setBackgroundImage:[UIImage imageNamed:@"向右@3x"] forState:UIControlStateNormal];
    }else{
        [_figerImageView setImage:[UIImage imageNamed:@"boy.png"]];
        _buttonIndex = @"1";
        _genderTextField.text = @"男";
        [_genderButton setBackgroundImage:[UIImage imageNamed:@"向左@3x"] forState:UIControlStateNormal];
    }
    
}

- (void) ensureButtonClick: (UIButton *) sender
{
    
    if ([_genderTextField.text isEqualToString:@"男"]) {
            [_figureModel updateInfoWithNickname:_nicknameTextField.text Name:_nameTextField.text Birthday:_birthdayTextField.text Gender:@"1"  Charactertype:@"boy" username:_nameTextField.text];
    }else{
            [_figureModel updateInfoWithNickname:_nicknameTextField.text Name:_nameTextField.text Birthday:_birthdayTextField.text Gender:@"0" Charactertype:@"girl" username:_nameTextField.text];
    }
    
    
}

- (void) buttonClick:(UIButton *) sender
{
    NSLog(@"button.tag = %ld",(long)sender.tag);
    
}



#pragma mark - UITextFieldDelegate
- (void) dataPickerValueChange: (id) sender
{
    UIDatePicker * control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *loctime = [formatter stringFromDate:_date];
    _birthdayTextField.text = loctime;
    NSDate *now = [NSDate date];
    
    //计算年龄
    NSString *birth = _birthdayTextField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",age);
    _ageTextField.text = [NSString stringWithFormat:@"%d岁",age];
}


#pragma mark -- 点击背景回收键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
