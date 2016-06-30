//
//  CinemaViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/22.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "CinemaViewController.h"
#import "TheatreShowViewController.h"


@interface CinemaViewController ()

@property (nonatomic, strong) UIButton                      * enterButton;

@end

@implementation CinemaViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"电影院2bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    
    _enterButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(613), FLEXIBLE_NUM(382), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        button.backgroundColor = [UIColor clearColor];
        [button setBackgroundImage:[UIImage imageNamed:@"进入@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
    
    
}

#pragma mark -- buttonClick
- (void) enterButtonClick:(UIButton *)sender
{
    
    TheatreShowViewController * theatreShowVC = [[TheatreShowViewController alloc] init];
    [self.translationController pushViewController:theatreShowVC];
    
    
}




@end
