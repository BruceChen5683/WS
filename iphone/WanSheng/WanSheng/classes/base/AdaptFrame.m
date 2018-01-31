//
//  AdaptFrame.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "AdaptFrame.h"

@implementation AdaptFrame


+ (UIEdgeInsets)ws_safeAreaInset:(UIView *)view {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

+ (CGFloat)ws_top:(UIView *)view {
    return [AdaptFrame ws_safeAreaInset:view].top;
}

+ (CGFloat)ws_bottom:(UIView *)view {
    return [AdaptFrame ws_safeAreaInset:view].bottom;
}


@end
