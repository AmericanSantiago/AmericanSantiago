//
//  ClassroomViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ClassroomViewController.h"
#import "BlackboardViewController.h"

@interface ClassroomViewController ()

@property (nonatomic, strong) UIButton                              * backBuutton;
@property (nonatomic, strong) UIButton                              * doorButton;


@end

@implementation ClassroomViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"主界面1.png"]];
    [self.view addSubview:backgroundView];
                                                                                 
    
    _backBuutton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(35), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
//        button.backgroundColor = [UIColor yellowColor];
        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _doorButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(560), FLEXIBLE_NUM(340), FLEXIBLE_NUM(80), FLEXIBLE_NUM(170))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(doorButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    
}

#pragma mark -- buttonCLick
- (void) doorButtonCLick: (UIButton *) sender
{
    BlackboardViewController * blackgroundVC = [[BlackboardViewController alloc] init];
    [self.translationController pushViewController:blackgroundVC];
    
}


- (void) backButtonCLick: (UIButton *)sender
{
    [self.translationController popViewController];
    
    
}


@end