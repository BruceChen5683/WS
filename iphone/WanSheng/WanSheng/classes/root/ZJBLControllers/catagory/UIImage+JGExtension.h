//
//  UIImage+JGExtension.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JGExtension)

/**
 *  图片圆角处理
 *
 *  @param image 图片名字
 *
 *  @return 圆角图片
 */
+ (UIImage *)circleImage:(NSString *)image;

/**
 *  vImage模糊图片
 *
 *  @param image 原始图片
 *  @param blur  模糊数值(0-1)
 *
 *  @return 重新绘制的新图片
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;




@end
