//
//  ActiveImageView.h
//  BaseLibrary
//
//  Created by Potter on 14-2-20.
//  Copyright (c) 2014年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ActivityFinDelegate <NSObject>

@optional

- (void)activityViewDownLoadFinished;

@end

@interface ActiveImageView : UIView

@property (nonatomic,retain)UIImageView * iconImage;  //显示的图标

@property (nonatomic,retain) NSString *defaultImgName;

@property(nonatomic, weak) id <ActivityFinDelegate> finDelegate;

/**
 *	@brief	根据图片，来设置图片
 *
 *	@param 	image 	如果imagePath为nil，则显示下载等待样式
 */
- (void)setImage:(UIImage *)image;

//如果已经下载好了图片  使用这个
- (void)setImageWithUrl:(NSString *)imageUrl;

//如果没有下载好 用这个
- (void)downImageWithUrl:(NSString *)imageUrl;

- (void)addSettings;

@end
