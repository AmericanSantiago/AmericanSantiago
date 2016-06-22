//
//  LibraryViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/22.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()

@end

@implementation LibraryViewController

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
    [backgroundView setImage:[UIImage imageNamed:@"图书馆bg.png"]];
    //    backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backgroundView];
    
    
    
    
    
    
    
    
}


@end
