//
//  ActiveImageView.m
//  BaseLibrary
//
//  Created by Potter on 14-2-20.
//  Copyright (c) 2014年 Potter. All rights reserved.
//

#import "ActiveImageView.h"
#import "UIView+SU.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ActiveImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI
{
    //显示的图片
    _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImage];
}


- (void)dealloc
{
    [_iconImage removeFromSuperview];
    _iconImage = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImage.frame = CGRectMake(0, 0, self.w, self.h);
}

- (void)setImage:(UIImage *)image
{
    if (image == nil) {
 //       _iconImage.image = nil;
    }
    else {
        _iconImage.alpha = 0;
        _iconImage.image = image;

        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.2];
        _iconImage.alpha = 1;
        [UIView commitAnimations];
    }
}

- (void)setDefaultImgName:(NSString *)defaultImgName {
    _defaultImgName = defaultImgName;
    if (!self.iconImage.image) {
        self.iconImage.image  = [UIImage imageNamed:defaultImgName];
    }
}

- (void)setImageWithUrl:(NSString *)imageUrl
{
    [self downImageWithUrl:imageUrl];
}

- (void)downImageWithUrl:(NSString *)imageUrl
{
    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
    self.defaultImgName = @"listDefault";
    //使用默认图片，而且用block 在完成后做一些事情
    NSURL *_tmpUrl = [imageUrl isKindOfClass:[NSString class]]? [NSURL URLWithString:imageUrl]:nil;
    [_iconImage sd_setImageWithURL:_tmpUrl placeholderImage:[UIImage imageNamed:self.defaultImgName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}

- (void)addSettings
{
//    _activityView.hidden = YES;
}


@end
