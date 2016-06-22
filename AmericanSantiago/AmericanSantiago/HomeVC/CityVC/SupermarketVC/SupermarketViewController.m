//
//  SupermarketViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/22.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "SupermarketViewController.h"

@interface SupermarketViewController ()

@end

@implementation SupermarketViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"超市bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    
    
    
    
    
    
    
}

@end
