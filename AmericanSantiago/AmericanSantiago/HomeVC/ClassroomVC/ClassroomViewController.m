//
//  ClassroomViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ClassroomViewController.h"
#import "HomeModel.h"
#import <WebKit/WebKit.h>

@interface ClassroomViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton                              * mathButton;
@property (nonatomic, strong) UIButton                              * englishButton;
@property (nonatomic, strong) UIButton                              * earthButton;
@property (nonatomic, strong) UIButton                              * microscopeButton;
@property (nonatomic, strong) UIButton                              * chineseButton;
@property (nonatomic, strong) UIButton                              * drawingButton;            //画板


@property (nonatomic ,strong) HomeModel                      * homeModel;

@property (nonatomic, strong) WKWebView                     * webView;
//@property (nonatomic, strong) UIWebView                     * webView;

@property (nonatomic, strong) GameModel                       * gameModel;
@property (strong, nonatomic) NSString *currentSubjectId;//当前选择的课程id;


@end

@implementation ClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"nextConceptData"];
//    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
//    
//    [_gameModel removeObserver:self forKeyPath:@"gameNewData"];
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"nextConceptData"]) {
        [self nextConceptDataParse];
    }
//    if ([keyPath isEqualToString:@"unlockedGamesData"]) {
//        
//        
//        
//    }
//    
//    if ([keyPath isEqualToString:@"gameNewData"]) {
//        if ([[_gameModel.gameNewData valueForKey:@"errorCode"] integerValue] == 0) {
////            UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"已解锁新游戏" preferredStyle:UIAlertControllerStyleAlert];
////            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////                
////                
////            }];
////            [alertController addAction:sureAction];
////            [self presentViewController:alertController animated:YES completion:nil];
//            
////            [AppDelegate showHintLabelWithMessage:@"已解锁新游戏"];
//            
//        }
//    }
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"nextConceptData" options:NSKeyValueObservingOptionNew context:nil];
//    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
//    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    
//    _gameModel = [[GameModel alloc] init];
//    [_gameModel addObserver:self forKeyPath:@"gameNewData" options:NSKeyValueObservingOptionNew context:nil];
    
    //    [_gameModel getGameData];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewGamesNotifi:) name:@"getNewGames" object:nil];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    
    
    _englishButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(530), FLEXIBLE_NUM(110), FLEXIBLE_NUM(80))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(englishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _mathButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(320), FLEXIBLE_NUM(530), FLEXIBLE_NUM(110), FLEXIBLE_NUM(90))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(mathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _earthButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(430), FLEXIBLE_NUM(430), FLEXIBLE_NUM(100), FLEXIBLE_NUM(130))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(earthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _microscopeButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(580), FLEXIBLE_NUM(480), FLEXIBLE_NUM(90), FLEXIBLE_NUM(120))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(microscopeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _chineseButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(800), FLEXIBLE_NUM(510), FLEXIBLE_NUM(110), FLEXIBLE_NUM(80))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(chineseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _drawingButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(920), FLEXIBLE_NUM(480), FLEXIBLE_NUM(110), FLEXIBLE_NUM(80))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(drawingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });

    
    NSArray * picArray = [[NSArray alloc] initWithObjects:@"数学记录@3x",@"语文记录@3x",@"英语记录@3x",@"社会知识记录@3x",@"科学知识记录@3x",@"安全知识记录@3x", nil];
    for (int i = 0; i < 5; i ++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(370) + FLEXIBLE_NUM(80) * i, FLEXIBLE_NUM(150), FLEXIBLE_NUM(30), FLEXIBLE_NUM(200))];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
        button.tag = 200;
        if (i>_classroomGamesArray.count) {
            button.alpha = 0.1;
        }else{
            button.alpha = 0;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
    
    //测试按钮
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(300), FLEXIBLE_NUM(150), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(textButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    
}

- (void) textButtonClick: (UIButton *)sender
{
    NSLog(@"textButton!");
    
//    NSDictionary *userDic = [LBUserDefaults getUserDic];
//    [_homeModel getNextConceptWithUsername:userDic[@"username"] SubjectId:@"Math"];

//    NSDictionary *userDic = [LBUserDefaults getUserDic];
    NSString * urlString = @"/ConceptFinish";
    NSDictionary* bodyObject = @{@"username":@"123",
                                 @"subjectId":@"Math"};
    
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
//        if (complete) {
//            complete(resultDic,errorString);
//        }
        if (!errorString) {
//            self.conceptFinishData = resultDic;
            NSLog(@"++++++++++resultDic = %@",resultDic);
            //刷新首页的数字
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadConceptGamesData" object:@(1)];
        }
    }];

    
    
    
    
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
}

