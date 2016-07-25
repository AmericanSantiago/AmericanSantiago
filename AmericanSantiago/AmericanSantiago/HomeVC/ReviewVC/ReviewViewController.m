//
//  ReviewViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/7/26.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    
    
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    
    
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"复习界面选择2bg.png"]];
    [self.view addSubview:backgroundView];
    
    
    
    
}

@end
