//
//  CityViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "CityViewController.h"
#import "CinemaViewController.h"
#import "LibraryViewController.h"
#import "PetsViewController.h"
#import "StoreViewController.h"
#import "SupermarketViewController.h"

@interface CityViewController ()

@property (nonatomic, strong) UIButton                              * backBuutton;

@property (nonatomic, strong) UIButton                              * supermarketButton;
@property (nonatomic ,strong) UIButton                              * cinemaButton;
@property (nonatomic, strong) UIButton                              * petsButton;                   //宠物店
@property (nonatomic, strong) UIButton                              * storeButton;
@property (nonatomic, strong) UIButton                              * libraryButton;


@end

@implementation CityViewController

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
    NSLog(@"++++++++_cityGamesArray = %@",_cityGameArray);
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"城市bg.png"]];
//    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    _libraryButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(0), FLEXIBLE_NUM(220), FLEXIBLE_NUM(150), FLEXIBLE_NUM(270))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(libraryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _cinemaButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(320), FLEXIBLE_NUM(320), FLEXIBLE_NUM(170), FLEXIBLE_NUM(200))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(cinemaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _petsButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(515), FLEXIBLE_NUM(300), FLEXIBLE_NUM(170), FLEXIBLE_NUM(250))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(petsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _supermarketButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(700), FLEXIBLE_NUM(300), FLEXIBLE_NUM(170), FLEXIBLE_NUM(250))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(supermarketButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _storeButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(900), FLEXIBLE_NUM(100), FLEXIBLE_NUM(170), FLEXIBLE_NUM(450))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(storeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    _backBuutton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(35), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(backButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    UIButton * reviewButton = [[UIButton alloc] initWithFrame:CGRectMake(BASESCRREN_W - FLEXIBLE_NUM(70), FLEXIBLE_NUM(600), FLEXIBLE_NUM(70), FLEXIBLE_NUM(44))];
    [reviewButton setBackgroundImage:[UIImage imageNamed:@"复习@3x"] forState:UIControlStateNormal];
    [reviewButton addTarget:self action:@selector(reviewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reviewButton];
    
    
    
    
}

#pragma mark -- buttonClick
- (void) reviewButtonClick: (UIButton *) sender{
    ReviewViewController * reviewVC = [[ReviewViewController alloc] init];
    [self.translationController pushViewController:reviewVC];
}

- (void) libraryButtonClick: (UIButton *) sender
{
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSubSceneCode:1];
    if (!subSceneGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前场景未解锁~"];
    }else{
        LibraryViewController * libraryVC = [[LibraryViewController alloc] init];
        libraryVC.gamesArray = subSceneGamesArray;
        [self.translationController pushViewController:libraryVC];
    }
//    if (_cityGameArray.count > 0) {
//        
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }
}

- (void) cinemaButtonClick: (UIButton *) sender
{
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSubSceneCode:2];
    if (!subSceneGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前场景未解锁~"];
    }else{
        CinemaViewController * cinemaVC = [[CinemaViewController alloc] init];
        cinemaVC.gamesArray = subSceneGamesArray;
        [self.translationController pushViewController:cinemaVC];
    }
}

- (void) petsButtonClick: (UIButton *) sender
{
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSubSceneCode:3];
    if (!subSceneGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前场景未解锁~"];
    }else{
        PetsViewController * petsVC = [[PetsViewController alloc] init];
        petsVC.gamesArray = subSceneGamesArray;
        [self.translationController pushViewController:petsVC];
    }
    
//    PetsViewController * petsVC = [[PetsViewController alloc] init];
//    if (_cityGameArray.count > 2) {
//        petsVC.gamesArray = _cityGameArray[2];
//        [self.translationController pushViewController:petsVC];
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }
}

- (void) supermarketButtonClick: (UIButton *) sender
{
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSubSceneCode:4];
    if (!subSceneGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前场景未解锁~"];
    }else{
        SupermarketViewController * supermarketVC = [[SupermarketViewController alloc] init];
        supermarketVC.gamesArray = subSceneGamesArray;
        [self.translationController pushViewController:supermarketVC];
    }
//    SupermarketViewController * supermarketVC = [[SupermarketViewController alloc] init];
//    if (_cityGameArray.count > 3) {
//        supermarketVC.gamesArray = _cityGameArray[3];
//        [self.translationController pushViewController:supermarketVC];
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }
}

- (void) storeButtonClick: (UIButton *) sender
{
    NSArray *subSceneGamesArray = [self getSubSceneGamesArrayWithSubSceneCode:5];
    if (!subSceneGamesArray.count) {
        [AppDelegate showHintLabelWithMessage:@"当前场景未解锁~"];
    }else{
        StoreViewController * storeVC = [[StoreViewController alloc] init];
        storeVC.gamesArray = subSceneGamesArray;
        [self.translationController pushViewController:storeVC];
    }
    
//    StoreViewController * storeVC = [[StoreViewController alloc] init];
//    if (_cityGameArray.count > 4) {
//        storeVC.gamesArray = _cityGameArray[4];
//        [self.translationController pushViewController:storeVC];
//    }else{
//        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
//    }
}



- (void) backButtonCLick: (UIButton *)sender
{
    [self.translationController popViewController];
    
}

#pragma mark - 自定义
//获取子场景游戏，根据index
- (NSArray *)getSubSceneGamesArrayWithSubSceneCode:(NSInteger)subSceneCode
{
    NSString *sceneCode = [NSString stringWithFormat:@"4.%@",@(subSceneCode)];
    NSMutableArray *subSceneGamesArray = [NSMutableArray array];
    for (NSDictionary *subSceneGameDic in _cityGameArray) {
        if ([subSceneGameDic[@"sceneCode"] isEqualToString:sceneCode]) {
            [subSceneGamesArray addObject:subSceneGameDic];
        }
    }
    return subSceneGamesArray;
}

@end
