//
//  ZJBLTabbarCenterButton.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/5/8.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLTabbarCenterButton.h"
#import "ZJBLConst.h"

#define kImageRatio 0.8

@implementation ZJBLTabbarCenterButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.contentMode = UIViewContentModeBottom;
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

#pragma mark 返回按钮内部titlelabel的边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height*kImageRatio-5, contentRect.size.width, contentRect.size.height-contentRect.size.height*kImageRatio);
}

#pragma mark 返回按钮内部UIImage的边框
-(CGRect) imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*kImageRatio);
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat X = (self.width - 34) /2.0;
    
    
    self.imageView.frame = CGRectMake(X, 1.5, 36, 36);
    self.titleLabel.frame = CGRectMake(0, 37.5, self.width, self.height - self.imageView.bottom + 5);
    
    
}


@end
