//
//  AdaptFrame.h
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdaptFrame : NSObject


+ (UIEdgeInsets)ws_safeAreaInset:(UIView *)view;

+ (CGFloat)ws_top:(UIView *)view;

+ (CGFloat)ws_bottom:(UIView *)view;

@end
