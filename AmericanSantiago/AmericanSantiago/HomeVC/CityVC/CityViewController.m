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
    
    
    
}

#pragma mark -- buttonClick
- (void) libraryButtonClick: (UIButton *) sender
{
    LibraryViewController * libraryVC = [[LibraryViewController alloc] init];

    if (_cityGameArray.count > 0) {
        libraryVC.gamesArray = _cityGameArray[0];
        [self.translationController pushViewController:libraryVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
}

- (void) cinemaButtonClick: (UIButton *) sender
{
    CinemaViewController * cinemaVC = [[CinemaViewController alloc] init];
    if (_cityGameArray.count > 1) {
        cinemaVC.gamesArray = _cityGameArray[1];
        [self.translationController pushViewController:cinemaVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
    
}

- (void) petsButtonClick: (UIButton *) sender
{
    PetsViewController * petsVC = [[PetsViewController alloc] init];
    if (_cityGameArray.count > 2) {
        petsVC.gamesArray = _cityGameArray[2];
        [self.translationController pushViewController:petsVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
    
    
    
}

- (void) supermarketButtonClick: (UIButton *) sender
{
    SupermarketViewController * supermarketVC = [[SupermarketViewController alloc] init];
    if (_cityGameArray.count > 3) {
        supermarketVC.gamesArray = _cityGameArray[3];
        [self.translationController pushViewController:supermarketVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
}

- (void) storeButtonClick: (UIButton *) sender
{
    StoreViewController * storeVC = [[StoreViewController alloc] init];
    if (_cityGameArray.count > 4) {
        storeVC.gamesArray = _cityGameArray[4];
        [self.translationController pushViewController:storeVC];
    }else{
        [AppDelegate showHintLabelWithMessage:@"此游戏未解锁"];
    }
}



- (void) backButtonCLick: (UIButton *)sender
{
    [self.translationController popViewController];
    
    
}

@end
