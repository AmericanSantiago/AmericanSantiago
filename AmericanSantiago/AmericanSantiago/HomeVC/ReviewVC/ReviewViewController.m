//
//  ReviewViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/7/26.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewModel.h"
#import "HexagonButton.h"

@interface ReviewViewController ()

@property (nonatomic, strong) ReviewModel                           *reviewModel;


@end

@implementation ReviewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_reviewModel removeObserver:self forKeyPath:@"reviewGameData"];
    
    
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"reviewGameData"]) {
        if ([[_reviewModel.reviewGameData valueForKey:@"data"] count] < 51) {
            [self createButtonWithNumber:1 SubjrctTag:0]; //数学
        }
        
        
    }
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _reviewModel = [[ReviewModel alloc] init];
    [_reviewModel addObserver:self forKeyPath:@"reviewGameData" options:NSKeyValueObservingOptionNew context:nil];
    
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    [_reviewModel getReviewGamesWithUsername:[userDic valueForKey:@"username"] subjectId:@"Math" sceneType:@"city"];
    
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"复习界面选择2bg.png"]];
    [self.view addSubview:backgroundView];
    
    //返回按钮
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, FLEXIBLE_NUM(605), FLEXIBLE_NUM(70), FLEXIBLE_NUM(44))];
    [backButton setBackgroundImage:[UIImage imageNamed:@"场景"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
//    [self createButtonWithNumber:6 SubjrctTag:0];
//    [self createButtonWithNumber:6 SubjrctTag:1];
//    [self createButtonWithNumber:6 SubjrctTag:2];
//    [self createButtonWithNumber:6 SubjrctTag:3];
//    [self createButtonWithNumber:6 SubjrctTag:4];
//    [self createButtonWithNumber:6 SubjrctTag:5];
    
}


#pragma mark -- buttonClick
- (void) backButtonClick: (UIButton *) sender{

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- 自定义方法
//通过个数（number）、行数（subjectId）来创建button
- (void) createButtonWithNumber:(NSInteger)number SubjrctTag:(NSInteger )subjectTag
{
    NSArray * numArray = [[NSArray alloc] initWithObjects:@"1-50",@"51-100",@"101-150",@"151-200",@"201-250",@"251-300", nil];
    
    for (int i = 0; i < number; i ++) {
//        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(110) + FLEXIBLE_NUM(145) * i, FLEXIBLE_NUM(27), FLEXIBLE_NUM(145), FLEXIBLE_NUM(100))];
        UIButton * button = [[UIButton alloc] init];
        
        button.frame = CGRectMake(FLEXIBLE_NUM(110) + FLEXIBLE_NUM(145) * i, FLEXIBLE_NUM(27 + 122 * subjectTag), FLEXIBLE_NUM(145), FLEXIBLE_NUM(100));
        [button setTitle:numArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(30)];
        
        if (subjectTag == 0 || subjectTag == 2 || subjectTag == 4) {
            if (i == 5 || i == 1 || i == 3) {
                [button setTitleColor:[UIColor colorWithRed:165/255.0 green:132/255.0 blue:40/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else{
            if (i == 0 || i == 2 || i == 4) {
                [button setTitleColor:[UIColor colorWithRed:165/255.0 green:132/255.0 blue:40/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
        
        
//        NSArray * numArray = [[NSArray alloc] initWithObjects:@"1",@"3", nil];
//        for (int j = 0; j < numArray.count; j ++) {
//            NSLog(@"numArray == %@",numArray[i]);
//            button.frame = CGRectMake(FLEXIBLE_NUM(110) + FLEXIBLE_NUM(145) * i, FLEXIBLE_NUM(27 + 122 * [numArray[j] integerValue]), FLEXIBLE_NUM(145), FLEXIBLE_NUM(100));
   
//        }
        
        button.tag = BUTTON_TAG + i + subjectTag * 10;
        
        if (i == 2 || i == 4) {
            [button setBackgroundImage:[UIImage imageNamed:@"深色中间"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"浅色中间"] forState:UIControlStateNormal];
        }
        if (i == 0) {
            [button setBackgroundImage:[UIImage imageNamed:@"最左边"] forState:UIControlStateNormal];
        }
        if (i == 5) {
            [button setBackgroundImage:[UIImage imageNamed:@"最右边"] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(numberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        
    }
    
}

- (void) addNumOfButtonWithNumber:(NSString *) number
{
    
    
}

- (void) numberButtonClick:(UIButton *)sender
{
    NSLog(@"button.tag == %ld",sender.tag);

    [self creatView];
    
}



//添加复习进度界面
- (void) creatView
{
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, BASESCRREN_H)];
    view1.backgroundColor = [UIColor clearColor];
    view1.tag = 10003;
    [self.view addSubview:view1];
    
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.userInteractionEnabled = NO;
    effectView.tag = 10002;
    //添加到要有毛玻璃特效的控件中
    effectView.frame = self.view.bounds;
    effectView.alpha = 0;
    [view1 addSubview:effectView];
    
    UIButton * dissmissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, BASESCRREN_H)];
    //    dissmissButton.alpha = 0;
    [dissmissButton addTarget:self action:@selector(dissmissButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    dissmissButton.backgroundColor = [UIColor clearColor];
    dissmissButton.tag = 10001;
    [view1 addSubview:dissmissButton];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(130), FLEXIBLE_NUM(100), FLEXIBLE_NUM(760), FLEXIBLE_NUM(550))];
    view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:197/255.0 blue:40/255.0 alpha:1];
    view2.layer.cornerRadius = FLEXIBLE_NUM(20);
    view2.tag = 10004;
    [self.view addSubview:view2];
    
//    UIImageView * reviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(760), FLEXIBLE_NUM(550))];
//    //        reviewImageView.center = CGPointMake(MAINSCRREN_W/2, MAINSCRREN_H/2);
//    [reviewImageView setImage:[UIImage imageNamed:@"复习界面选择数学"]];
//    //    reviewImageView.alpha = 0;
//    //    reviewImageView.layer.cornerRadius = FLEXIBLE_NUM(10);
//    //    reviewImageView.backgroundColor = [UIColor ]
//    reviewImageView.tag = 10000;
//    reviewImageView.userInteractionEnabled = NO;
//    [view2 addSubview:reviewImageView];
    
    dissmissButton.alpha = 0.5;
    effectView.alpha = 0.9;
    [UIView animateWithDuration:0.3 animations:^{
//        reviewImageView.alpha = 1;
    }];
    
    [self createButtonWithNumber:3];
}

- (void)dissmissButtonClick: (UIButton *) sender{
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:10000];
    UIButton * button = (UIButton *)[self.view viewWithTag:10001];
    UIVisualEffectView * effectView = (UIVisualEffectView *)[self.view viewWithTag:10002];
    UIView * view1 = (UIView *)[self.view viewWithTag:10003];
    UIView * view2 = (UIView *)[self.view viewWithTag:10004];
    
    [imageView removeFromSuperview];
    [button removeFromSuperview];
    [effectView removeFromSuperview];
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
}

- (void) createButtonWithNumber:(NSInteger)number
{
    UIView * view2 = (UIView *)[self.view viewWithTag:10004];
    
    for (int i = 0; i < number; i ++) {
        HexagonButton * hexagonButton = [[HexagonButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(90) * i, FLEXIBLE_NUM(50), FLEXIBLE_NUM(80), FLEXIBLE_NUM(80))];
        hexagonButton.tag = BUTTON_TAG + i;
        hexagonButton.block = ^(){
            NSLog(@"六边形区域被点击");
            NSLog(@"hexagon.tag = %ld",(long)hexagonButton.tag);
        };
        
        [view2 addSubview:hexagonButton];
    }
    
    

    
    
    
}



@end
