//
//  ReviewViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/7/26.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewModel.h"


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
    
    //返回按钮
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, FLEXIBLE_NUM(605), FLEXIBLE_NUM(70), FLEXIBLE_NUM(44))];
    [backButton setBackgroundImage:[UIImage imageNamed:@"场景"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self createButtonWithNumber:6 SubjrctTag:0];
    [self createButtonWithNumber:6 SubjrctTag:1];
    [self createButtonWithNumber:6 SubjrctTag:2];
    [self createButtonWithNumber:6 SubjrctTag:3];
    [self createButtonWithNumber:6 SubjrctTag:4];
    [self createButtonWithNumber:6 SubjrctTag:5];
    
    
    
}


#pragma mark -- buttonClick
- (void) backButtonClick: (UIButton *) sender{

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) buttonClick:(UIButton *)sender
{
    NSLog(@"button.tag == %ld",sender.tag);
    
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
            if (i == 6 || i == 2 || i == 4) {
                
                [button setTitleColor:[UIColor colorWithRed:165/255.0 green:132/255.0 blue:40/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else{
            if (i == 1 || i == 3 || i == 5) {
                [button setTitleColor:[UIColor colorWithRed:165/255.0 green:132/255.0 blue:40/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
        
        
//        NSArray * numArray = [[NSArray alloc] initWithObjects:@"1",@"3", nil];
//        for (int j = 0; j < numArray.count; j ++) {
//            NSLog(@"numArray == %@",numArray[i]);
//            button.frame = CGRectMake(FLEXIBLE_NUM(110) + FLEXIBLE_NUM(145) * i, FLEXIBLE_NUM(27 + 122 * [numArray[j] integerValue]), FLEXIBLE_NUM(145), FLEXIBLE_NUM(100));
//            
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
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        
    }
    
}

- (void) addNumOfButtonWithNumber:(NSString *) number
{
    
    
    
}





@end
