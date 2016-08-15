//
//  HexagonButton.m
//  贝塞尔曲线实战之——进度条
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 xuqigang. All rights reserved.
//

#import "HexagonButton.h"

@implementation HexagonButton

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor brownColor];
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"六边形"]];
        
//        UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        backImageView.center = self.center;
//        [backImageView setImage:[UIImage imageNamed:@"六边形@3x"]];
//        [self addSubview:backImageView];
        
        //添加单击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void) layoutSubviews
{
    self.backgroundColor = [UIColor colorWithRed:171/255.0 green:123/255.0 blue:50/255.0 alpha:1];
    
    [super layoutSubviews];
    CGFloat SIZE = self.frame.size.width;
    // step 1: 生成六边形路径
    CGFloat longSide = SIZE * 0.5 * cosf(M_PI * 30 / 180);
    CGFloat shortSide = SIZE * 0.5 * sin(M_PI * 30 / 180);
    CGFloat k = SIZE * 0.5 - longSide;  //路径整体下移，保证六边形路径位于图形中间
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, longSide  + k)];
    [_path addLineToPoint:CGPointMake(shortSide, + k)];
    [_path addLineToPoint:CGPointMake(shortSide + shortSide + shortSide,  k)];
    [_path addLineToPoint:CGPointMake(SIZE, longSide + k)];
    [_path addLineToPoint:CGPointMake(shortSide * 3, longSide * 2 + k)];
    [_path addLineToPoint:CGPointMake(shortSide, longSide * 2 + k)];
    [_path closePath];
    
    _path.lineWidth = FLEXIBLE_NUM(5);
    
    //设置填充颜色
    UIColor *fillColor = [UIColor colorWithRed:171/255.0 green:123/255.0 blue:50/255.0 alpha:1];
    [fillColor set];
    [_path fill];
    
    //设置画笔颜色
    UIColor * strokeColor = [UIColor colorWithRed:145/255.0 green:106/255.0 blue:46/255.0 alpha:1];
    [strokeColor set];
    [_path stroke];
    
    // step 2: 根据路径生成蒙板
    _maskLayer = [CAShapeLayer layer];
    //    _maskLayer.position = self.center;
    _maskLayer.path = [_path CGPath];
    
    // step 3: 添加蒙版
    self.layer.mask = _maskLayer;

    
    
//    self.layer.borderWidth = FLEXIBLE_NUM(5);
//    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:145/255.0 green:106/255.0 blue:46/255.0 alpha:1]);
//    self.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"六边形"]];
    
}

//点击事件
- (void) click:(UITapGestureRecognizer *) tap
{
    if (_block) {
        _block();
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //如果点击的区域在所创建的路径范围内
    if (CGPathContainsPoint(_path.CGPath, NULL, point, NO)) {
        
        return [super hitTest:point withEvent:event];
        
    }
    return nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
