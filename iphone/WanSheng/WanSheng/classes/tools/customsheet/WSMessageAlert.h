//
//  WSMessageAlert.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface WSMessageAlert : NSObject

+ (void)showMessage:(NSString *)msg;

+ (MBProgressHUD *)showMessage:(NSString *)msg nohide:(BOOL)nohide;

@end
