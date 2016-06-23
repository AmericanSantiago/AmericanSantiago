//
//  ClassroomViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ClassroomViewController.h"
#import "HomeModel.h"


@interface ClassroomViewController ()

@property (nonatomic, strong) UIButton                              * mathButton;

@property (nonatomic ,strong) HomeModel                      * homeModel;

@end

@implementation ClassroomViewController

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
    
    [_homeModel getGetUnlockedGamesWithUsername:@"mwk" SubjectId:@"1" SceneType:@"classroom"];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    

//    _mathButton = ({
//        
//        
//    });
    
    
}

#pragma mark -- buttonCLick



@end
