//
//  ParentsViewController.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ParentsViewController.h"
#import "ParentsModel.h"
#import "UUChart.h"

@interface ParentsViewController ()<UUChartDataSource>

@property (nonatomic, strong) UILabel                           * numLabel;             //小红花数量label
@property (nonatomic, strong) UITextView                       * detailTextView;

@property (nonatomic, strong) UIView                                * chartView;                // 图表View

@property (nonatomic, strong) ParentsModel                      * parentsModel;

@property (nonatomic, strong) UUChart                                   *UUChartView;

@property (nonatomic, strong) NSMutableArray                                   * YArray;
@property (nonatomic, strong) NSMutableArray                                   * XArray;

@end

@implementation ParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeUserInterface];
}


- (void)dealloc
{
    [_parentsModel  removeObserver:self forKeyPath:@"learningStatisticsData"];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"learningStatisticsData"]) {
        
        for (int i = 0; i < [[[_parentsModel.learningStatisticsData valueForKey:@"data"] valueForKey:@"subjects"] count]; i ++) {
            [_YArray addObject:[[[[_parentsModel.learningStatisticsData valueForKey:@"data"] valueForKey:@"subjects"][i] valueForKey:@"dailyData"] valueForKey:@"average"]];
            
            
        }
        _UUChartView = [[UUChart alloc]initWithFrame:CGRectMake(0, 0, FLEXIBLE_NUM(550), FLEXIBLE_NUM(300))
                                          dataSource:self
                                               style:UUChartStyleLine];
        _UUChartView.backgroundColor = [UIColor clearColor];
        [_UUChartView showInView:_chartView];
//        NSLog(@"_YArray = %@",_YArray);
        
    }
    
    
}

- (void)initializeDataSource
{
    _XArray = [[NSMutableArray alloc] init];
    _YArray = [[NSMutableArray alloc] init];
    
    _parentsModel = [[ParentsModel alloc] init];
    [_parentsModel addObserver:self forKeyPath:@"learningStatisticsData" options:NSKeyValueObservingOptionNew context:nil];
    
    [_parentsModel getLearningStatisticsWithUsername:@"Mwk"];
    
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
    timeLabel.text = @"设置时间                分";
//    timeLabel.backgroundColor = [UIColor blueColor];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(30)];
    [timeView addSubview:timeLabel];
    
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
    
    
    
    UIImageView * flowerView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(730), FLEXIBLE_NUM(50), FLEXIBLE_NUM(150), FLEXIBLE_NUM(75))];
    [flowerView setImage:[UIImage imageNamed:@"小红花@3x"]];
    [self.view addSubview:flowerView];
    
    _numLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(815), FLEXIBLE_NUM(60), FLEXIBLE_NUM(100), FLEXIBLE_NUM(60))];
        label.textColor = [UIColor colorWithRed:145/255.0 green:106/255.0 blue:46/255.0 alpha:1];
        label.font = [UIFont fontWithName:@"YuppySC-Regular" size:FLEXIBLE_NUM(38)];
        label.text = @"28";
        [self.view addSubview:label];
        label;
    });
    
    _detailTextView = ({
        UITextView * label = [[UITextView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(110), FLEXIBLE_NUM(160), FLEXIBLE_NUM(640), FLEXIBLE_NUM(170))];
        label.text = @"At WWDC we made lots of major announcements. iOS 10 is our biggest release yet, with incredible features in Messages and an all-new design for Maps, Photos, and Apple Music. With macOS Sierra, Siri makes its debut on your desktop and Apple Pay comes to the web. The latest watchOS offers easier navigation and a big boost in performance. And the updated tvOS brings expanded Siri searches.";
//        [label sizeToFit];
        label.font = [UIFont systemFontOfSize:FLEXIBLE_NUM(27)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:208/255.0 green:168/255.0 blue:72/255.0 alpha:1];
        [self.view addSubview:label];
        label;
    });
    
    _chartView = ({
        UIView * chartView = [[UIView alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(110), FLEXIBLE_NUM(400), FLEXIBLE_NUM(550), FLEXIBLE_NUM(300))];
//        chartView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:chartView];
        chartView;
    });
    

    
    

    
    
}

//设置横坐标
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"Day-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:4];

}
//数值多重数组    点的纵坐标
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
    NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"];
    
    return _YArray;

}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor red],[UUColor green],[UUColor brown]];
}
//显示数值范围   纵坐标范围
- (CGRange)chartRange:(UUChart *)chart
{
    return CGRangeMake(10, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
//- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
//{
//    return path.row == 2;
//}



@end
