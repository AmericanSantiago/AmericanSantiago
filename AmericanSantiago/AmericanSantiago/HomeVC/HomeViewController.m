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


//当前没有教学知识点-进入游戏-选择课程-完成教学游戏-获取教学知识点-

@interface HomeViewController ()

@property (nonatomic, strong) UIImageView                    * backgroundView;
@property (nonatomic, strong) UIImageView                    * bigImageView;
//@property (nonatomic, strong) UIImageView                    * smallImageView;

@property (nonatomic ,strong) HomeModel                         * homeModel;

//@property (nonatomic, strong) UIButton                                 * button;


@property (strong, nonatomic) NSMutableArray *conceptGamesArray;//当前教学知识点游戏
//@property (strong, nonatomic) NSMutableArray *allGamesArray;//所有游戏的列表
//@property (nonatomic, strong) NSMutableArray                                   * schoolGameArray;
//@property (nonatomic, strong) NSMutableArray                                   * worldGameArray;
//@property (nonatomic, strong) NSMutableArray                                   * playgroundGameArray;
//@property (nonatomic, strong) NSMutableArray                                   * cityGameArray;
//@property (nonatomic, strong) NSMutableArray                                   * homeGameArray;
@property (nonatomic, strong) NSMutableArray                                   * locationArray;

@property (nonatomic, strong) NSString                                      * numMark;
@property (nonatomic, strong) NSString                                      * lockMark;                     //是否添加了锁
@property (assign, nonatomic) BOOL shouldSaveNewGames;//判断是否需要添加新游戏的缓存

@end

@implementation HomeViewController

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
    [_homeModel removeObserver:self forKeyPath:@"allUnlockedGamesData"];
    [_homeModel removeObserver:self forKeyPath:@"GetNextConceptData"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllUnlockedGamesData:) name:@"getAllUnlockedGamesData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadConceptGamesData:) name:@"reloadConceptGamesData" object:nil];
    self.title = @"主页";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    //2:World    3:
    self.shouldSaveNewGames = NO;
    NSArray *tempArray = @[@[],@[],@[],@[],@[]];
    self.conceptGamesArray = [NSMutableArray arrayWithArray:tempArray];
    
    _lockMark = @"1";
    //    _numMark = @"1";
    
    //    _schoolGameArray = [[NSMutableArray alloc] init];
    //    _worldGameArray = [[NSMutableArray alloc] init];
    //    _playgroundGameArray = [[NSMutableArray alloc] init];
    //    _cityGameArray = [[NSMutableArray alloc] init];
    //    _homeGameArray = [[NSMutableArray alloc] init];
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"nextConceptData" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    
    _backgroundView = ({
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:BASESCRREN_B];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.tag = 0;
        [backgroundView setImage:[UIImage imageNamed:@"root_bg"]];
        [self.view addSubview:backgroundView];
        backgroundView;
    });
    
    _bigImageView = ({
        UIImageView * bigView = [[UIImageView alloc] initWithFrame:CGRectMake(0,FLEXIBLE_NUM(77),FLEXIBLE_NUM(720), FLEXIBLE_NUM(484))];
        bigView.center = CGPointMake(BASESCRREN_W/2,bigView.center.y);
        //        bigView.backgroundColor = [UIColor yellowColor];
        [bigView setImage:[UIImage imageNamed:@"主界面1"]];
        bigView.layer.cornerRadius = FLEXIBLE_NUM(10);
        bigView.layer.masksToBounds = YES;
        bigView.layer.borderColor = [UIColor whiteColor].CGColor;
        bigView.layer.borderWidth = FLEXIBLE_NUM(4);
        bigView.userInteractionEnabled = YES;
        bigView.tag = 0;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        //        singleTap.numberOfTouchesRequired = 1; //手指数
        //        singleTap.numberOfTapsRequired = 1; //tap次数
        //        singleTap.delegate= self;
        [bigView addGestureRecognizer:singleTap];
        
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
        
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(maxX+offset,maxY,width,height)];
        [smallImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArray[i]]]];
        smallImageView.layer.cornerRadius = FLEXIBLE_NUM(8);
        smallImageView.layer.masksToBounds = YES;
        smallImageView.tag = IMGVIEW_TAG + i;
        smallImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        smallImageView.layer.borderWidth = FLEXIBLE_NUM(3);
        [self.view addSubview:smallImageView];
        
        UIButton *lockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        [lockBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        lockBtn.center = smallImageView.center;
        lockBtn.tag = BUTTON_TAG+10+i;
        lockBtn.titleLabel.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        [lockBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:lockBtn];
        
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(maxX+offset,maxY,width,height)];
        iconBtn.backgroundColor = [UIColor clearColor];
        iconBtn.tag = BUTTON_TAG + i;
        [iconBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        maxX = CGRectGetMaxX(iconBtn.frame);
        [self.view addSubview:iconBtn];
    }
   
    
    [self reloadConceptGamesData:nil];                      //有bug   
//    [self getNextConceptData:nil];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"allUnlockedGamesData"]) {
//        [self allUnlockedGamesDataParse];
//    }
    if ([keyPath isEqualToString:@"nextConceptData"]) {
        [self nextConceptDataParse];
    }
}

