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
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(100), FLEXIBLE_NUM(100), FLEXIBLE_NUM(100), FLEXIBLE_NUM(100))];
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(mathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
//    _webView = ({
//        UIWebView * webView = [[UIWebView alloc] initWithFrame:FLEXIBLE_FRAME(0, 0, BASESCRREN_W, MAINSCRREN_H)];
//        webView.delegate = self;
//                webView.backgroundColor = [UIColor greenColor];
//        [self.view addSubview:webView];
//        webView;
//    });
//    
//    [self loadDocument:@"index.html" inView:_webView];
    
}

#pragma mark -- buttonCLick
- (void) mathButtonClick: (UIButton *) sender
{
    MathViewController * mathVC = [[MathViewController alloc] init];
    [self.translationController pushViewController:mathVC];
    
}

//-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//}

@end
