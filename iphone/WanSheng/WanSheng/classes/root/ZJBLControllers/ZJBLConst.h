//
//  ZJBLConst.h
//  ZJBL-GL
//
//  Created by 郭军 on 2017/6/1.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+JGColor.h"
#import "UIColor+JGHexColor.h"
#import "UIView+JGExtension.h"
/** 刷新时 每次 加载 数据量 */
UIKIT_EXTERN CGFloat const JGRefreshCount;

/** 登录回首页 通知名称 */
UIKIT_EXTERN NSString * const JGLoginBackCustomerVCNotification;

//尺寸
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width


//设备判断
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kSCREEN_MAX_LENGTH (MAX(kDeviceWidth, kDeviceHight))
#define kSCREEN_MIN_LENGTH (MIN(kDeviceWidth, kDeviceHight))

//主色调
#define JGMainColor [UIColor colorWithHexCode:@"#36b4be"]

//颜色定义
#define JGRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//通知
#define JGNotification [NSNotificationCenter defaultCenter]

#define JGFont(size) [UIFont systemFontOfSize:size]

#define JGBoldFont(size) [UIFont boldSystemFontOfSize:size]


