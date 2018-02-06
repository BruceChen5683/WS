//
//  KindsViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "KindsViewController.h"
#import "LeftTableViewCell.h"
#import "RightCollectionViewCell.h"
#import "YFAnimationCostum.h"
#import "CatagoryModel.h"
#import "RightHotelCollectionViewCell.h"
#import "CatagoryRightGoodsView.h"
#import "HotelDetailViewController.h"
#import "OpenInfo.h"

@interface KindsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) NSMutableArray *rightDataSource;

//left表格
@property(nonatomic, weak) IBOutlet UITableView *leftTable;

//右上角 图片
@property(nonatomic, weak) IBOutlet UIImageView *imgV;

//右下表格
@property(nonatomic, weak) IBOutlet UICollectionView *rightCollection;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UIView *goodsListView;

@property(nonatomic, assign) NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property (weak, nonatomic) IBOutlet CatagoryRightGoodsView *catagoryGoodsView;

@end

@implementation KindsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分类";
    
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
    
    self.catagoryGoodsView.backBtnBlock = ^(void){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf clickback:nil];
    };
    
    
    self.catagoryGoodsView.clickHotelBlock = ^(BuildingDetailModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        HotelDetailViewController *hotCtl = [[HotelDetailViewController alloc] init];
        hotCtl.buildModel = m;
        [strongSelf.navigationController pushViewController:hotCtl animated:YES];
        
    };
    
    [self loadReqs];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
  //  CollectionCategoryModel *model = self.dataSource[indexPath.row];
   // cell.name.text = model.name;
    CatagoryModel * m = self.dataSource[indexPath.row];
    cell.name.text = m.cName;
    [cell bechoosed:indexPath.row == self.selectIndex];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndex != indexPath.row) {
        [self clickback:nil];
    }
    self.selectIndex = indexPath.row;
    [self.leftTable reloadData];
    // http://stackoverflow.com/questions/22100227/scroll-uicollectionview-to-section-header-view
    // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
   // [self scrollToTopOfSection:_selectIndex animated:YES];
    
    //    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
   // [self.leftTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
    //                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    CatagoryModel * m = self.dataSource[self.selectIndex];
    [self loadRightContents:m.cID.integerValue];

    
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
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

   // CatagoryModel * leftM = self.dataSource[self.selectIndex];

    CatagoryModel *m = self.rightDataSource[indexPath.row];

    self.catagoryGoodsView.catagoryId = m.cID;
    [self.catagoryGoodsView showContent];

    self.catagoryGoodsView.titleLbl.text = m.cName;

    self.rightConstraint.constant  = 400;
    [self.contentView layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.rightConstraint.constant = 5;
        [self.contentView layoutIfNeeded];
    }];

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

//返回
- (IBAction)clickback:(id)sender {
   // [YFAnimationCostum animationPushLeft:self.rightCollection duration:1.0];
  //  [self.contentView exchangeSubviewAtIndex:2 withSubviewAtIndex:3];
    
    [self.contentView layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.rightConstraint.constant = 400;
        [self.contentView layoutIfNeeded];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            [self loadRightContents:m.cID.integerValue];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)loadRightContents:(NSInteger)listid {
    NSString *str = [NSString stringWithFormat:@"%@category/list/%ld",BaseUrl,listid];
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
            CatagoryModel *tmpLeft = self.dataSource[listid];
            totalM.cName = [NSString stringWithFormat:@"所有%@",tmpLeft.cName];
            totalM.cID = [NSNumber numberWithInteger:listid];
            [self.rightDataSource addObject:totalM];
            ///// done
            for (NSDictionary *dic in data) {
                [self.rightDataSource addObject:[[CatagoryModel alloc] initWithDic:dic]];
            }
            [self.rightCollection reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 跳转

- (void)gotoLeftByName:(NSString *)name {
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.dataSource.count > 0) {
            for (NSInteger i = 0; i < strongSelf.dataSource.count; i++) {
                CatagoryModel *m = strongSelf.dataSource[i];
                if ([m.cName isEqualToString:name]) {
                    //选中
                    if (strongSelf.selectIndex != i) {
                        [strongSelf clickback:nil];
                    }
                    strongSelf.selectIndex = i;
                    [strongSelf.leftTable reloadData];
                    [strongSelf loadRightContents:m.cID.integerValue];
                    break;
                }
            }
       
        }
    });
    
}

@end
