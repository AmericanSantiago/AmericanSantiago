//
//  ParentsViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ParentsViewController.h"

@interface ParentsViewController ()

@property (nonatomic, strong) UILabel                           * numLabel;             //小红花数量label
@property (nonatomic, strong) UITextView                       * detailTextView;

@end

@implementation ParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    
    
}

- (void)initializeUserInterface
{
    //背景
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCRREN_W, MAINSCRREN_H)];
    //    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView setImage:[UIImage imageNamed:@"家长反馈bg.png"]];
    backgroundView.alpha = 0.6;
    [self.view addSubview:backgroundView];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(20), FLEXIBLE_NUM(20), BASESCRREN_W - FLEXIBLE_NUM(40), BASESCRREN_H - FLEXIBLE_NUM(40))];
    view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:225/255.0 alpha:1];
    view1.layer.cornerRadius = FLEXIBLE_NUM(10);
    [self.view addSubview:view1];
    
    //时间View
    UIImageView * timeView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(120), FLEXIBLE_NUM(50), FLEXIBLE_NUM(340), FLEXIBLE_NUM(70))];
    [timeView setImage:[UIImage imageNamed:@"设置时间@3x"]];
    [self.view addSubview:timeView];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(30), FLEXIBLE_NUM(10), FLEXIBLE_NUM(300), FLEXIBLE_NUM(45))];
    timeLabel.text = @"设置时间                  分";
//    timeLabel.backgroundColor = [UIColor blueColor];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:FLEXIBLE_NUM(30)];
    [timeView addSubview:timeLabel];
    
    UIImageView * flowerView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(600), FLEXIBLE_NUM(50), FLEXIBLE_NUM(70), FLEXIBLE_NUM(70))];
    [flowerView setImage:[UIImage imageNamed:@"小红花@3x"]];
    [self.view addSubview:flowerView];
    
    _numLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(700), FLEXIBLE_NUM(50), FLEXIBLE_NUM(100), FLEXIBLE_NUM(60))];
        label.textColor = [UIColor colorWithRed:145/255.0 green:106/255.0 blue:46/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(35)];
        label.text = @"28";
        [self.view addSubview:label];
        label;
    });
    
    _detailTextView = ({
        UITextView * label = [[UITextView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(90), FLEXIBLE_NUM(160), FLEXIBLE_NUM(640), FLEXIBLE_NUM(170))];
        label.text = @"At WWDC we made lots of major announcements. iOS 10 is our biggest release yet, with incredible features in Messages and an all-new design for Maps, Photos, and Apple Music. With macOS Sierra, Siri makes its debut on your desktop and Apple Pay comes to the web. The latest watchOS offers easier navigation and a big boost in performance. And the updated tvOS brings expanded Siri searches.";
//        [label sizeToFit];
        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(27)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:208/255.0 green:168/255.0 blue:72/255.0 alpha:1];
        [self.view addSubview:label];
        label;
    });
    
    
    
    
}

@end
