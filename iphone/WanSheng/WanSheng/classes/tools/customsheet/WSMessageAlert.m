//
//  WSMessageAlert.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "WSMessageAlert.h"

@implementation WSMessageAlert

+ (void)showMessage:(NSString *)msg {
    if (msg.length == 0) {
        return;
    }
    NSArray *winArr = [[UIApplication sharedApplication] windows];
    UIWindow *window;
    if (winArr.count > 0) {
        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

+ (MBProgressHUD *)showMessage:(NSString *)msg nohide:(BOOL)nohide{
    if (msg.length == 0) {
        return nil;
    }
    NSArray *winArr = [[UIApplication sharedApplication] windows];
    UIWindow *window;
    if (winArr.count > 0) {
        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
    return hud;
}

@end
