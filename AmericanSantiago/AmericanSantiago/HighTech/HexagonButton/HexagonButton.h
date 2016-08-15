//
//  HexagonButton.h
//  贝塞尔曲线实战之——进度条
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 xuqigang. All rights reserved.
//

#import <UIKit/UIKit.h>
//六边形Button
@interface HexagonButton : UIView
NS_ASSUME_NONNULL_BEGIN

typedef void (^HexagonButtonBlock)();

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) HexagonButtonBlock block; //点击事件

//添加点击事件


NS_ASSUME_NONNULL_END
@end
