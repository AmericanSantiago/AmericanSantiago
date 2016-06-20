//
//  HomeViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "HomeViewController.h"
#import "ClassroomViewController.h"
#import "WorldViewController.h"
#import "BuildingViewController.h"
#import "CityViewController.h"
#import "BuildingViewController.h"
#import "PlaygroundViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIView                                * backgroundView;
@property (nonatomic, strong) UIImageView                    * bigImageView;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
    
    _backgroundView = ({
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backgroundView];
        backgroundView;
    });
    
    _bigImageView = ({
        UIImageView * bigView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(80), FLEXIBLE_NUM(80), FLEXIBLE_NUM(630), FLEXIBLE_NUM(470))];
        bigView.backgroundColor = [UIColor yellowColor];
        [bigView setImage:[UIImage imageNamed:@"主界面1"]];
        [self.view addSubview:bigView];
        bigView;
    });
    
    NSArray * picArray = [[NSArray alloc] initWithObjects:@"主界面1",@"主界面2",@"主界面3",@"主界面4",@"主界面5", nil];
    for (int i = 0 ; i < 5; i ++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake( FLEXIBLE_NUM(43) + 200 * i , BASESCRREN_H - FLEXIBLE_NUM(140), FLEXIBLE_NUM(135), FLEXIBLE_NUM(100))];
        button.backgroundColor = [UIColor yellowColor];
        button.tag = 1 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArray[i]]] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}


#pragma mark -- button action
- (void) buttonClick:(UIButton *) sender
{
    NSLog(@"button.tag == %ld",(long)sender.tag);
//    [_bigImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"主界面%ld%ld",(long)sender.tag,(long)sender.tag]]];
    [_bigImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"主界面%ld",(long)sender.tag]]];
    
}







//跳转
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    switch (<#expression#>) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
    
    
    ClassroomViewController * classroomVC = [[ClassroomViewController alloc] init];
    [self.translationController pushViewController:classroomVC];
    
    
//    BaseViewController *baseVC = [[BaseViewController alloc]init];
//    baseVC.title = [NSString stringWithFormat:@"%@主页",@([self.title integerValue])];
//    [self.translationController pushViewController:baseVC];
}


@end
