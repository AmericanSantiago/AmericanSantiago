//
//  PlaygroundViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "PlaygroundViewController.h"

@interface PlaygroundViewController ()

@property (nonatomic, strong) UIButton                              * backBuutton;

@end

@implementation PlaygroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"游乐场bg.png"]];
    [self.view addSubview:backgroundView];
    
    
    _backBuutton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(35), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
        //        button.backgroundColor = [UIColor yellowColor];
        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
}

- (void) backButtonCLick: (UIButton *)sender
{
    [self.translationController popViewController];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    GameViewController * gameVC = [[GameViewController alloc] init];
//    if (_playgroundGamesArray.count > 0) {
//        gameVC.urlString = [_playgroundGamesArray[0] valueForKey:@"location"];
//        [self.translationController pushViewController:gameVC];
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }
    
    for (NSInteger i = 0; i < 4; i++) {
        NSArray *newGameArray = [LBUserDefaults getNewSceneGanmesArrayWithSceneName:@"home"];
        NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSceneGamesArray:newGameArray SubSceneCode:i+1];
        if (subSceneGamesArray.count) {
            GameViewController * gameVC = [[GameViewController alloc] init];
            gameVC.subjectId = [LBUserDefaults getCurrentCalss];
            gameVC.gameDic = [subSceneGamesArray firstObject];
            [self.translationController pushViewController:gameVC];
            return;
        }
    }
    for (NSInteger i = 0; i < 4; i++) {
        NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSceneGamesArray:_playgroundGamesArray SubSceneCode:i+1];
        if (subSceneGamesArray.count) {
            GameViewController * gameVC = [[GameViewController alloc] init];
            gameVC.subjectId = [LBUserDefaults getCurrentCalss];
            gameVC.gameDic = [subSceneGamesArray firstObject];
            [self.translationController pushViewController:gameVC];
            return;
        }
    }
    [AppDelegate showHintLabelWithMessage:@"没有游戏哦，你怎么进来的，我怀疑我出了bug~"];
    
}


#pragma mark - 自定义
//- (void)pushGameVCWithSubSceneCode:(NSInteger)subSceneCode
//{
//    NSArray *subSceneGamesArray1 = [self getSubSceneGamesArrayWithSceneGamesArray:_playgroundGamesArray SubSceneCode:subSceneCode];
//    if (!subSceneGamesArray1.count) {
//        [AppDelegate showHintLabelWithMessage:@"该场景未解锁~"];
//        return;
//    }
//    GameViewController * gameVC = [[GameViewController alloc] init];
//    gameVC.subjectId = [LBUserDefaults getCurrentCalss];
//    //先检测新解锁的是否有没玩儿过的。
//    NSArray *newGameArray = [LBUserDefaults getNewSceneGanmesArrayWithSceneName:@"home"];
//    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSceneGamesArray:newGameArray SubSceneCode:subSceneCode];
//    if (subSceneGamesArray.count > 0) {//还有新的没玩儿
//        gameVC.gameDic = [subSceneGamesArray firstObject];
//    }else{
//        gameVC.gameDic = [subSceneGamesArray1 firstObject];
//    }
//    
//    [self.translationController pushViewController:gameVC];
//}

//获取子场景游戏，根据index
- (NSArray *)getSubSceneGamesArrayWithSceneGamesArray:(NSArray *)sceneGamesArray SubSceneCode:(NSInteger)subSceneCode
{
    NSString *sceneCode = [NSString stringWithFormat:@"3.%@",@(subSceneCode)];
    NSMutableArray *subSceneGamesArray = [NSMutableArray array];
    for (NSDictionary *subSceneGameDic in sceneGamesArray) {
        if ([subSceneGameDic[@"sceneCode"] isEqualToString:sceneCode]) {
            [subSceneGamesArray addObject:subSceneGameDic];
        }
    }
    return subSceneGamesArray;
}


@end
