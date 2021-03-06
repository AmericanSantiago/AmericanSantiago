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
@property (strong, nonatomic) NSString *currentSubjectId;   //当前选择的课程id;


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
        button.tag = 200 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
    
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
}
- (void) englishButtonClick: (UIButton *) sender
{
    self.currentSubjectId = @"English";
    [self getNextConceptDataWithSubjectId:@"English"];
}
- (void) earthButtonClick: (UIButton *) sender
{
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
    
    [self creatView];
    
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
        NSDictionary *teachGameDic = nil;
        for (NSDictionary *conceptGameDic in conceptGamesArray) {
            NSString *sceneName = conceptGameDic[@"scene"];
            NSArray *sceneGamesArray = conceptGameDic[@"games"];
            [LBUserDefaults addSaveNewSceneGamesArray:sceneGamesArray sceneName:sceneName];
            if ([sceneName isEqualToString:@"school"]) {
                teachGameDic = [sceneGamesArray firstObject];
            }
        }
        
        if (teachGameDic) {
            GameViewController *gameVC = [[GameViewController alloc]init];
            gameVC.gameDic = teachGameDic;
            gameVC.subjectId = self.currentSubjectId;
            [self.translationController pushViewController:gameVC];
        }else{
            GameViewController * gameVC = [[GameViewController alloc] init];
            gameVC.urlString = @"Math/ME_ME_0dot2/school_classroom_13_19_04/13_I.1_COMPARE";
            gameVC.subjectId = @"Math";
            [self.translationController pushViewController:gameVC];
        }
    }
//    /Users/Mervin/Desktop/合源美智（github）/AmericanSantiago/AmericanSantiago/AmericanSantiago/Htmls/Math/ME_0dot2/school_classroom_13_19_04/13_I.1_COMPARE
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadConceptGamesData" object:nil];
    
}

//添加复习进度界面
- (void) creatView
{
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, BASESCRREN_H)];
    view1.backgroundColor = [UIColor clearColor];
    view1.tag = 10003;
    [self.view addSubview:view1];
    
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.userInteractionEnabled = NO;
    effectView.tag = 10002;
    //添加到要有毛玻璃特效的控件中
    effectView.frame = self.view.bounds;
        effectView.alpha = 0;
    [view1 addSubview:effectView];
    
    UIButton * dissmissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, BASESCRREN_H)];
//    dissmissButton.alpha = 0;
    [dissmissButton addTarget:self action:@selector(dissmissButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    dissmissButton.backgroundColor = [UIColor clearColor];
    dissmissButton.tag = 10001;
    [view1 addSubview:dissmissButton];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(130), FLEXIBLE_NUM(100), FLEXIBLE_NUM(760), FLEXIBLE_NUM(550))];
    view2.backgroundColor = [UIColor clearColor];
    view2.tag = 10004;
    [self.view addSubview:view2];
    
    UIImageView * reviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(760), FLEXIBLE_NUM(550))];
    //        reviewImageView.center = CGPointMake(MAINSCRREN_W/2, MAINSCRREN_H/2);
    [reviewImageView setImage:[UIImage imageNamed:@"复习界面选择数学"]];
//    reviewImageView.alpha = 0;
//    reviewImageView.layer.cornerRadius = FLEXIBLE_NUM(10);
//    reviewImageView.backgroundColor = [UIColor ]
    reviewImageView.tag = 10000;
    reviewImageView.userInteractionEnabled = NO;
    [view2 addSubview:reviewImageView];

    
    dissmissButton.alpha = 0.5;
    effectView.alpha = 0.9;
    [UIView animateWithDuration:0.3 animations:^{
        reviewImageView.alpha = 1;
    }];
    

}

- (void)dissmissButtonClick: (UIButton *) sender{
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:10000];
    UIButton * button = (UIButton *)[self.view viewWithTag:10001];
    UIVisualEffectView * effectView = (UIVisualEffectView *)[self.view viewWithTag:10002];
    UIView * view1 = (UIView *)[self.view viewWithTag:10003];
    UIView * view2 = (UIView *)[self.view viewWithTag:10004];
    
    [imageView removeFromSuperview];
    [button removeFromSuperview];
    [effectView removeFromSuperview];
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
}


@end
