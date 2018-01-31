//
//  WechatShareManager.m
//  Test-weixin
//
//  Created by chenyun on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WechatShareManager.h"

@implementation WechatShareManager

- (void)shareText:(NSString *)content toScene:(int)scene {
    if (![WXApi isWXAppInstalled]) {
        [self showAlert];
        return;
    }
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = content;
    req.bText = YES;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)shareImage:(UIImage *)image toScene:(int)scene {
    
    if (![WXApi isWXAppInstalled]) {
        [self showAlert];
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    // 缩略图
    [message setThumbImage:[self compressImage:image toByte:32*1000]];
    WXImageObject *object = [WXImageObject object];
    // 显示的真实图片
    object.imageData = UIImageJPEGRepresentation(image, 1.0);
    message.mediaObject = object;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = message;
    [WXApi sendReq:req];
    
}

- (void)shareUrl:(NSString *)url title:(NSString *)title description:(NSString *)description image:(UIImage *)image toScene:(int)scene {
    
    if (![WXApi isWXAppInstalled]) {
        [self showAlert];
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[self compressImage:image toByte:32*1000]];
    WXWebpageObject *webObject = [WXWebpageObject object];
    webObject.webpageUrl = url;
    message.mediaObject = webObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"请先安装微信" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }];
    [alert addAction:cancelAction];
    UIViewController *ctl = [self getCurrentVC];
    [ctl presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 限制图片大小32kb

- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