#pragma mark -- buttonCLick
- (void) mathButtonClick: (UIButton *) sender
{
    self.currentSubjectId = @"Math";
    [self getNextConceptDataWithSubjectId:@"Math"];
    
////    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
////    
//    GameViewController * gameVC = [[GameViewController alloc] init];
////    if (_classroomGamesArray) {
////        gameVC.urlString = [NSString stringWithFormat:@"%@",[_classroomGamesArray valueForKey:@"location"]];
////    }else{
//        gameVC.urlString = @"Math/GE_STSO_0dot2/school_classroom_13_60_01/13_I.1_COMPARE";
//    gameVC.subjectId = @"Math";
////    }
//
////    gameVC.urlString = [NSString stringWithFormat:@"%@",[_classroomGamesArray[0] valueForKey:@"location"]];
////    gameVC.urlString = @"Math/GE_STSO_0dot2/school_classroom_13_60_01/13_I.1_COMPARE";
////    NSLog(@"location = %@",gameVC.urlString);
//    [self.translationController pushViewController:gameVC];    
}
- (void) englishButtonClick: (UIButton *) sender
{
    self.currentSubjectId = @"English";
    [self getNextConceptDataWithSubjectId:@"English"];
}
- (void) earthButtonClick: (UIButton *) sender
{
//    GameViewController * gameVC = [[GameViewController alloc] init];
//    if (_classroomGamesArray.count > 2) {
//        gameVC.urlString = [_classroomGamesArray[2] valueForKey:@"location"];
//        [self.translationController pushViewController:gameVC];
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }

    self.currentSubjectId = @"Earth";
    [self getNextConceptDataWithSubjectId:@"Earth"];
    
}
- (void) microscopeButtonClick: (UIButton *) sender
{
    GameViewController * gameVC = [[GameViewController alloc] init];
    if (_classroomGamesArray.count > 3) {
        gameVC.urlString = [_classroomGamesArray[3] valueForKey:@"location"];
        [self.translationController pushViewController:gameVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
    
}
- (void) chineseButtonClick: (UIButton *) sender
{
    GameViewController * gameVC = [[GameViewController alloc] init];
    if (_classroomGamesArray.count > 4) {
        gameVC.urlString = [_classroomGamesArray[4] valueForKey:@"location"];
        [self.translationController pushViewController:gameVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
}
- (void) drawingButtonClick: (UIButton *) sender
{
    GameViewController * gameVC = [[GameViewController alloc] init];
    if (_classroomGamesArray.count > 5) {
        gameVC.urlString = [_classroomGamesArray[5] valueForKey:@"location"];
        [self.translationController pushViewController:gameVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
}




- (void) buttonClick:(UIButton *) sender
{
    NSLog(@"button.tag = %ld",(long)sender.tag);
}

#pragma mark - 获取一个教学点游戏
- (void)getNextConceptDataWithSubjectId:(NSString *)subjectId
{
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    [_homeModel getNextConceptWithUsername:userDic[@"username"] SubjectId:subjectId];
}

#pragma mark -- notifi
- (void) getNewGamesNotifi:(NSNotification *)notifi
{
    [_gameModel getNewGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] subjectId:@"Math"];//获取新解锁游戏
    
}


#pragma mark - 数据处理
- (void)nextConceptDataParse
{
    
    if ([_homeModel.nextConceptData[@"errorCode"] integerValue]) {
        [AppDelegate showHintLabelWithMessage:@"获取教学知识点游戏失败~"];
        return;
    }
    NSArray *conceptGamesArray = _homeModel.nextConceptData[@"data"];
    if (!conceptGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前教学点已完成~"];
        [LBUserDefaults saveCurrentClass:nil];//重置当前课程
    }else{
        //保存当前选择课程
        [LBUserDefaults saveCurrentClass:self.currentSubjectId];
        //保存当前教学知识点游戏列表
        [LBUserDefaults saveCurrentConceptGamesArray:conceptGamesArray];
        //进入当前知识点的教学游戏
        for (NSDictionary *conceptGameDic in conceptGamesArray) {
            NSString *sceneName = conceptGameDic[@"scene"];
            NSArray *sceneGamesArray = conceptGameDic[@"games"];
            [LBUserDefaults addSaveNewSceneGamesArray:sceneGamesArray sceneName:sceneName];
            if ([sceneName isEqualToString:@"school"]) {
                GameViewController *gameVC = [[GameViewController alloc]init];
                gameVC.gameDic = [sceneGamesArray firstObject];
                gameVC.subjectId = self.currentSubjectId;
                [self.translationController pushViewController:gameVC];
                break;
            }else{
                    GameViewController * gameVC = [[GameViewController alloc] init];
                    gameVC.urlString = @"Math/GE_STSO_0dot2/school_classroom_13_60_01/13_I.1_COMPARE";
                    gameVC.subjectId = @"Math";
                    [self.translationController pushViewController:gameVC];
            }
            
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadConceptGamesData" object:nil];
    
}

@end
