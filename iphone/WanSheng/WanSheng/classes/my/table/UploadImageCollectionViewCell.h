//
//  UploadImageCollectionViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UploadImageCellID @"uploadcell"

@interface UploadImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (strong, nonatomic) void(^deleteBlock)(UploadImageCollectionViewCell *cell);

@end
