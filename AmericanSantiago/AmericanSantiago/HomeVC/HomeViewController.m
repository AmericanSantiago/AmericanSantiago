//
//  HomeViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "HomeViewController.h"
#import "ClassroomViewController.h"
#import "WorldViewController.h"
#import "BuildingViewController.h"
#import "CityViewController.h"
#import "BuildingViewController.h"
#import "PlaygroundViewController.h"
#import "HomeModel.h"


@interface HomeViewController ()

@property (nonatomic, strong) UIImageView                    * backgroundView;
@property (nonatomic, strong) UIImageView                    * bigImageView;
@property (nonatomic, strong) UIImageView                    * smallImageView;

@property (nonatomic ,strong) HomeModel                         * homeModel;

@property (nonatomic, strong) UIButton                                 * button;

@property (nonatomic, strong) NSArray                                   * schoolGameArray;
@property (nonatomic, strong) NSArray                                   * worldGameArray;
@property (nonatomic, strong) NSArray                                   * playgroundGameArray;
@property (nonatomic, strong) NSArray                                   * cityGameArray;
@property (nonatomic, strong) NSArray                                   * homeGameArray;
@property (nonatomic, strong) NSArray                                   * locationArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
    [_homeModel removeObserver:self forKeyPath:@"allUnlockedGamesData"];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"allUnlockedGamesData"]) {
        
        
//        NSLog(@"games = %@",[_homeModel.allUnlockedGamesData valueForKey:@"data"]);
        
        for (int i = 0; i < [[[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"]count]; i ++) {
//            for (int j = 0; j < [[[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"] valueForKey:@""]; <#increment#>) {
//                <#statements#>
//            }
            
            
            if ([[[_homeModel.allUnlockedGamesData valueForKey:@"data"][i] valueForKey:@"scene"] isEqualToString:@"school"]) {
                _schoolGameArray = [[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"][i];
            }
            if ([[[_homeModel.allUnlockedGamesData valueForKey:@"data"][i] valueForKey:@"scene"] isEqualToString:@"world"]) {
                _worldGameArray = [[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"][i];
            }
            if ([[[_homeModel.allUnlockedGamesData valueForKey:@"data"][i] valueForKey:@"scene"] isEqualToString:@"playground"]) {
                _playgroundGameArray = [[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"][i];
            }

            if ([[[_homeModel.allUnlockedGamesData valueForKey:@"data"][i] valueForKey:@"scene"] isEqualToString:@"city"]) {
                _cityGameArray = [[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"][i];
            }
            if ([[[_homeModel.allUnlockedGamesData valueForKey:@"data"][i] valueForKey:@"scene"] isEqualToString:@"home"]) {
                _homeGameArray = [[_homeModel.allUnlockedGamesData valueForKey:@"data"] valueForKey:@"games"][i];
            }
            
        }
//        NSLog(@"homeArray = %@",_homeGameArray);
        NSLog(@"_schoolGameArray = %@",_schoolGameArray);
//        NSLog(@"_cityGameArray = %@",_cityGameArray);
        
        //添加锁或者数字
        if (_schoolGameArray) {
            [self addNumWithButtonTag:1001 Number:[NSString stringWithFormat:@"%lu",(unsigned long)_schoolGameArray.count] subView:_smallImageView];
        }else{
            [self addLockWithButtonTag:1001 subView:_button];
        }
        
        if (_worldGameArray) {
            [self addNumWithButtonTag:1002 Number:[NSString stringWithFormat:@"%lu",(unsigned long)_worldGameArray.count] subView:_smallImageView];
        }else{
            [self addLockWithButtonTag:1002 subView:_button];
        }
        
        if (_playgroundGameArray) {
            [self addNumWithButtonTag:1003 Number:[NSString stringWithFormat:@"%lu",(unsigned long)_playgroundGameArray.count] subView:_smallImageView];
        }else{
            [self addLockWithButtonTag:1003 subView:_button];
        }
        
        if (_cityGameArray) {
            [self addNumWithButtonTag:1004 Number:[NSString stringWithFormat:@"%lu",(unsigned long)_cityGameArray.count] subView:_smallImageView];
        }else{
            [self addLockWithButtonTag:1004 subView:_button];
        }
        
        if (_homeGameArray) {
            [self addNumWithButtonTag:1005 Number:[NSString stringWithFormat:@"%lu",(unsigned long)_homeGameArray.count] subView:_smallImageView];
        }else{
            [self addLockWithButtonTag:1005 subView:_button];
        }
        
        
        


        
        
        
        
    }
    
    
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

- (void)initializeDataSource
{
    //2:World    3:
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    [_homeModel addObserver:self forKeyPath:@"allUnlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    
//    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"home"];
    
    if ([[LBUserDefaults getUserDic] valueForKey:@"username"]) {
        [_homeModel getAllUnlockedGamesUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] subjectId:@"Math"];
    }else{
//        [_homeModel getAllUnlockedGamesUsername:@"0" subjectId:@"Math"];
        
    }
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetNextConceptData) name:@"getNewGamesData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAllUnlockGames:) name:@"updateAllUnlockGames" object:nil];
    
}
- (void) getNextConceptData:(NSNotification *) notifi
{
    [_homeModel getGetNextConceptWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math"];
    
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    
    _backgroundView = ({
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:BASESCRREN_B];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.tag = 1;
        [backgroundView setImage:[UIImage imageNamed:@"root_bg"]];
        [self.view addSubview:backgroundView];
        backgroundView;
    });
    
    _bigImageView = ({
        UIImageView * bigView = [[UIImageView alloc] initWithFrame:CGRectMake(0,FLEXIBLE_NUM(77),FLEXIBLE_NUM(720), FLEXIBLE_NUM(484))];
        bigView.center = CGPointMake(BASESCRREN_W/2,bigView.center.y);
        //        bigView.backgroundColor = [UIColor yellowColor];
        [bigView setImage:[UIImage imageNamed:@"home_school_bg"]];
        bigView.layer.cornerRadius = FLEXIBLE_NUM(10);
        bigView.layer.masksToBounds = YES;
        bigView.layer.borderColor = [UIColor whiteColor].CGColor;
        bigView.layer.borderWidth = FLEXIBLE_NUM(4);
        [self.view addSubview:bigView];
        bigView;
    });
    
    NSArray * picArray = [[NSArray alloc] initWithObjects:@"主界面1",@"主界面2",@"主界面3",@"主界面4",@"主界面5", nil];
    
    CGFloat width = FLEXIBLE_NUM(166);
    CGFloat height = FLEXIBLE_NUM(114);
    CGFloat offset = (BASESCRREN_W-FLEXIBLE_NUM(36)*2-width*picArray.count)/(picArray.count-1);
    CGFloat maxX = FLEXIBLE_NUM(36)-offset;
    CGFloat maxY = BASESCRREN_H - (BASESCRREN_H-CGRectGetMaxY(_bigImageView.frame))/2 - height/2;
    
    for (int i = 0 ; i < 5; i ++) {
        
        _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(maxX+offset,maxY,width,height)];
        [_smallImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArray[i]]]];
        _smallImageView.layer.cornerRadius = FLEXIBLE_NUM(8);
        _smallImageView.layer.masksToBounds = YES;
        _smallImageView.tag = 1001 + i;
        _smallImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _smallImageView.layer.borderWidth = FLEXIBLE_NUM(3);
        [self.view addSubview:_smallImageView];
        
        _button = [[UIButton alloc] initWithFrame:CGRectMake(maxX+offset,maxY,width,height)];
        _button.backgroundColor = [UIColor clearColor];
        _button.tag = 101 + i;
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArray[i]]] forState:UIControlStateNormal];
//        _button.layer.cornerRadius = FLEXIBLE_NUM(8);
//        _button.layer.masksToBounds = YES;
//        _button.layer.borderColor = [UIColor whiteColor].CGColor;
//        _button.layer.borderWidth = FLEXIBLE_NUM(3);
//        [self.view insertSubview:_button atIndex:999];
        maxX = CGRectGetMaxX(_button.frame);
        [self.view addSubview:_button];
    }
    
    
    
    
}

#pragma mark -- button action
- (void) buttonClick:(UIButton *) sender
{
    NSLog(@"button.tag == %ld",(long)sender.tag);
    [_bigImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"主界面%ld",(long)sender.tag - 100]]];
    _backgroundView.tag = sender.tag - 100;
}







//跳转
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"background.tag = %ld",(long)_backgroundView.tag);
    switch (_backgroundView.tag) {
        case 1:{
            ClassroomViewController * classroomVC = [[ClassroomViewController alloc] init];
            classroomVC.classroomGamesArray = _schoolGameArray;
            [self.translationController pushViewController:classroomVC];
        }
            break;
        case 2:{
            WorldViewController * worldVC = [[WorldViewController alloc] init];
            [self.translationController pushViewController:worldVC];
        }
            break;
        case 3:{
            PlaygroundViewController * playgroundVC = [[PlaygroundViewController alloc] init];
            [self.translationController pushViewController:playgroundVC];
        }
            break;
        case 4:{
            CityViewController * cityVC = [[CityViewController alloc] init];
            [self.translationController pushViewController:cityVC];
        }
            break;
        case 5:{
            BuildingViewController * bulidingVC = [[BuildingViewController alloc] init];
            [self.translationController pushViewController:bulidingVC];
        }
            
            break;
        default:
            break;
    }    
    
//    BaseViewController *baseVC = [[BaseViewController alloc]init];
//    baseVC.title = [NSString stringWithFormat:@"%@主页",@([self.title integerValue])];
//    [self.translationController pushViewController:baseVC];
}

