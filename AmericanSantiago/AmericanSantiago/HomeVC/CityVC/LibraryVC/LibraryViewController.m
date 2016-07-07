//
//  LibraryViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/22.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()

@end

@implementation LibraryViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"图书馆bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GameViewController * gameVC = [[GameViewController alloc] init];
    gameVC.subjectId = [LBUserDefaults getCurrentCalss];
    //先检测新解锁的是否有没玩儿过的。
    NSArray *newGameArray = [LBUserDefaults getNewSceneGanmesArrayWithSceneName:@"city"];
    NSString *sceneCode = [NSString stringWithFormat:@"4.%@",@(1)];
    NSMutableArray *subSceneGamesArray = [NSMutableArray array];
    for (NSDictionary *subSceneGameDic in newGameArray) {
        if ([subSceneGameDic[@"sceneCode"] isEqualToString:sceneCode]) {
            [subSceneGamesArray addObject:subSceneGameDic];
        }
    }
    if (subSceneGamesArray.count > 0) {//还有新的没玩儿
        gameVC.gameDic = [subSceneGamesArray firstObject];
    }else{
        gameVC.gameDic = [_gamesArray firstObject];
    }
    
    [self.translationController pushViewController:gameVC];
    
}



@end
