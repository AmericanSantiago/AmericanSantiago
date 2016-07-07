//
//  AppDelegate.m
//  AmericanSantiago
//
//  Created by 李祖建 on 16/6/5.
//  Copyright © 2016年 LittleBitch. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"测试一些东西~~");
    
    // Override point for customization after application launch.
    
//    NSError *error;
//    [[AVAudioSession sharedInstance] setActive:YES error:&error];//加上这句可以在按音量键的时候不显示音量提示视图
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(volumeChanged:)
//     
//                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
//     
//                                               object:nil];
    
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];//注，ios9上不加这一句会无效，加了这一句后，
    
    //在移除通知时候加上这句[[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    
//    [LBUserDefaults clearUserDefaults];
    
    [self setRootViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark -- 改变音量
-(void)volumeChanged:(NSNotification *)noti

{
    
    float volume =
    
    [[[noti userInfo]
      
      objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
     
     floatValue];
    
    NSLog(@"volumn is %f", volume);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - getter
- (UIWindow *)window
{
    if (!_window) {
        _window = ({
            UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            window.backgroundColor = [UIColor whiteColor];
//            // 登录成功，跳转
//            RootViewController *rootViewController = [[RootViewController alloc] init];
//            
//            window.rootViewController = rootViewController;
            
            window;
        });
    }
    return _window;
}

@end
