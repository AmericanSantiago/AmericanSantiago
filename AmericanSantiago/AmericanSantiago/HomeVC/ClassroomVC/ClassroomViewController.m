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

@property (nonatomic ,strong) HomeModel                      * homeModel;

@property (nonatomic, strong) WKWebView                     * webView;
//@property (nonatomic, strong) UIWebView                     * webView;

@property (nonatomic, strong) GameModel                       * gameModel;

@end

@implementation ClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
    
    [_gameModel removeObserver:self forKeyPath:@"gameNewData"];
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"unlockedGamesData"]) {
        
        
        
    }
    
    if ([keyPath isEqualToString:@"gameNewData"]) {
        if ([[_gameModel.gameNewData valueForKey:@"errorCode"] integerValue] == 0) {
//            UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"已解锁新游戏" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//                
//            }];
//            [alertController addAction:sureAction];
//            [self presentViewController:alertController animated:YES completion:nil];
            
            [AppDelegate showHintLabelWithMessage:@"已解锁新游戏"];
            
        }
        

        
    }
    
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    
    _gameModel = [[GameModel alloc] init];
    [_gameModel addObserver:self forKeyPath:@"gameNewData" options:NSKeyValueObservingOptionNew context:nil];
    
    //    [_gameModel getGameData];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewGamesNotifi:) name:@"getNewGames" object:nil];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    

    _mathButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(320), FLEXIBLE_NUM(530), FLEXIBLE_NUM(110), FLEXIBLE_NUM(90))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(mathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    

//    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(300), FLEXIBLE_NUM(200), FLEXIBLE_NUM(100), FLEXIBLE_NUM(100))];
//    button.backgroundColor = [UIColor blueColor];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

    
    NSArray * picArray = [[NSArray alloc] initWithObjects:@"数学记录@3x",@"语文记录@3x",@"英语记录@3x",@"社会知识记录@3x",@"科学知识记录@3x",@"安全知识记录@3x", nil];
    for (int i = 0; i < 5; i ++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(370) + FLEXIBLE_NUM(80) * i, FLEXIBLE_NUM(150), FLEXIBLE_NUM(30), FLEXIBLE_NUM(200))];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
        button.tag = 200;
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
    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    
    GameViewController * gameVC = [[GameViewController alloc] init];
//    if (_classroomGamesArray) {
//        gameVC.urlString = [NSString stringWithFormat:@"%@",[_classroomGamesArray valueForKey:@"location"]];
//    }else{
        gameVC.urlString = @"Math/GE_STSO_0dot2/school_classroom_13_60_01/13_I.1_COMPARE";
//    }
    
    
//    gameVC.urlString = [NSString stringWithFormat:@"%@",[_classroomGamesArray[0] valueForKey:@"location"]];
//    gameVC.urlString = @"Math/GE_STSO_0dot2/school_classroom_13_60_01/13_I.1_COMPARE";
//    NSLog(@"location = %@",gameVC.urlString);
    [self.translationController pushViewController:gameVC];
    
}


- (void) buttonClick:(UIButton *) sender
{
    NSLog(@"button.tag = %ld",(long)sender.tag);

    
    
}

#pragma mark -- notifi
- (void) getNewGamesNotifi:(NSNotification *)notifi
{
    [_gameModel getNewGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] subjectId:@"Math"];//获取新解锁游戏
    
}


@end
