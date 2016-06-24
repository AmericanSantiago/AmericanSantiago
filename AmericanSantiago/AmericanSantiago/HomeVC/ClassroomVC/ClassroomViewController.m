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

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    
    [self loadDocument:@"index" inView:_webView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载成功");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败：%@",error);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载~");
}


#pragma mark -- buttonCLick
- (void) mathButtonClick: (UIButton *) sender
{
    MathViewController * mathVC = [[MathViewController alloc] init];
    [self.translationController pushViewController:mathVC];
    
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *directoryString = [NSString stringWithFormat:@"Htmls/3_1_School_Classroom/%@/3_I.1_VDEO_CNT_SERIES",@"pine"];
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:@"html" inDirectory:directoryString];
    
    NSURL * url = [NSURL URLWithString:path];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    
    [webView loadRequest:request];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"apple_index" ofType:@"html"];
//    
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//    NSString *basePath = [[NSBundle mainBundle] bundlePath];
//    
//    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
////    NSURL *baseURL = [NSBundle bundleWithURL:<#(nonnull NSURL *)#>]
//    
//    [_webView loadHTMLString:htmlString baseURL:baseURL];
 
//    NSURL *url = [[NSBundle mainBundle] URLForResource:documentName withExtension:@"html"];
////    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:@"html"];
////    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSString *htmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    
////    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
////    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
//    
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:bundlePath];
//    
//    [webView loadHTMLString:htmlString baseURL:baseURL];
//    
////    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
////    NSURL *url = [NSURL fileURLWithPath:path];
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
////    [webView loadRequest:request];
}

@end
