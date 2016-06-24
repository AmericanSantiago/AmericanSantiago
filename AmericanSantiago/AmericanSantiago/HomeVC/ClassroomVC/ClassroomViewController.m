//
//  ClassroomViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ClassroomViewController.h"
#import "HomeModel.h"
#import "MathViewController.h"

@interface ClassroomViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton                              * mathButton;

@property (nonatomic ,strong) HomeModel                      * homeModel;

@property (nonatomic, strong) UIWebView                     * webView;

@end

@implementation ClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    
    [_homeModel getGetUnlockedGamesWithUsername:@"mwk" SubjectId:@"1" SceneType:@"classroom"];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    

    _mathButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(340), FLEXIBLE_NUM(580), FLEXIBLE_NUM(80), FLEXIBLE_NUM(100))];
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(mathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    _webView = ({
        UIWebView * webView = [[UIWebView alloc] initWithFrame:BASESCRREN_B];
        webView.delegate = self;
        webView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:webView];
        webView;
    });
    
    [self loadDocument:@"index" fileTypeName:@"apple" inView:_webView];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成")
}

#pragma mark -- buttonCLick
- (void) mathButtonClick: (UIButton *) sender
{
    MathViewController * mathVC = [[MathViewController alloc] init];
    [self.translationController pushViewController:mathVC];
    
}

-(void)loadDocument:(NSString*)documentName fileTypeName:(NSString *)fileTypeName inView:(UIWebView*)webView
{
    
    //拖进去的文件夹，拖成蓝色。  用下面这种路径
    //找路径  直接这么找Htmls/3_1_City_petstore/cat/3_I.1_VDEO_CNT_SERIES（index在哪就找它上一层）ok? ok
    
    
    NSString *directoryString = [NSString stringWithFormat:@"Htmls/chick/3_1_School_Classroom/%@/3_I.1_VDEO_CNT_SERIES",fileTypeName];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:directoryString];
    NSURL * url = [NSURL URLWithString:filePath];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

@end
