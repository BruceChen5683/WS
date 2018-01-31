//
//  SearchResultTableViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveImageView.h"
#import "BuildingDetailModel.h"

#define SearchDetailCellID  @"searchresultcell"

@interface SearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet ActiveImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *goldImgView;

- (void)loadContentsByM:(BuildingDetailModel *)m;

@end
