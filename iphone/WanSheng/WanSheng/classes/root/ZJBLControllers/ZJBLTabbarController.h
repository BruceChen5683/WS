//
//  ZJBLTabbarController.h
//  ZJBL-GL
//
//  Created by 郭军 on 2017/5/31.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSingleton.h"

@interface ZJBLTabbarController : UITabBarController

HMSingletonH(ZJBLTabbarController)

//隐藏tabBar
- (void)hiddenCusTabbar;

//显示tabBar
- (void)showCusTabbar;

- (void)goToSelectCtrlWithTitle:(NSString *)name Index:(NSUInteger)Index;

@end
