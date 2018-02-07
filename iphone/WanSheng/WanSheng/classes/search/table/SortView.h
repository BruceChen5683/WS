//
//  SortView.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftTableViewCell.h"
#import "CatagoryModel.h"
#import "RightCollectionViewCell.h"
#import "CatagoryRightGoodsView.h"

@interface SortView : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) NSMutableArray *rightDataSource;

//left表格
@property(nonatomic, weak) IBOutlet UITableView *leftTable;
@property(nonatomic, weak) IBOutlet UICollectionView *rightCollection;
@property(nonatomic, weak) IBOutlet CatagoryRightGoodsView *goodview;

@property(nonatomic, assign) NSInteger selectIndex;

@property(copy,nonatomic) void(^chooseKindBlock)(CatagoryModel *leftM,CatagoryModel *m);

@property(copy,nonatomic) void(^sortviewBackBtnBlock)(void);

@property(copy,nonatomic) void(^collectionCellCLickBlock)(BuildingDetailModel *m);

@property(nonatomic, strong) CatagoryModel *recordLeft;
@property(nonatomic, strong) CatagoryModel *recordRight;

@property(nonatomic) BOOL hasQB;

- (void)reloadContents;

@end
