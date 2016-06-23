//
//  TVViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/23.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "TVViewController.h"

@interface TVViewController ()

@property (nonatomic, strong)UIView                                   * view1;
@property (nonatomic, strong)UIView                                   * view2;
@property (nonatomic, strong)UIView                                   * view3;

@property (nonatomic, strong) UIButton                              * leftButton;
@property (nonatomic, strong) UIButton                              * rightButton;

@property (nonatomic, strong) NSString                               * mark;

@end

@implementation TVViewController

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
    
    _mark = @"2";
    //房间
    _view1 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.hidden = YES;
        view.tag = 1;
        [self.view addSubview:view];
        view;
    });
    
    UIImageView * backgroundView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView1 setImage:[UIImage imageNamed:@"卧室bg.png"]];
    [_view1 addSubview:backgroundView1];
    
    //厨房
    _view2 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.tag = 2;
        [self.view addSubview:view];
        view;
    });
    UIImageView * backgroundView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView2 setImage:[UIImage imageNamed:@"家bg.png"]];
    [_view2 addSubview:backgroundView2];

    
    //客厅
    _view3 = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
        view.hidden = YES;
        view.tag = 3;
        [self.view addSubview:view];
        view;
    });
    UIImageView * backgroundView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView3 setImage:[UIImage imageNamed:@"厨房bg.jpg"]];
    [_view3 addSubview:backgroundView3];
    
    
    _leftButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(20), FLEXIBLE_NUM(375), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        [button setImage:[UIImage imageNamed:@"left@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _rightButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCRREN_W - FLEXIBLE_NUM(80), FLEXIBLE_NUM(375), FLEXIBLE_NUM(60), FLEXIBLE_NUM(60))];
        [button setImage:[UIImage imageNamed:@"right@3x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
}

#pragma mark -- buttonCLick
- (void) leftButtonClick: (UIButton *) sender
{
    
    [UIView animateWithDuration:1 animations:^{
         _mark = @"1";
        
        _view2.alpha = 0;
        _view2.hidden = YES;
        
        _view1.hidden = NO;
        _view1.alpha = 1;
        
    }];
    
    if ([_mark isEqualToString:@"1"]) {
        _leftButton.hidden = YES;
    }
    
    
}

- (void) rightButtonClick: (UIButton *) sender
{
//    [UIView animateWithDuration:1 animations:^{
//        _mark = @"3";
//        
//        _view2.alpha = 0;
//        _view2.hidden = YES;
//        
//        _view3.hidden = NO;
//        _view3.alpha = 1;
//        
//    }];
    if ([_mark isEqualToString:@"3"]) {
        _rightButton.hidden = YES;
    }
    
    if ([_mark isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.5 animations:^{
            _mark = @"2";
            
            _view2.alpha = 1;
            _view2.hidden = NO;
            
            _view3.hidden = YES;
            _view3.alpha = 0;
        
        _view1.hidden = YES;
        _view1.alpha = 0;
        }];
    }
    
    
}


@end