- (void)whenClickImage: (UITapGestureRecognizer *)gesture
{
    switch (_backgroundView.tag) {
        case 0:{
            ClassroomViewController * classroomVC = [[ClassroomViewController alloc] init];
            //                classroomVC.classroomGamesArray = _schoolGameArray;
            classroomVC.classroomGamesArray = self.conceptGamesArray[_backgroundView.tag];
            [self.translationController pushViewController:classroomVC];
        }
            break;
        case 1:{
            WorldViewController * worldVC = [[WorldViewController alloc] init];
            worldVC.worldGamesArray = self.conceptGamesArray[_backgroundView.tag];
            [self.translationController pushViewController:worldVC];
        }
            break;
        case 2:{
            PlaygroundViewController * playgroundVC = [[PlaygroundViewController alloc] init];
            playgroundVC.playgroundGamesArray = self.conceptGamesArray[_backgroundView.tag];
            [self.translationController pushViewController:playgroundVC];
        }
            break;
        case 3:{
            CityViewController * cityVC = [[CityViewController alloc] init];
            cityVC.cityGameArray = self.conceptGamesArray[_backgroundView.tag];
            [self.translationController pushViewController:cityVC];
        }
            break;
        case 4:{
            BuildingViewController * bulidingVC = [[BuildingViewController alloc] init];
            bulidingVC.bulidingGamesArray = self.conceptGamesArray[_backgroundView.tag];
            [self.translationController pushViewController:bulidingVC];
        }
            
            break;
        default:
            break;
    }
    
    
    
}


#pragma mark -- button action
- (void) buttonClick:(UIButton *) sender
{
    [_bigImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"主界面%@",@(sender.tag-BUTTON_TAG+1)]]];
    _backgroundView.tag = sender.tag - BUTTON_TAG;
}

- (void)addNumWithButtonTag:(NSInteger)tag Number:(NSInteger)number isLock:(BOOL)isLock
{
    UIButton *button = (UIButton *)[self.view viewWithTag:tag-10];
    button.userInteractionEnabled = !isLock;
    
    UIButton *lockBtn = (UIButton *)[self.view viewWithTag:tag];
    [lockBtn setTitle:@"" forState:UIControlStateNormal];
    [lockBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    if (isLock) {
        [lockBtn setBackgroundImage:[UIImage imageNamed:@"锁"] forState:UIControlStateNormal];
    }else{
        if (number > 0) {
            [lockBtn setBackgroundImage:[UIImage imageNamed:@"气泡"] forState:UIControlStateNormal];
            [lockBtn setTitle:[NSString stringWithFormat:@"%ld",(long)number] forState:UIControlStateNormal];
        }
        
    }
}

//- (void)addLockWithButtonTag:(int)tag
//{
//    UIButton *button = (UIButton *)[self.view viewWithTag:tag];
//    if (button) {
//        UIImageView *lockImgView = (UIImageView *)[button viewWithTag:IMGVIEW_TAG];
//        if (lockImgView) {
//            [lockImgView removeFromSuperview];
//        }
//    }
//    button.userInteractionEnabled = NO;
//    UIImageView *lockImgView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(50), FLEXIBLE_NUM(27), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
//    [lockImgView setImage:[UIImage imageNamed:@"锁"]];
//    lockImgView.center = CGPointMake(button.frame.size.width/2, button.frame.size.height/2);
//    [button addSubview:lockImgView];
//}

#pragma mark - 自定义
//刷新解锁情况
- (void)refreshLockList
{
    NSArray *sceneArray = @[@"school",@"world",@"playground",@"city",@"home"];
    for (NSInteger i = 0; i < self.conceptGamesArray.count; i++) {
        //        UIButton *lockBtn = (UIButton *)[self.view viewWithTag:BUTTON_TAG+i];
        NSArray *sceneGamesArray = self.conceptGamesArray[i];
        NSArray *newSceneGamesArray = [LBUserDefaults getNewSceneGanmesArrayWithSceneName:sceneArray[i]];
        BOOL isLock = !(sceneGamesArray.count > 0);
        if (i==0) {
            isLock = NO;
        }
        if (![LBUserDefaults getCurrentCalss]) {
            isLock = NO;
        }
//#warning -- test word 暂时设置为no
//        isLock = NO;
        [self addNumWithButtonTag:BUTTON_TAG+10+i Number:newSceneGamesArray.count isLock:isLock];
    }
}

#pragma mark - 通知方法
//- (void)getNextConceptData:(NSNotification *)notif
//{
////    self.shouldSaveNewGames = notif.object;
//    
//}


- (void)reloadConceptGamesData:(NSNotification  *)notif
{
    if (!notif.object) {//如果没有，则直接请求
        NSString *subjectId = [LBUserDefaults getCurrentCalss];
        NSLog(@"subjectId = %@",subjectId);
        if (subjectId) {
            NSDictionary *userDic = [LBUserDefaults getUserDic];
            [_homeModel getNextConceptWithUsername:userDic[@"username"] SubjectId:subjectId];
        }else{
//            [AppDelegate showHintLabelWithMessage:@"您还未选择科目"];
            [AppDelegate showHintLabelWithMessage:@"返回数据为空"];
            [self refreshLockList];
        }
    }else{//如果有参数，则直接刷新。
        [self nextConceptDataParse];
    }
}

#pragma mark - 数据处理
- (void)nextConceptDataParse
{
    NSArray *gamesArray = _homeModel.nextConceptData[@"data"];//所有已解锁游戏
    NSArray *sceneArray = @[@"school",@"world",@"playground",@"city",@"home"];
    
    NSArray *tempArray = @[@[],@[],@[],@[],@[]];
    self.conceptGamesArray = [NSMutableArray arrayWithArray:tempArray];
    for (int i = 0; i < gamesArray.count; i ++) {
        NSDictionary *sceneGameDic = gamesArray[i];//每个场景解锁的游戏
        NSString *sceneName = sceneGameDic[@"scene"];
        NSArray *sceneGameArray = gamesArray[i][@"games"];//每个场景解锁的游戏列表
        NSInteger index = [sceneArray indexOfObject:sceneName];
        [self.conceptGamesArray replaceObjectAtIndex:index withObject:sceneGameArray];
    }
    [self refreshLockList];
}

@end
