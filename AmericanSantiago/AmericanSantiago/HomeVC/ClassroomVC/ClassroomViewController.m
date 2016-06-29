//
//  ClassroomViewController.m
//  z
//
//  Created by Mervin on 16/6/15.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "ClassroomViewController.h"
#import "HomeModel.h"
#import <WebKit/WebKit.h>

@interface ClassroomViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton                              * mathButton;

@property (nonatomic ,strong) HomeModel                      * homeModel;

@property (nonatomic, strong) WKWebView                     * webView;
//@property (nonatomic, strong) UIWebView                     * webView;

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
    if ([keyPath isEqualToString:@"unlockedGamesData"]) {
        
        
        
    }
    
    
}

#pragma mark -- initialize
- (void)initializeDataSource
{
    _homeModel = [[HomeModel alloc] init];
    [_homeModel addObserver:self forKeyPath:@"unlockedGamesData" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)initializeUserInterface
{
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BASESCRREN_W, MAINSCRREN_H)];
    [backgroundView setImage:[UIImage imageNamed:@"课堂bg.png"]];
    [self.view addSubview:backgroundView];
    

    _mathButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(320), FLEXIBLE_NUM(530), FLEXIBLE_NUM(110), FLEXIBLE_NUM(90))];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(mathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(FLEXIBLE_NUM(300), FLEXIBLE_NUM(200), FLEXIBLE_NUM(100), FLEXIBLE_NUM(100))];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
}

#pragma mark -- buttonCLick
- (void) mathButtonClick: (UIButton *) sender
{
    NSDictionary *userDic = [LBUserDefaults getUserDic];
    [_homeModel getGetUnlockedGamesWithUsername:[userDic valueForKey:@"username"] SubjectId:@"Math" SceneType:@"classroom"];
    
    GameViewController * gameVC = [[GameViewController alloc] init];
    [self.translationController pushViewController:gameVC];
    
}


- (void) buttonClick:(UIButton *) sender
{
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


@end
