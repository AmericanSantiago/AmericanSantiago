//
//  WorldViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "WorldViewController.h"

@interface WorldViewController ()

@property (nonatomic, strong) UIButton                              * backBuutton;

@end

@implementation WorldViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"二级界面 World_North1.png"]];
    [self.view addSubview:backgroundView];
    
    
    _backBuutton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(35), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
                button.backgroundColor = [UIColor clearColor];
//        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
}

- (void) backButtonCLick: (UIButton *)sender
{
    [self.translationController popViewController];
    
    
}

@end
