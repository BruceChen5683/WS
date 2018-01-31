//
//  ContentTableViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentCellModel.h"

#define TbCellId    @"mycell"
#define TJCellId    @"mytuijcell"


@interface ContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *despLbl;

- (void)loadContent:(ContentCellModel *)m;

@end
