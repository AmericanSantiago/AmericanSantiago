//
//  RootLeftView.h
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RootLeftViewDelegate <NSObject>

- (void)selectedActionBtn:(UIButton *)sender;
- (void)selectedBackBtn:(UIButton *)sender;
- (void)selectedScreenshotBtn:(UIButton *)sender;

@end

@interface RootLeftView : UIView

@property (assign, nonatomic) id<RootLeftViewDelegate>delegate;

- (instancetype)initTitles:(NSArray *)titles;


@end
