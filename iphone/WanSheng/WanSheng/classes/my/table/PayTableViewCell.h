//
//  PayTableViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/23.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MethodCellID @"methodcell"

@interface PayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@property(assign, nonatomic) BOOL select;

@end
