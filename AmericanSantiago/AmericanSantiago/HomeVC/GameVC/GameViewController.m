//
//  GameViewController.m
//  AmericanSantiago
//
//  Created by Mervin on 16/6/25.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "GameViewController.h"
#import <WebKit/WebKit.h>
#import "HomeModel.h"
#import "GameModel.h"

@interface GameViewController ()<WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic ,strong) HomeModel                      * homeModel;

@property (nonatomic, strong) WKWebView                     * webView;
@property (nonatomic, strong) GameModel                     * gameModel;

//@property (nonatomic, strong)          * bridge;
//WebViewJavascriptBridge
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc
{
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
//    [_gameModel removeObserver:self forKeyPath:@"gameNewData"];
    
//    [_webView removeObserver:self forKeyPath:@"finishGame"];
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"页面将面消失（测试）");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewGames" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAllUnlockGames" object:nil];
    
    //通知后台游戏完成
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    NSString * urlString = @"/ConceptFinish";
    NSDictionary* bodyObject = @{
                                 @"username":[userDic valueForKey:@"username"],
                                 @"subjectId":@"Math"};
    [LBNetWorkingManager loadPostAfNetWorkingWithUrl:urlString andParameters:bodyObject complete:^(NSDictionary *resultDic, NSString *errorString) {
        if (!errorString) {
            //            self.gameNewData = resultDic;
            NSLog(@"HTTP Response Body  gameNewData == : %@", resultDic);
            if ([[resultDic valueForKey:@"errorCode"] integerValue] == 0) {
                
                NSLog(@"通知成功");
                
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewGamesData" object:nil];
                
            }
            
        }
    }];
    
}


#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"finishGame"]) {
        if (!_webView) {
            NSLog(@"游戏结束");
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    [_homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    
    
//    _gameModel = [[GameModel alloc] init];
//    [_gameModel addObserver:self forKeyPath:@"gameNewData" options:NSKeyValueObservingOptionNew context:nil];
//    
////    [_gameModel getGameData];
//    [_gameModel getNewGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] subjectId:@"Math"];//获取新解锁游戏
    
    [_webView addObserver:self forKeyPath:@"finishGame" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    
    _webView = ({
        WKWebView * webView = [[WKWebView alloc] initWithFrame:BASESCRREN_B];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:webView];
        webView;
    });
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://115.28.156.240:8080/Yes123Server/Math/AF_AS_0dot2/city_petstore_13_26_01/13_I.1_COMPARE/index.html"];
//    NSLog(@"----------%@",_urlString);
//    NSURL * urlStr = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://115.28.156.240:8080/Yes123Server/%@/index.html",_urlString]];
//    NSLog(@"+++++++++++++%@",urlStr);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
//    [self loadDocument:@"index" fileTypeName:@"city" inView:_webView];
    
    //    [self loadDocument:@"index" fileTypeName:@"straw" inView:_webView];

    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"sendIOSCommand"];

    
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"sendIOSCommand"];
    
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
}

-(void)loadDocument:(NSString*)documentName fileTypeName:(NSString *)fileTypeName inView:(WKWebView *)webView
{
    
    //拖进去的文件夹，拖成蓝色。  用下面这种路径
    //找路径  直接这么找Htmls/3_1_City_petstore/cat/3_I.1_VDEO_CNT_SERIES（index在哪就找它上一层）ok? ok
    //    Htmls/3_1_City_petstore/cat/3_I.1_VDEO_CNT_SERIES
    //    /Users/lizujian/Desktop/小白的奇怪项目/AmericanSantiago/AmericanSantiago/AmericanSantiago/
    
   //  /Users/Mervin/Desktop/合源美智（github）/AmericanSantiago/AmericanSantiago/AmericanSantiago/Htmls/3_1_School_Classroom
    // /Users/Mervin/Desktop/合源美智（github）/AmericanSantiago/AmericanSantiago/AmericanSantiago/Htmls/Math/AF_AS_0dot2/city_mall_13_26_01/13_I.1_COMPARE/index.html
    
    NSString *directoryString = [NSString stringWithFormat:@"Htmls/Math/AF_AS_0dot2/%@_mall_13_26_01/13_I.1_COMPARE",fileTypeName];
//        NSString *directoryString = @"Htmls/Math/AF_AS_0dot2/city_mall_13_26_01/13_I.1_COMPARE/index.html";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:directoryString];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    //    NSURL * url = [NSURL URLWithString:filePath];
    //    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //
    //    [webView loadRequest:request];
    
    
    //调用逻辑
    if(filePath){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            // iOS9. One year later things are OK.
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
            // iOS8. Things can be workaround-ed
            //   Brave people can do just this
            //   fileURL = try! pathForBuggyWKWebView8(fileURL)
            //   webView.loadRequest(NSURLRequest(URL: fileURL))
            
            NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:filePath]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self.webView loadRequest:request];
            
        }
    }
    //    [webView loadFileURL:[NSURL URLWithString:filePath] allowingReadAccessToURL:[NSURL URLWithString:filePath]];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"webViewWebContentProcessDidTerminate:  当Web视图的网页内容被终止时调用。");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载完成！");
}

//当webView载入时调用此方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
//    NSLog(@"%s", __FUNCTION__);
    NSLog(@"载入webView!");
}



//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if ([message.name isEqualToString:@"sendIOSCommand"]) {
//        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
//        // NSDictionary, and NSNull类型
//        NSLog(@"%@", message.body);
//    }
    NSLog(@"方法名:%@", message.name);
    NSLog(@"参数:%@", message.body);
    // 方法名
    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    SEL selector = NSSelectorFromString(methods);
    // 调用方法
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body];
    } else {
        NSLog(@"未实行方法：%@", methods);
    }
    
    
    
    
}




@end