- (UIView *) addNumWithButtonTag:(int ) tag Number:(NSString *)number subView:(UIView *)subView
{
    UIButton * button = (UIButton *)[self.view viewWithTag:tag];
    subView = (UIView *)[self.view viewWithTag:tag];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(0), FLEXIBLE_NUM(0), button.frame.size.width, button.frame.size.height)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setImage:[UIImage imageNamed:@"气泡@3x"]];
//    imageView.alpha = 0.7;
//    [imageView sizeToFit];
    imageView.contentMode = UIViewContentModeCenter;
    [subView addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(73), FLEXIBLE_NUM(37), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
    label.textColor = [UIColor redColor];
    label.text = number;
    label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(38)];
    [imageView addSubview:label];
    
    return imageView;
}

- (UIView *) addLockWithButtonTag:(int ) tag subView:(UIView *)subView
{
    UIButton * button = (UIButton *)[self.view viewWithTag:tag];
    subView = (UIView *)[self.view viewWithTag:tag];
    button.userInteractionEnabled = NO;
    subView.userInteractionEnabled = YES;
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(0), FLEXIBLE_NUM(0), button.frame.size.width, button.frame.size.height)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.5;
    [subView addSubview:view1];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(50), FLEXIBLE_NUM(27), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setImage:[UIImage imageNamed:@"锁"]];
    //    imageView.alpha = 0.7;
//        [imageView sizeToFit];
//    imageView.contentMode = UIViewContentModeCenter;
    [view1 addSubview:imageView];
    
    return imageView;
}



- (void) updateAllUnlockGames:(NSNotification *) notifi
{
    
//        [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"home"];
 
    [_homeModel getAllUnlockedGamesUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] subjectId:@"Math"];
}


@end
