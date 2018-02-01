//
//  SDWebImageManager+ZK.h
//  FingerNews
//
//  Created by ZK on 13-9-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDWebImageManager (ZK)
+ (void)downloadWithURL:(NSURL *)url;
@end
