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

@property (nonatomic ,strong) HomeModel                         * homeModel;



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
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {

}

- (void)initializeDataSource
{
    //2:World    3:
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    
//    [_homeModel getGetUnlockedGamesWithUsername:@"000" SubjectId:@"Math" SceneType:@"home"];
    [_homeModel getGetNextConceptWithUsername:@"000" SubjectId:@"Math"];
    
//    [_homeModel sendGameLogWithUsername:@"mwk" conceptId:@"1" gameId:@"1" learningType:@"L" duration:@"10" clickCount:@"100" log:@"1"];
    
    [_homeModel getAllUnlockedGamesUsername:@"000" subjectId:@"Math"];
    
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
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(maxX+offset,maxY,width,height)];
        button.backgroundColor = [UIColor yellowColor];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArray[i]]] forState:UIControlStateNormal];
        button.layer.cornerRadius = FLEXIBLE_NUM(8);
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = FLEXIBLE_NUM(3);
        
        maxX = CGRectGetMaxX(button.frame);
        [self.view addSubview:button];
    }
    
//    for (int i = 0; i < 5; i ++) {
//        
//        UIButton * button = (UIButton *)[self.view viewWithTag:100 + i];
//        
//        [self addNumWithButtonTag:1 Number:@"2"];
//        
//    }
    
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

//- (UIView *) addNumWithButtonTag:(int ) tag Number:(NSString *)number
//{
//    UIButton * button = (UIButton *)[self.view viewWithTag:100];
//    
//    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(0), FLEXIBLE_NUM(0), button.frame.size.width, button.frame.size.height)];
//    view1.backgroundColor = [UIColor whiteColor];
//    view1.alpha = 0.5;
//    [button addSubview:view1];
//    
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(50), FLEXIBLE_NUM(50))];
//    label.textColor = [UIColor redColor];
//    label.center = FLEXIBLE_CENTER(button.frame.origin.x/2, button.frame.origin.y/2);
//    label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(28)];
//    [view1 addSubview:label];
//    
//    
//    return view1;
//}


@end
