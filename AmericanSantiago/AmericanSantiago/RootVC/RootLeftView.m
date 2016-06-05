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

@end

@implementation RootLeftView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0,FLEXIBLE_NUM(200), MAINSCRREN_H);
        self.backgroundColor = [UIColor whiteColor];
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    NSArray *titles = @[@"主页", @"人物", @"家长", @"设置", @"截图", @"返回"];
    
    CGFloat width = FLEXIBLE_NUM(80);
    CGFloat height = FLEXIBLE_NUM(78);
    CGFloat centerX = self.frame.size.width/2;
    CGFloat offsetY = self.frame.size.height/(titles.count+1);
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, width, height);
        button.center = CGPointMake(centerX, i*offsetY+offsetY);
        button.backgroundColor = [UIColor whiteColor];
//        [button setTitle:titles[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor brownColor] forState:UIControlStateSelected];
        NSString *imageName = [NSString stringWithFormat:@"button%@",@(i)];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.tag = BUTTON_TAG + i;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (i == titles.count-1) {
            self.backBtn = button;
        }
        [self addSubview:button];
    }
    // 指示器
//    [self.layer addSublayer:self.indicator];
    [self buttonPressed:(UIButton *)[self viewWithTag:BUTTON_TAG]];
}

- (void)buttonPressed:(UIButton *)sender
{
    if (sender == self.backBtn) {
        [self.delegate selectedBackBtn:sender];
        return;
    }
    if (self.lastBtn != sender) {
        self.lastBtn.selected = NO;
        sender.selected = YES;
        self.lastBtn = sender;
        [self.delegate selectedWithIndex:sender.tag-BUTTON_TAG];
    }
    
}

@end
