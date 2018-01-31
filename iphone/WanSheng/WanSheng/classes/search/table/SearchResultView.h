//
//  SearchResultView.h
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItemModel.h"
#import "SearchResultTableViewCell.h"
#import "SortView.h"
#import "SearchDropView.h"

@interface SearchResultView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(strong, nonatomic) NSMutableArray *dataSource;

@property(strong, nonatomic) NSNumber *sortRecordId;


@property(weak, nonatomic) IBOutlet UITableView *tb;

//分类
@property(weak, nonatomic) IBOutlet UIButton *catagoryBtn;
//排序
@property(weak, nonatomic) IBOutlet UIButton *sortBtn;

/// -1 谁都没选  1 代表选的 分类  2 代表选的排序
@property(nonatomic, assign) NSInteger choosedIndex;

@property(nonatomic, weak) IBOutlet SortView *sortView;

@property(nonatomic, weak) IBOutlet NSLayoutConstraint *hLayoutConstraint;

@property(nonatomic, weak) IBOutlet SearchDropView *dropView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property(copy, nonatomic) void(^cellClickBlock)(BuildingDetailModel *m);

@property(copy, nonatomic) void(^colectioncellClickBlock)(BuildingDetailModel *m);

@property(copy, nonatomic) void(^callSearchAgainBlock)(CatagoryModel *m);

@property(copy, nonatomic) void(^pullRefreshBlock)(NSNumber *sortID, NSInteger page);


@end
