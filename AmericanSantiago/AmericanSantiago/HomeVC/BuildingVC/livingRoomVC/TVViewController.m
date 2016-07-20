//
//  TVViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "TVViewController.h"

@interface TVViewController ()

@property (nonatomic, strong)UIView                                   * view1;
@property (nonatomic, strong)UIView                                   * view2;
@property (nonatomic, strong)UIView                                   * view3;

@property (nonatomic, strong) UIButton                              * leftButton;
@property (nonatomic, strong) UIButton                              * rightButton;

@property (nonatomic, strong) NSString                               * mark;
@property (assign,nonatomic) NSInteger currentIndex;//当前显示页面


@end

@implementation TVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    
    
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mark = @"2";
    //房间
    _view1 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.hidden = YES;
        view.tag = 1;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [view addGestureRecognizer:tapGesture];
        [self.view addSubview:view];
        view;
    });
    
    UIImageView * backgroundView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView1 setImage:[UIImage imageNamed:@"卧室bg.png"]];
    [_view1 addSubview:backgroundView1];
    
    //厨房
    _view2 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.tag = 2;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [view addGestureRecognizer:tapGesture];
        [self.view addSubview:view];
        view;
    });
    UIImageView * backgroundView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView2 setImage:[UIImage imageNamed:@"家bg.png"]];
    [_view2 addSubview:backgroundView2];

    
    //客厅
    _view3 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.hidden = YES;
        view.tag = 3;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [view addGestureRecognizer:tapGesture];
        [self.view addSubview:view];
        view;
    });
    UIImageView * backgroundView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView3 setImage:[UIImage imageNamed:@"厨房bg.png"]];
    [_view3 addSubview:backgroundView3];
    
    
    _leftButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(20), FLEXIBLE_NUM(375), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        [button setImage:[UIImage imageNamed:@"left@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _rightButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCRREN_W - FLEXIBLE_NUM(80), FLEXIBLE_NUM(375), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        [button setImage:[UIImage imageNamed:@"right@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
}

#pragma mark -- buttonCLick
- (void) leftButtonClick: (UIButton *) sender
{
    NSLog(@"view.mark === %@",_mark);
    if ([_mark isEqualToString:@"1"]) {
        _leftButton.hidden = YES;
        
        return;
    }
    
    if ([_mark isEqualToString:@"2"]) {
        [UIView animateWithDuration:0 animations:^{
            _mark = @"1";
            _view2.alpha = 0;
            _view2.hidden = YES;
            
            _view1.hidden = NO;
            _view1.alpha = 1;
            _leftButton.hidden = YES;
            _rightButton.hidden = NO;
//            NSLog(@"view.mark === %@",_mark);
            
        }];
        return;
    }
    
    if ([_mark isEqualToString:@"3"]) {
        _mark = @"2";
        _view3.hidden = YES;
        _view2.hidden = NO;
        _rightButton.hidden = NO;
//        NSLog(@"view.mark === %@",_mark);
        return;
    }

    
    
}

- (void) rightButtonClick: (UIButton *) sender
{
    NSLog(@"view.mark === %@",_mark);
    
    if ([_mark isEqualToString:@"3"]) {
        _rightButton.hidden = YES;
        return;
    }
    
    if ([_mark isEqualToString:@"1"]) {
        [UIView animateWithDuration:0 animations:^{
            _mark = @"2";
            
            _view2.alpha = 1;
            _view2.hidden = NO;
        
        _view1.hidden = YES;
//        _view1.alpha = 0;
            _leftButton.hidden = NO;
//            NSLog(@"view.mark === %@",_mark);
        }];
        return;
    }
    
    if ([_mark isEqualToString:@"2"]) {
        _mark = @"3";
        
        _view3.hidden = NO;
//        _view3.alpha = 1;
        
        _view1.hidden = YES;
        _view2.hidden = YES;
        _leftButton.hidden = NO;
        _rightButton.hidden = YES;
//        NSLog(@"view.mark === %@",_mark);
        return;
    }
    
    
}
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)sender
{
    UIView *subSceneView = sender.view;
    [self pushGameVCWithSubSceneCode:subSceneView.tag];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    GameViewController * gameVC = [[GameViewController alloc] init];
////    UIView * view1 = (UIView *)[self.view viewWithTag:1];
//    
//    
//    for (int i = 0; i < 3; i ++) {
//        
////        switch (view1.tag) {
////            case 1:{
//////                if (_gamesArray.count > 0) {
//////                    gameVC.urlString = [_gamesArray[0] valueForKey:@"location"];
////////                    [self.translationController pushViewController:gameVC];
//////                }
////                
////            }
////                break;
////            case 2:{
////                if (_gamesArray.count > 1) {
////                    gameVC.urlString = [_gamesArray[1] valueForKey:@"location"];
////                    
////                }
////            }
////                break;
////            case 3:{
////                if (_gamesArray.count > 2) {
////                    gameVC.urlString = [_gamesArray[2] valueForKey:@"location"];
//////                    [self.translationController pushViewController:gameVC];
////                }
////            }
////                break;
////                
////            default:
////                break;
////        }
//        
//    }
//    [self.translationController pushViewController:gameVC];
////    GameViewController * gameVC = [[GameViewController alloc] init];
////    gameVC.urlString = [_gamesArray[0] valueForKey:@"location"];
////    [self.translationController pushViewController:gameVC];
//    
//}


#pragma mark - 自定义
- (void)pushGameVCWithSubSceneCode:(NSInteger)subSceneCode
{
    NSArray *subSceneGamesArray1 = [self getSubSceneGamesArrayWithSceneGamesArray:_gamesArray SubSceneCode:subSceneCode];
    if (!subSceneGamesArray1.count) {
        [AppDelegate showHintLabelWithMessage:@"该场景未解锁~"];
        return;
    }
    GameViewController * gameVC = [[GameViewController alloc] init];
    gameVC.subjectId = [LBUserDefaults getCurrentCalss];
    //先检测新解锁的是否有没玩儿过的。
    NSArray *newGameArray = [LBUserDefaults getNewSceneGanmesArrayWithSceneName:@"home"];
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSceneGamesArray:newGameArray SubSceneCode:subSceneCode];
    if (subSceneGamesArray.count > 0) {//还有新的没玩儿
        gameVC.gameDic = [subSceneGamesArray firstObject];
    }else{
        gameVC.gameDic = [subSceneGamesArray1 firstObject];
    }
    
    [self.translationController pushViewController:gameVC];
}

//获取子场景游戏，根据index
- (NSArray *)getSubSceneGamesArrayWithSceneGamesArray:(NSArray *)sceneGamesArray SubSceneCode:(NSInteger)subSceneCode
{
    NSString *sceneCode = [NSString stringWithFormat:@"5.%@",@(subSceneCode)];
    NSMutableArray *subSceneGamesArray = [NSMutableArray array];
    for (NSDictionary *subSceneGameDic in sceneGamesArray) {
        if ([subSceneGameDic[@"sceneCode"] isEqualToString:sceneCode]) {
            [subSceneGamesArray addObject:subSceneGameDic];
        }
    }
    return subSceneGamesArray;
}


@end
