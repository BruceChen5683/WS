//
//  CatagoryRightGoodsView.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "CatagoryRightGoodsView.h"
#import "XLRefresh.h"
#import "OpenInfo.h"

@implementation CatagoryRightGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    currentPage = 1;
    
    self.collection.xl_header = [XLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMethod)];
    self.collection.xl_footer = [XLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMethod)];
    
}

- (IBAction)doBack:(id)sender {
    if (self.backBtnBlock) {
        self.backBtnBlock();
    }
}


#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotelDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    RightHotelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RightCollectionCellID forIndexPath:indexPath];
    BuildingDetailModel *m = self.hotelDataSource[indexPath.row];
    cell.nameLbl.text = m.name;
    cell.phoneLbl.text = m.phone;
    [cell.imgV downImageWithUrl:[m logoUrl]];
    cell.addressLbl.text = m.address;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BuildingDetailModel *m = self.hotelDataSource[indexPath.row];

    if (self.clickHotelBlock) {
        self.clickHotelBlock(m);
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((ScreenWidth-110)/2.0,210);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - lazy load

- (NSMutableArray *)hotelDataSource {
    if (!_hotelDataSource) {
        _hotelDataSource = [NSMutableArray array];
 
    }
    return _hotelDataSource;
}


#pragma mark -
#pragma mark 刷新/加载方法
-(void)refreshMethod{
    //方便测试延时两秒后执行隐藏操作
    currentPage = 1;
    [self reqSellerList:self.catagoryId page:currentPage];
    /*
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.collection.xl_header endRefreshing];
    });
     */
}

-(void)loadMoreMethod{
    //方便测试延时两秒后执行隐藏操作
    currentPage = currentPage + 1;
    [self reqSellerList:self.catagoryId page:currentPage];
/*
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.collection.xl_footer endRefreshing];
    });
 */
}


#pragma mark - request

- (void)reqSellerList:(NSNumber *)itemId page:(long)page{
    // api/merchant/getListByCategory/17/1/110101 该成这个 商户列表
    ///api/merchant/getListByCategory/17/1/110101/1  最后这个1就是按浏览量排序 如果不用这个排序就写0
    NSString *urlInterface = [OpenInfo ItsCity:[OpenInfo choosedId]]? @"merchant/getLists":@"merchant/getListByCategory";
    NSString *str = [NSString stringWithFormat:@"%@%@/%@/%ld/%@/0",BaseUrl,urlInterface,itemId,page,[OpenInfo choosedId]];
    CTURLModel *model = [CTURLModel initWithUrl:str params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.collection.xl_header endRefreshing];
        [strongSelf.collection.xl_footer endRefreshing];
        NSDictionary *result = (NSDictionary *)responseObject;
        NSNumber *errorCode = result[@"errcode"];
        if (page == 1) {
            [self.hotelDataSource removeAllObjects];
        }
        
        if (errorCode.integerValue == 0) {
            //success
            NSArray *data = result[@"data"];
            for (NSDictionary *tmp in data) {
                BuildingDetailModel *m = [[BuildingDetailModel alloc] init];
                [m setValuesForKeysWithDictionary:tmp];
                [strongSelf.hotelDataSource addObject:m];
            }
            
            [strongSelf.collection reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)showContent {
    
    [self refreshMethod];
}

@end
