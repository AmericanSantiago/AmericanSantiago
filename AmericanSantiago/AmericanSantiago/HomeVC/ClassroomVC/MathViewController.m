//
//  MathViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/24.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "MathViewController.h"

@interface MathViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView                     * webView;

@end

@implementation MathViewController

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
    
//    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
//    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
//    [self.view addSubview:backgroundView];
//    
    _webView = ({
        UIWebView * webView = [[UIWebView alloc] initWithFrame:FLEXIBLE_FRAME(0, 0, BASESCRREN_W, MAINSCRREN_H)];
        webView.delegate = self;
//        webView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:webView];
        webView;
    });
    
    [self loadDocument:@"index.html" inView:_webView];

//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"index.html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    self.webView.scalesPageToFit = YES;
//    
//    [self.webView loadRequest:request];
    
//    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
//    NSString *path = [mainBundleDirectory  stringByAppendingPathComponent:@"index.html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    self.webView.scalesPageToFit = YES;
//    [self.webView loadRequest:request];
    
    
    
    
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

@end
