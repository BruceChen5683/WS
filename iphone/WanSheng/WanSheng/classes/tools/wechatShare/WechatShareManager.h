//
//  WechatShareManager.h
//  Test-weixin
//
//  Created by chenyun on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApiObject.h>
#import <WXApi.h>

@interface WechatShareManager : NSObject

/** 分享文字 */
- (void)shareText:(NSString *)content toScene:(int)scene;

/** 分享图片 */
- (void)shareImage:(UIImage *)image toScene:(int)scene;

/** 分享网页 */
- (void)shareUrl:(NSString *)url title:(NSString *)title description:(NSString *)description image:(UIImage *)image toScene:(int)scene;

@end
