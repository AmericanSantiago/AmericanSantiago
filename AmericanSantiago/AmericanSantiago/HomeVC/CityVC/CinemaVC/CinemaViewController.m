//
//  CinemaViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/22.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "CinemaViewController.h"

@interface CinemaViewController ()

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
    
    
    
    
    
    
    
    
}

@end