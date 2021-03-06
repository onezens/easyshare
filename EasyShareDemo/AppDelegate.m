//
//  AppDelegate.m
//  WSShareManager
//
//  Created by wangzhen on 16/9/3.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "MainTableViewController.h"

@interface AppDelegate ()<WeiboSDKDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WeiboSDK registerApp:@"2045436852"];
    [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    [self loadRootView];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:nil];
    
    return YES;
}

- (void)loadRootView {
    
    MainTableViewController *vc = [[MainTableViewController alloc] init];
    vc.title = @"分享测试";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            NSLog(@"accessToken: %@", accessToken);
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            NSLog(@"UserID: %@", userID);
        }
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([TencentOAuth HandleOpenURL:url]) {
        return true;
    }else if ([WeiboSDK handleOpenURL:url delegate:self]){
        return true;
    }

    return false;
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

@end
