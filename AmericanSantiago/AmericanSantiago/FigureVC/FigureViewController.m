//
//  FigureViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "FigureViewController.h"
#import "FigureModel.h"
#import "SRMonthPicker.h"

@interface FigureViewController ()<UITextFieldDelegate, SRMonthPickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

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

@property (nonatomic ,strong) UIButton                              * ensureButton;
@property (nonatomic, strong) FigureModel                       * figureModel;

//@property (nonatomic, strong) NewDatePickerView             * datePicker;
@property (strong, nonatomic)SRMonthPicker                  *monthPicker;

@property (nonatomic, strong) UIPickerView                      * pickerView;
@property (nonatomic, strong) NSArray                               * genderArray;

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
    
    //遍历字体名称
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
    
    
    NSArray * titleArray = [[NSArray alloc] initWithObjects:@"用户名",@"昵  称",@"生  日",@"年  龄",@"性  别" ,nil];
    for (int i = 0; i < 5; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(40), FLEXIBLE_NUM(40) + FLEXIBLE_NUM(90) * i, FLEXIBLE_NUM(150), FLEXIBLE_NUM(40))];
        label.text = titleArray[i];
//        label.textColor = [UIColor colorWithRed:208/255.0 green:168/255.0 blue:72/255.0 alpha:1];
        label.textColor = [UIColor orangeColor];
//        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(30)];
//        label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(30)];
        label.font = [UIFont fontWithName:@"经典细圆简" size:FLEXIBLE_NUM(30)];
//        label.font = [UIFont fontWithName:@"Tsukushi A Round Gothic" size:FLEXIBLE_NUM(30)];
        [view1 addSubview:label];
    }
    
    
    _nameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(155), FLEXIBLE_NUM(40), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.text = [NSString stringWithFormat:@"%@",[userDic valueForKey:@"username"]];
        [view1 addSubview:textField];
        textField;
    });
    
    _nicknameTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(155), FLEXIBLE_NUM(130), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.text = [NSString stringWithFormat:@"%@",[userDic valueForKey:@"nickname"]];
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [view1 addSubview:textField];
        textField;
    });
    
    _birthdayTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(155), FLEXIBLE_NUM(220), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.textAlignment = NSTextAlignmentCenter;
        textField.text = [NSString stringWithFormat:@"%@",[userDic valueForKey:@"birthday"]];
        textField.delegate = self;
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [view1 addSubview:textField];
        textField;
    });
    
    _ageTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(155), FLEXIBLE_NUM(310), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.userInteractionEnabled = NO;
        [view1 addSubview:textField];
        textField;
    });
    
    _genderTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(155), FLEXIBLE_NUM(400), FLEXIBLE_NUM(220), FLEXIBLE_NUM(40))];
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = FLEXIBLE_NUM(20);
        textField.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        textField.textAlignment = NSTextAlignmentCenter;
//        textField.userInteractionEnabled = NO;
        
        if ([[userDic valueForKey:@"gender"] integerValue] == 0) {
            textField.text = @"女";
        }else{
            textField.text = @"男";
        }
        [view1 addSubview:textField];
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
    
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //人物
    _figerImageView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(350), FLEXIBLE_NUM(70), FLEXIBLE_NUM(750), FLEXIBLE_NUM(600))];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"boy.png"];
        if ([[userDic valueForKey:@"characterType"] isEqualToString:@"boy"]) {
            imageView.image = [UIImage imageNamed:@"boy.png"];
        }else{
            imageView.image = [UIImage imageNamed:@"girl.png"];
        }
        [self.view addSubview:imageView];
        imageView;
    });
    
    _buttonIndex = @"1";
    _genderButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(870), FLEXIBLE_NUM(320), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        button.tag = 321;
        [button setBackgroundImage:[UIImage imageNamed:@"向右@3x"] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(genderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _ensureButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(355), FLEXIBLE_NUM(650), FLEXIBLE_NUM(310), FLEXIBLE_NUM(60))];
        [button setBackgroundImage:[UIImage imageNamed:@"确认修改@3x"] forState:UIControlStateNormal];
//        [button setTitle:@"确  认  修  改" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(20)];
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    //计算年龄
    NSString *birth = _birthdayTextField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
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
        [_figerImageView setImage:[UIImage imageNamed:@"boy.png"]];
        _buttonIndex = @"0";
//        _genderTextField.text = @"女";
        [_genderButton setBackgroundImage:[UIImage imageNamed:@"向左@3x"] forState:UIControlStateNormal];
    }else{
        [_figerImageView setImage:[UIImage imageNamed:@"girl.png"]];
        _buttonIndex = @"1";
//        _genderTextField.text = @"男";
        [_genderButton setBackgroundImage:[UIImage imageNamed:@"向右@3x"] forState:UIControlStateNormal];
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
            
            
            //计算年龄
            NSString *birth = _birthdayTextField.text;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM"];
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
            
        });
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



#pragma mark -- 点击背景回收键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
