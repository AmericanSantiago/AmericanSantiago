//
//  FigureViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "FigureViewController.h"

@interface FigureViewController ()

@property (nonatomic, strong) UIButton                            * boyButton;
@property (nonatomic, strong) UIButton                            * girlButton;

@property (nonatomic, strong) UIImageView                   * figerImageView;//人物图View

@end

@implementation FigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"人物";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    
    
}

- (void)initializeUserInterface
{
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    _figerImageView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(210), FLEXIBLE_NUM(100), FLEXIBLE_NUM(350), FLEXIBLE_NUM(400))];
        imageView.backgroundColor = [UIColor yellowColor];
        imageView.image = [UIImage imageNamed:@"boy.jpg"];
        [self.view addSubview:imageView];
        imageView;
    });
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(50), FLEXIBLE_NUM(550), FLEXIBLE_NUM(150), FLEXIBLE_NUM(40))];
    label.text = @"请选择角色:";
    label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    NSArray * titleArray = [[NSArray alloc] initWithObjects:@"男孩",@"女孩", nil];
    for (int i = 0 ; i < 2; i ++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(210) + FLEXIBLE_NUM(150) * i, FLEXIBLE_NUM(560), FLEXIBLE_NUM(25), FLEXIBLE_NUM(25))];
        [imageView setImage:[UIImage imageNamed:@"圆圈.png"]];
        imageView.tag = IMGVIEW_TAG + i;
        [self.view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(240) + FLEXIBLE_NUM(150) * i, FLEXIBLE_NUM(550), FLEXIBLE_NUM(100), FLEXIBLE_NUM(40))];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(25)];
        label.textColor = [UIColor grayColor];
        [self.view addSubview:label];
        
    }
    
    _boyButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(210), FLEXIBLE_NUM(550), FLEXIBLE_NUM(125), FLEXIBLE_NUM(40))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(boyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _girlButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(210 + 150), FLEXIBLE_NUM(550), FLEXIBLE_NUM(125), FLEXIBLE_NUM(40))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(girlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
}

#pragma mark -- buttonClick
- (void) boyButtonClick: (UIButton *)sender
{
    NSLog(@"boy!");
    for (int i = 0; i < 2; i ++) {
        UIImageView * imageView = (UIImageView * )[self.view viewWithTag:IMGVIEW_TAG + i];
        [imageView setImage:[UIImage imageNamed:@"圆圈.png"]];
    }
    
    UIImageView * imageView = (UIImageView * )[self.view viewWithTag:IMGVIEW_TAG];
    [imageView setImage:[UIImage imageNamed:@"圆圈选中.png"]];
    
    [_figerImageView setImage:[UIImage imageNamed:@"boy.jpg"]];
    
}
- (void) girlButtonClick: (UIButton *)sender
{
    NSLog(@"girl!");
    for (int i = 0; i < 2; i ++) {
        UIImageView * imageView = (UIImageView * )[self.view viewWithTag:IMGVIEW_TAG + i];
        [imageView setImage:[UIImage imageNamed:@"圆圈.png"]];
    }
    
    UIImageView * imageView = (UIImageView * )[self.view viewWithTag:IMGVIEW_TAG + 1];
    [imageView setImage:[UIImage imageNamed:@"圆圈选中.png"]];
    
    [_figerImageView setImage:[UIImage imageNamed:@"girl.jpg"]];
    
}


@end
