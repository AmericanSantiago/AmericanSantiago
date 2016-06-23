//
//  RootLeftView.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "RootLeftView.h"

@interface RootLeftView ()

@property (strong, nonatomic) UIButton *lastBtn;
@property (strong, nonatomic) UIButton *backBtn;

@property (strong, nonatomic) NSArray *titles;

@end

@implementation RootLeftView

- (instancetype)initTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titles = titles;
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
//    NSArray *titles = @[@"主页", @"人物", @"家长", @"设置", @"截图", @"返回"];
    
    CGFloat width = FLEXIBLE_NUM(61);
    CGFloat height = FLEXIBLE_NUM(61);
    CGFloat offsetY = FLEXIBLE_NUM(20);
    CGFloat maxY = -offsetY;
    self.frame = CGRectMake(0, 0,FLEXIBLE_NUM(61),height*self.titles.count+(self.titles.count-1)*offsetY);
    
    for (NSInteger i = 0; i < self.titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = BUTTON_TAG + i;
        button.frame = CGRectMake(0,maxY+offsetY, width, height);
//        button.backgroundColor = [UIColor whiteColor];
        NSString *imageName = [NSString stringWithFormat:@"%@",self.titles[i]];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:imageName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        maxY = CGRectGetMaxY(button.frame);
        [self addSubview:button];
    }
    // 指示器
//    [self.layer addSublayer:self.indicator];
    [self buttonPressed:(UIButton *)[self viewWithTag:BUTTON_TAG]];
}

- (void)buttonPressed:(UIButton *)sender
{
    NSString *titleStr = sender.titleLabel.text;
    if ([titleStr isEqualToString:@"返回"]) {
        [self.delegate selectedBackBtn:sender];
        return;
    }
    else if ([titleStr isEqualToString:@"截图"]){
        [self.delegate selectedScreenshotBtn:sender];
        return;
    }
    
    [self.delegate selectedActionBtn:sender];
    
    
}

@end
