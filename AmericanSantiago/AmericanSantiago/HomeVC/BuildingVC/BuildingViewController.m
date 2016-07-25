//
//  BuildingViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "BuildingViewController.h"
#import "HomeModel.h"
#import "TVViewController.h"

@interface BuildingViewController ()

@property (nonatomic, strong) UIButton                              * enterButton;

@property (nonatomic, strong) HomeModel                      * homeModel;


@end

@implementation BuildingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    
    [_homeModel getGetUnlockedGamesWithUsername:@"mwk" SubjectId:@"1" SceneType:@"buidling"];
    
}

- (void)initializeUserInterface
{
    NSLog(@"+++++++bulidingGameArray = %@",_bulidingGamesArray);
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"小区bg2.png"]];
    [self.view addSubview:backgroundView];
    
    _enterButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(470), FLEXIBLE_NUM(342), FLEXIBLE_NUM(80), FLEXIBLE_NUM(80))];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"进入@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void) enterButtonClick: (UIButton *) sender
{
    TVViewController * TVVC = [[TVViewController alloc] init];
    TVVC.gamesArray = _bulidingGamesArray;
    [self.translationController pushViewController:TVVC];
    
}



@end
