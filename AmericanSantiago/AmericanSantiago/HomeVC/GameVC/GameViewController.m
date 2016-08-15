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
@property (nonatomic, strong) UIProgressView                * progressView;

//@property (nonatomic, strong)          * bridge;
//WebViewJavascriptBridge
@end

@implementation GameViewController

- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_homeModel removeObserver:self forKeyPath:@"unlockedGamesData"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

//    NSLog(@"页面将面消失（测试）");
    //移除messageHandler代理，否则内存无法释放
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"sendEndGame"];
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"postData"];
}

#pragma mark - 数据初始化
- (void)initializeDataSource
{
//    [self.homeModel getGetUnlockedGamesWithUsername:[[LBUserDefaults getUserDic] valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    [self clearCache];
}

#pragma mark - 视图初始化
- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];

    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    if (self.gameDic) {
        [self loadRequestWithUrlFilePath:self.gameDic[@"location"]];
    }else{
        [self loadTestMathRequest];
//        [AppDelegate showHintLabelWithMessage:@"这是一个本地测试游戏~"];
    }
    
    
}
#pragma mark - 各种Getter
- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        [_progressView setOriginX:0];
        [_progressView setWidth:BASESCRREN_W];
        _progressView.progress = 0;
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        // js配置
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        //该处name要与js里面注册的name一致。。
        //在js里加上这句代码
        //window.webkit.messageHandlers.<name>.postMessage(<body>);  (<name>即下面方法的name，<body>最好为json)
        //例子：window.webkit.messageHandlers.sendEndGame.postMessage({data:"sssasa"});
        
        [userContentController addScriptMessageHandler:self name:@"sendEndGame"];   //告诉游戏端游戏完成
        [userContentController addScriptMessageHandler:self name:@"postData"];             //JS要求给他传参数
        
        
        
        // WKWebView的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        
        // 显示WKWebView
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self; // 设置WKUIDelegate代理
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (HomeModel *)homeModel
{
    if (!_homeModel) {
        _homeModel = [[HomeModel alloc] init];
        [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _homeModel;
}

- (GameModel *)gameModel
{
    if (!_gameModel) {
        _gameModel = [[GameModel alloc]init];
    }
    return _gameModel;
}

#pragma mark -- observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"unlockedGamesData"]) {
        [self unlockedGamesDataParse];
    }
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
//        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            self.progressView.hidden = YES;
        }else{
            self.progressView.hidden = NO;
        }
    }
}

#pragma mark - WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"开始加载");
}

//开始返回内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"开始返回内容");
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"加载完成");
//    _webView.hidden = NO;
    
    
}

//加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"加载失败：%@",error);
}

#pragma mark - WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler
{
    
}

#pragma mark - WKScriptMessageHandler
//OC在JS调用方法做的处理  oc收到Js通知时的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //完成游戏后，先删除新游戏的列表
    [LBUserDefaults removeNewGameDic:self.gameDic sceneName:self.gameDic[@"scene"]];
    //刷新首页的数字
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadConceptGamesData" object:@(1)];
    //检查该知识点是否还有游戏
    NSArray *conceptGamesArray = [LBUserDefaults getCurrentConceptGamesArray];
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    [_homeModel getNextConceptWithUsername:userDic[@"username"] SubjectId:@"Math"];
    
    //通知后台，游戏完成
//    [self.gameModel getConceptFinishDataWithSubjectId:[self.gameDic valueForKey:@"id"] Username:userDic[@"username"] complete:^(NSDictionary *resultDic, NSString *errorString) {
//        NSLog(@"通知成功！");
//        if (!errorString) {
//            NSLog(@"errorString");
//        }
//    }];
//    
    
    [self.gameModel sendFinishedGameDataWithUsername:userDic[@"username"] gameId:[self.gameDic valueForKey:@"id"] complete:^(NSDictionary *resultDic, NSString *errorString) {
                if (!errorString) {
                    NSLog(@"errorString = %@",errorString);
                }
    }];
    
    
    //如果说为0，则证明已经完成该教学
//    if (conceptGamesArray.count == 0) {
////        NSLog(@"self.subjectId = %@",self.subjectId);
////        NSLog(@"username = %@",userDic[@"username"]);
//        [self.gameModel getConceptFinishDataWithSubjectId:self.subjectId Username:userDic[@"username"] complete:^(NSDictionary *resultDic, NSString *errorString) {
//            if (!errorString) {
//                [AppDelegate showHintLabelWithMessage:@"当前场景已完成~"];
//            }
//        }];
//        
//    }
    
    if ([message isEqual:@"postData"]) {
        [self sendDataToJs];
        
    }
    
    
}


- (void) sendDataToJs
{
    
    NSString * string1 = [[LBUserDefaults getUserDic] valueForKey:@"username"];
    NSString * string2 = [self.gameDic valueForKey:@"id"];
    NSString * string3 = @"";
    NSString * string4 = @"";
    
//    [_webView evaluateJavaScript:string1 completionHandler:^(id _Nullable, NSError * _Nullable error) {
//        NSLog(@"error  ===   %@",error);
//        NSLog(@"JS代码出错!");
//        
////        NSLog(@"!!!!",);
//    }];

    
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



#pragma mark - 按钮方法

#pragma mark - 自定义方法
- (void)loadRequestWithUrlFilePath:(NSString *)urlFilePath
{
    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.156.240:8080/Yes123Server/%@/index.html",urlFilePath];
//    NSString * urlString1 = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"gamesUrl = %@",url);
    //url中有空格不识别，转换一下就OK
//   NSString* str1 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:str1];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadTestMathRequest
{
//    NSString *directoryString = [NSString stringWithFormat:@"/Htmls/TestMath/AF_AS_0dot2/city_market_13_26_04/13_I.1_COMPARE"];
//    //        NSString *directoryString = @"Htmls/Math/AF_AS_0dot2/city_mall_13_26_01/13_I.1_COMPARE/index.html";
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:directoryString];
//    NSURL *url = [[NSURL alloc]initFileURLWithPath:filePath];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
//        NSURL * urlStr = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://115.28.156.240:8080/Yes123Server/%@/index.html",_urlString]];
    NSURL * urlStr = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://115.28.156.240:8080/Yes123Server/%@/index.html",self.urlString]];
//    NSURL * urlStr = [[NSURL alloc] initWithString:self.urlString];
    NSLog(@"+++++++++++++%@",urlStr);
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [_webView loadRequest:request];
    
    
}

#pragma mark - 数据处理
- (void)unlockedGamesDataParse
{
    
}


/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
- (void)clearCache
{
    /* 取得Library文件夹的位置*/
    NSString *libraryDir =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    
    NSLog(@"路径==%@,fileList%@",webKitFolderInCachesfs,fileList);
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
            
        }
    }
}


@end
