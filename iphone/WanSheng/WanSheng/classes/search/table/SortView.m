//
//  SortView.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SortView.h"
#import "UIColor+JGHexColor.h"
@implementation SortView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialLoad];
    
    __weak typeof(self) weakSelf = self;
    self.goodview.clickHotelBlock = ^(BuildingDetailModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.collectionCellCLickBlock) {
            strongSelf.collectionCellCLickBlock(m);
        }
    };
}

- (void)initialLoad {
    self.selectIndex = 0;
    
    //setting tableview
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.tableFooterView = [UIView new];
    self.leftTable.rowHeight = 50;
    self.leftTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.leftTable.showsVerticalScrollIndicator = NO;
    self.leftTable.separatorColor = [UIColor clearColor];
    [self.leftTable registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    
    
    //setting collectionview
    self.rightCollection.dataSource = self;
    self.rightCollection.delegate = self;
    self.rightCollection.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.rightCollection.showsVerticalScrollIndicator = NO;
    self.rightCollection.showsHorizontalScrollIndicator = NO;
    [self.rightCollection setBackgroundColor:[UIColor clearColor]];
    
    __weak typeof(self) weakSelf = self;
    self.goodview.backBtnBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.sortviewBackBtnBlock) {
            self.sortviewBackBtnBlock();
        }
    };
    
    [self loadReqs];
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];

    CatagoryModel * m = self.dataSource[indexPath.row];
    cell.name.text = m.cName;
    [cell bechoosed:indexPath.row == self.selectIndex];
    if (self.recordLeft) {
        if (self.recordLeft.cID.integerValue == m.cID.integerValue) {
            [cell bechoosed:YES];
            self.selectIndex = indexPath.row;
        }
    }
    else {
        if (indexPath.row == self.selectIndex) {
            self.recordLeft = m;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndex != indexPath.row) {
        if (self.sortviewBackBtnBlock) {
            self.sortviewBackBtnBlock();
        }
    }
    
    self.selectIndex = indexPath.row;
    CatagoryModel * m = self.dataSource[indexPath.row];
    self.recordLeft = m;
    [self.leftTable reloadData];

    
    [self loadRightContents:self.recordLeft.cID];
    
    
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rightDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
     SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
     cell.model = model;
     */
    RightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    CatagoryModel *m = self.rightDataSource[indexPath.row];
    cell.nameLbl.text = m.cName;
    [cell.nameLbl setTextColor:[UIColor colorWithHexCode:@"#333333"]];

    if (self.recordRight) {
        if (m.cID.integerValue == self.recordRight.cID.integerValue) {
            [cell.nameLbl setTextColor:[UIColor redColor]];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.chooseKindBlock) {
        
        CatagoryModel * leftM = self.dataSource[self.selectIndex];
        CatagoryModel *rm = self.rightDataSource[indexPath.row];
        if (self.recordRight) {
            if (self.recordRight.cID.integerValue == rm.cID.integerValue) {
                self.recordRight = nil;
                rm = nil;
            }
            else {
                self.recordRight = rm;
            }
        }
        else {
            self.recordRight = rm;
        }
            
        self.chooseKindBlock(leftM,rm);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((ScreenWidth-110)/2.0,50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - lazy load

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)rightDataSource {
    if (!_rightDataSource) {
        _rightDataSource = [NSMutableArray array];
    }
    return _rightDataSource;
}

#pragma mark - request

- (void)loadReqs {
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES].label.text
    CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:@"category/list/0"] params:nil];
    [WSBaseRequest GET:model success:^(id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        NSNumber *errorCode = result[@"errcode"];
        if (errorCode.integerValue == 0) {
            //success
            NSArray *data = result[@"data"];
            [self.dataSource removeAllObjects];
            for (NSDictionary *dic in data) {
                [self.dataSource addObject:[[CatagoryModel alloc] initWithDic:dic]];
            }
            [self.leftTable reloadData];
            CatagoryModel * m = self.dataSource[self.selectIndex];
            [self loadRightContents:m.cID];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)loadRightContents:(NSNumber *)rowItemID {
    NSString *str = [NSString stringWithFormat:@"%@category/list/%@",BaseUrl,rowItemID];
    CTURLModel *model = [CTURLModel initWithUrl:str params:nil];
    [WSBaseRequest GET:model success:^(id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        NSNumber *errorCode = result[@"errcode"];
        if (errorCode.integerValue == 0) {
            //success
            NSArray *data = result[@"data"];
            [self.rightDataSource removeAllObjects];
            //添加全部
            CatagoryModel *totalM = [[CatagoryModel alloc] init];
            CatagoryModel *tmpLeft = self.dataSource[rowItemID.integerValue];
            totalM.cName = [NSString stringWithFormat:@"所有%@",tmpLeft.cName];
            totalM.cID = rowItemID;
            [self.rightDataSource addObject:totalM];
            
            for (NSDictionary *dic in data) {
                [self.rightDataSource addObject:[[CatagoryModel alloc] initWithDic:dic]];
            }
            [self.rightCollection reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
