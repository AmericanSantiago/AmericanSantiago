//
//  SetViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"
#import "LoginModel.h"
#import <AVFoundation/AVFoundation.h>

@interface SetViewController ()

@property (nonatomic, strong) UIImageView                       * headimageView;
@property (nonatomic, strong) UILabel                                   * nameLabel;

@property (nonatomic,strong)UISlider *volumeSlider;
@property (nonatomic,strong)UISlider *slider1;
@property (nonatomic,assign)CGPoint firstPoint;
@property (nonatomic,assign)CGPoint secondPoint;

@property (nonatomic, strong) UISlider  * brightnessSlider;
@property (nonatomic, strong) UISlider  * slider2;

@property (nonatomic ,strong) UIButton * exitButton;

@property (nonatomic, strong) LoginModel                    * loginModel;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_loginModel removeObserver:self forKeyPath:@"logoutData"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"logoutData"]) {
        if ([[_loginModel.logoutData valueForKey:@"errorCode"] integerValue] == 0) {
            
            LoginViewController * loginVC = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            [LBUserDefaults setUserDic:nil];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            [WINDOW.rootViewController presentViewController:nav animated:YES completion:^{
                WINDOW.rootViewController = nav;
            }];
            
            
        }
        
        
    }
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _loginModel = [[LoginModel alloc] init];
    [_loginModel addObserver:self forKeyPath:@"logoutData" options:NSKeyValueObservingOptionNew context:nil];

    //给音量键增加监听方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeClicked:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    //    但是仅仅监听是不起作用的，因为@"AVSystemController_SystemVolumeDidChangeNotification"需要对它进行响应，所以要在监听后加
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
}

- (void)initializeUserInterface
{
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView setImage:[UIImage imageNamed:@"设置音量bg"]];
    [self.view addSubview:backgroundView];
    
    //框
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(210), FLEXIBLE_NUM(180), FLEXIBLE_NUM(600), FLEXIBLE_NUM(340))];
    view1.backgroundColor = [UIColor colorWithRed:254/255.0 green:240/255.0 blue:202/255.0 alpha:1];
    view1.layer.cornerRadius = FLEXIBLE_NUM(15);
    view1.layer.borderWidth = FLEXIBLE_NUM(5);
    view1.layer.masksToBounds = YES;
    view1.clipsToBounds = YES;
    view1.layer.borderColor = [[UIColor colorWithRed:146/255.0 green:107/255.0 blue:40/255.0 alpha:1] CGColor];
    [self.view addSubview:view1];
    
    
    
//    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, 400, 40)];
//    
//    volumeView.center = CGPointMake(400,370);//设置中心点，让音量视图不显示在屏幕中
//    volumeView.backgroundColor = [UIColor yellowColor];
//    [volumeView sizeToFit];
//    
//    [self.view addSubview:volumeView];
    
    NSArray * titleArray = [[NSArray alloc] initWithObjects:@"音量",@"亮度", nil];
    NSArray * picArray = [[NSArray alloc] initWithObjects:@"矢量智能对象@3x",@"图层-5@3x", nil];
    for (int i = 0 ; i < 2; i ++ ) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(50), FLEXIBLE_NUM(105) + FLEXIBLE_NUM(105) * i, FLEXIBLE_NUM(30), FLEXIBLE_NUM(30))];
        [imageView setImage:[UIImage imageNamed:picArray[i]]];
        [view1 addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(100), FLEXIBLE_NUM(100) + FLEXIBLE_NUM(105) * i, FLEXIBLE_NUM(150), FLEXIBLE_NUM(40))];
        label.text = titleArray[i];
        label.textColor = [UIColor colorWithRed:146/255.0 green:107/255.0 blue:40/255.0 alpha:1];
        label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(28)];
//        label.font = [UIFont fontWithName:@"CTZhongYuanSJ" size:FLEXIBLE_NUM(28)];
//        label.backgroundColor = [UIColor yellowColor];
        [view1 addSubview:label];
    }
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    [self.view addSubview:volumeView];
    [volumeView sizeToFit];
//    NSLog(@"%@",volumeView.subviews);
    
    self.slider1 = [[UISlider alloc]init];
    self.slider1.backgroundColor = [UIColor blueColor];
    for (UIControl *view in volumeView.subviews) {
        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
//            NSLog(@"1");
            self.slider1 = (UISlider *)view;
        }
    }
    
    UISlider *volumeViewSlider= nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
    //获取当前系统的音量值
    float systemVolume1 = [AVAudioSession sharedInstance].outputVolume;
    
    self.slider1.autoresizesSubviews = NO;
    self.slider1.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.slider1];
    self.slider1.hidden = YES;
