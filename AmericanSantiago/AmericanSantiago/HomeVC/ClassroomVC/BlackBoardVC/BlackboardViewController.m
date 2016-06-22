//
//  BlackboardViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "BlackboardViewController.h"

@interface BlackboardViewController ()

@property (nonatomic, strong) UIButton                              * backBuutton;

@end

@implementation BlackboardViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    
    
    _backBuutton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(25), FLEXIBLE_NUM(120), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
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
