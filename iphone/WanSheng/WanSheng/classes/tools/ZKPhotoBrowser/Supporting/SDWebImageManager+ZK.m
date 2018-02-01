//
//  SDWebImageManager+ZK.m
//  FingerNews
//
//  Created by ZK on 13-9-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SDWebImageManager+ZK.h"

@implementation SDWebImageManager (ZK)
+ (void)downloadWithURL:(NSURL *)url
{
    [[self sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
    }];

    
}
@end