//    NSLog(@"%f",self.slider1.value);

    UIImage *stetchLeftTrack= [UIImage resizeImage:@"浅色音量条@2x"];
    UIImage *stetchRightTrack = [UIImage resizeImage:@"圆角矩形-2@2x"];
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"调节钮"];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(180), FLEXIBLE_NUM(110), FLEXIBLE_NUM(400), FLEXIBLE_NUM(20))];
    slider1.tag = 1000;
    slider1.minimumValue = self.slider1.minimumValue;
    slider1.maximumValue = self.slider1.maximumValue;
    [slider1 setMinimumTrackTintColor:[UIColor colorWithRed:146/255.0 green:107/255.0 blue:40/255.0 alpha:1]];
    slider1.value = systemVolume1;
    
    [slider1 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [slider1 setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [slider1 addTarget:self action:@selector(updateVolumeValue:) forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:slider1];
    
    
    //获取系统屏幕当前的亮度值
    float brightnessValue = [UIScreen mainScreen].brightness;
    //屏幕亮度控制
    self.slider2 = [[UISlider alloc]init];
    self.slider2.backgroundColor = [UIColor blueColor];
//    for (UIControl *view in volumeView.subviews) {
//        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
//            NSLog(@"2");
//            self.slider2 = (UISlider *)view;
//        }
//    }
    self.slider2.autoresizesSubviews = NO;
    self.slider2.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.slider2];
    self.slider2.hidden = YES;
//    NSLog(@"%f",self.slider1.value);

    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(180), FLEXIBLE_NUM(220), FLEXIBLE_NUM(400), FLEXIBLE_NUM(20))];
    slider2.tag = 2000;
    slider2.minimumValue = self.slider2.minimumValue;
    slider2.maximumValue = self.slider2.maximumValue;
    [slider2 setMinimumTrackTintColor:[UIColor colorWithRed:146/255.0 green:107/255.0 blue:40/255.0 alpha:1]];
//    slider2.value = self.slider2.value;
    
    [slider2 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [slider2 setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [slider2 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [slider2 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    slider2.value = brightnessValue;
    [slider2 addTarget:self action:@selector(updateBrightnessValue:) forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:slider2];
    
    _exitButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(335), FLEXIBLE_NUM(600), FLEXIBLE_NUM(350), FLEXIBLE_NUM(70))];
//        button.backgroundColor = [UIColor colorWithRed:59/255.0 green:174/255.0 blue:251/255.0 alpha:1];
        button.layer.cornerRadius = FLEXIBLE_NUM(8);
        [button setImage:[UIImage imageNamed:@"退出"] forState:UIControlStateNormal];
//        [button setTitle:@"退   出   登   录" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        [button addTarget:self action:@selector(exitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
}

#pragma mark -- buttonClick
- (void) exitButtonClick: (UIButton *)sender
{
    NSLog(@"退出登录");
//    UIAlertAction * alertAction = [[UIAlertAction alloc] init];
    
    UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确定退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_loginModel logoutWithUsername:[[[NSUserDefaults standardUserDefaults] valueForKey:@"loginInfo"] valueForKey:@"nickname"]];
        
    }];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}


#pragma mark --音量控制
- (void)updateVolumeValue:(UISlider *)slider{
    self.slider1.value = slider.value;
}

- (void)volumeChange
{
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:self.volumeSlider.value];
    
}
//#pragma mark -- 音量增加手势
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    for(UITouch *touch in event.allTouches) {
//        
//        self.firstPoint = [touch locationInView:self.view];
//        
//    }
//    
//    UISlider *slider = (UISlider *)[self.view viewWithTag:1000];
//    slider.value = self.slider1.value;
//    NSLog(@"touchesBegan");
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for(UITouch *touch in event.allTouches) {
//        
//        self.secondPoint = [touch locationInView:self.view];
//        
//    }
//    NSLog(@"firstPoint==%f || secondPoint===%f",self.firstPoint.y,self.secondPoint.y);
//    NSLog(@"first-second==%f",self.firstPoint.y - self.secondPoint.y);
//    
//    self.slider1.value += (self.firstPoint.y - self.secondPoint.y)/500.0;
//    
//    UISlider *slider = (UISlider *)[self.view viewWithTag:1000];
//    slider.value = self.slider1.value;
//    NSLog(@"value == %f",self.slider1.value);
//    self.firstPoint = self.secondPoint;
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesEnded");
//    self.firstPoint = self.secondPoint = CGPointZero;
//}

#pragma mark -- 亮度控制
- (void)updateBrightnessValue:(UISlider *)slider{

    //设置系统屏幕的亮度值
    [[UIScreen mainScreen] setBrightness:slider.value];
}

#pragma mark -- 音量键增加监听方法
-(void)volumeClicked:(NSNotification *)noti{
    //在这里我们就可以实现对音量键进行监听，完成响应的操作。noti中也有一些相关的信息可以看看
//    NSLog(@"!!!!!!!");
    
    UISlider * silder = (UISlider *)[self.view viewWithTag:1000];
    float volume = [[[noti userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    silder.value = volume;
//    NSLog(@"current volume = %f", volume);
}


@end
