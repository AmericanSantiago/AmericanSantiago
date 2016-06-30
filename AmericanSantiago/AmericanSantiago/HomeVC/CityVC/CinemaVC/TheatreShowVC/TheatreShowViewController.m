//
//  TheatreShowViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/29.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "TheatreShowViewController.h"

@interface TheatreShowViewController ()

@end

@implementation TheatreShowViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"电影院屏幕bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GameViewController * gameVC = [[GameViewController alloc] init];
    gameVC.urlString = [_gamesArray valueForKey:@"location"];
    [self.translationController pushViewController:gameVC];
    
}

@end
