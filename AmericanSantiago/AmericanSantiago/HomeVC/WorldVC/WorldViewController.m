//
//  WorldViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "WorldViewController.h"

@interface WorldViewController ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *northBgView;
@property (strong, nonatomic) UIImageView *southBgView;
//@property (nonatomic, strong) UIButton                              * backBuutton;
@property (strong, nonatomic) UIButton *lastBtn;
@property (strong,nonatomic) NSArray *northImageArray;
@property (strong,nonatomic) NSArray *southImageArray;

//@property (strong,nonatomic) NSMutableArray *views;
@property (assign,nonatomic) NSInteger currentIndex;//当前显示页面

@end

@implementation WorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterface];
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
    NSMutableArray *northImageArray = [NSMutableArray array];
    NSMutableArray *sourthImageArray = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        [northImageArray addObject:[NSString stringWithFormat:@"North%@.jpg",@(i)]];
        [sourthImageArray addObject:[NSString stringWithFormat:@"South%@.jpg",@(i)]];
    }
    self.northImageArray = [NSArray arrayWithArray:northImageArray];
    self.southImageArray = [NSArray arrayWithArray:sourthImageArray];
    
    self.currentIndex = 4;
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    [self.view addSubview:self.bgView];
    
    
}
#pragma mark - 各种Getter
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:BASESCRREN_B];
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView setHeight:BASESCRREN_H*2];
        [_bgView addSubview:self.northBgView];
        [_bgView addSubview:self.southBgView];
    }
    return _bgView;
}

- (UIImageView *)northBgView
{
    if (!_northBgView) {
        _northBgView = [[UIImageView alloc]initWithFrame:BASESCRREN_B];
        _northBgView.contentMode = UIViewContentModeScaleAspectFit;
        _northBgView.userInteractionEnabled = YES;
        
        UIButton *leftBtn = [self directionBtnWithImageName:@"world_planeleft_btn"];
        leftBtn.center = CGPointMake(FLEXIBLE_NUM(61),FLEXIBLE_NUM(425));
        [_northBgView addSubview:leftBtn];
        
        UIButton *rightBtn = [self directionBtnWithImageName:@"world_planeright_btn"];
        rightBtn.center = CGPointMake(BASESCRREN_W-FLEXIBLE_NUM(61), FLEXIBLE_NUM(425));
        [_northBgView addSubview:rightBtn];
        
        UIButton *downBtn = [self directionBtnWithImageName:@"world_planedown_btn"];
        downBtn.center = CGPointMake(BASESCRREN_W/2,BASESCRREN_H-FLEXIBLE_NUM(71));
        [_northBgView addSubview:downBtn];
        
        [self directionBtnPressed:rightBtn];
    }
    return _northBgView;
}

- (UIImageView *)southBgView
{
    if (!_southBgView) {
        _southBgView = [[UIImageView alloc]initWithFrame:BASESCRREN_B];
        [_southBgView setOriginY:BASESCRREN_H];
        _southBgView.contentMode = UIViewContentModeScaleAspectFit;
        _southBgView.userInteractionEnabled = YES;
        
        UIButton *leftBtn = [self directionBtnWithImageName:@"world_planeleft_btn"];
        leftBtn.center = CGPointMake(FLEXIBLE_NUM(61),FLEXIBLE_NUM(425));
        [_southBgView addSubview:leftBtn];
        
        UIButton *rightBtn = [self directionBtnWithImageName:@"world_planeright_btn"];
        rightBtn.center = CGPointMake(BASESCRREN_W-FLEXIBLE_NUM(61), FLEXIBLE_NUM(425));
        [_southBgView addSubview:rightBtn];
        
        UIButton *downBtn = [self directionBtnWithImageName:@"world_planeup_btn"];
        downBtn.center = CGPointMake(BASESCRREN_W/2,FLEXIBLE_NUM(71));
        [_southBgView addSubview:downBtn];
    }
    return _southBgView;
}

- (UIButton *)directionBtnWithImageName:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *bgImage = [UIImage imageNamed:imageName];
    button.frame = CGRectMake(0, 0,FLEXIBLE_NUM(bgImage.size.width),FLEXIBLE_NUM(bgImage.size.height));
    
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(directionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *directionArray = @[@"world_planeup_btn",
                                @"world_planedown_btn",
                                @"world_planeleft_btn",
                                @"world_planeright_btn"];
    NSInteger index = [directionArray indexOfObject:imageName];
    button.tag = index+BUTTON_TAG;
    
    return button;
}

#pragma mark - 按钮方法
- (void)directionBtnPressed:(UIButton *)sender
{
    self.lastBtn = sender;
    [self updateMapBackgroundView];
}

#pragma mark - 自定义方法
- (NSInteger)processIndexWithIndex:(NSInteger)index
{
    if (index < 0) {
        index = self.northImageArray.count - 1;
    }
    else if (index > self.northImageArray.count -1){
        index = 0;
    }
    return index;
}

- (void)updateMapBackgroundView
{
    BOOL update = NO;
    
    NSInteger index = self.lastBtn.tag-BUTTON_TAG;
    if (index == 2) {
        self.currentIndex = [self processIndexWithIndex:self.currentIndex - 1];
        update = YES;
    }
    else if (index == 3){
        self.currentIndex = [self processIndexWithIndex:self.currentIndex + 1];
        update = YES;
    }
    else if (index == 0){
        [UIView animateWithDuration:0.2 animations:^{
            [self.bgView setOriginY:0];
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (index == 1){
        [UIView animateWithDuration:0.2 animations:^{
            [self.bgView setOriginY:-MAINSCRREN_H];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    if (update == NO) {
        return;
    }

    self.northBgView.image = [UIImage imageNamed:self.northImageArray[self.currentIndex]];
    self.southBgView.image = [UIImage imageNamed:self.southImageArray[self.currentIndex]];
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initializeDataSource];
//    [self initializeUserInterface];
//}
//
//#pragma mark -- initialize
//- (void)initializeDataSource
//{
//    
//}
//
//- (void)initializeUserInterface
//{
//    
//    self.view.backgroundColor = [UIColor redColor];
//    
//    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
//    [backgroundView setImage:[UIImage imageNamed:@"地球图标1bg.png"]];
//    [self.view addSubview:backgroundView];
//    
//    
////    _backBuutton = ({
////        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(35), FLEXIBLE_NUM(40), FLEXIBLE_NUM(40))];
////                button.backgroundColor = [UIColor clearColor];
//////        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
////        [button addTarget:self action:@selector(backButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
////        [self.view addSubview:button];
////        button;
////    });
//}
//
//
//
//- (void) backButtonCLick: (UIButton *)sender
//{
//    [self.translationController popViewController];
//}

@end
