//
//  AppDelegate.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJBLTabbarController.h"
#import <IQKeyboardManager.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <SDWebImageDownloader.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "SuccessViewController.h"

@interface AppDelegate ()<WXApiDelegate>


@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [ZJBLTabbarController sharedZJBLTabbarController];
    
    [self.window makeKeyAndVisible];
    
    [self sdRegister];
    
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    //Mag1QmV2Gwt9rFKVj3aV4I3zRsifb7IB   ws  com.wans.iosapp
    //hTlvChEo54AZiTXf0iutnUv9qRbtziLK   dr  com.trip8080.Push
    BOOL ret = [mapManager start:@"Mag1QmV2Gwt9rFKVj3aV4I3zRsifb7IB" generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图启动失败");
    }
    
    [WXApi registerApp:@"wx4868b35061f87885"];

    [IQKeyboardManager sharedManager].enable = YES;
    
    return YES;
}

-  (void)sdRegister {
    NSString *userAgent = @"";
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        [[SDWebImageDownloader sharedDownloader] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([@"wx3e018b61a6a0c951" isEqualToString:[url scheme]]) {
        //微信
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([@"wx3e018b61a6a0c951" isEqualToString:[url scheme]]) {
        //微信
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        ///api/pay/toPay/4是获取orderInfo的接口 4是商户id
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //成功
                UINavigationController *navi = [[ZJBLTabbarController sharedZJBLTabbarController] childViewControllers][3];
                SuccessViewController *success = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"successctl"];
                [navi pushViewController:success animated:YES];
            }
            else {
                [WSMessageAlert showMessage:resultDic[@"memo"]];
            }
       //     NSLog(@"result = %@",resultDic);
        }];
     
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([@"wx3e018b61a6a0c951" isEqualToString:[url scheme]]) {
        //微信
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void) onResp:(BaseResp*)resp {
    if (resp.errCode == 0) {
        NSLog(@"分享成功");
    } else if (resp.errCode == -2) {
        NSLog(@"分享取消");
    } else {
        NSLog(@"分享失败");
    }
}


@end
