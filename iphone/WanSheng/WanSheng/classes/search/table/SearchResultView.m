//
//  SearchResultView.m
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SearchResultView.h"
#import "UIColor+JGHexColor.h"
#import "XLRefresh.h" //分页
#import "OpenInfo.h"

@implementation SearchResultView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tb.delegate = self;
    self.tb.dataSource = self;
    self.tb.tableFooterView = [UIView new];
    
    self.hLayoutConstraint.constant = 0;
    
    __weak typeof(self) weakSelf = self;

    self.sortView.chooseKindBlock = ^(CatagoryModel *leftM, CatagoryModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (strongSelf.callSearchAgainBlock) {
            strongSelf.callSearchAgainBlock(m);
        }
 
    };
    
    self.sortView.sortviewBackBtnBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            strongSelf.rightConstraint.constant = 400;
            [strongSelf layoutIfNeeded];
        }];
    };
    
    self.sortView.collectionCellCLickBlock = ^(BuildingDetailModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (strongSelf.colectioncellClickBlock) {
            strongSelf.colectioncellClickBlock(m);
        }
    };
    
    self.sortRecordId = @(0);
    
    self.dropView.cellClick = ^(NSInteger row) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            strongSelf.hLayoutConstraint.constant = 0;
            [strongSelf layoutIfNeeded];
        }];
        if (row == 2) {
            strongSelf.sortRecordId = @(1);
        } else {
            strongSelf.sortRecordId = @(0);
        }
        [strongSelf refreshMethod];
    };
    
    page = 1;
   self.tb.xl_header = [XLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMethod)];
   self.tb.xl_footer = [XLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMethod)];
}

//分类
- (IBAction)clickSortBtn:(id)sender {
    if (self.choosedIndex == 1) {
        self.choosedIndex = -1;
    }
    else
        self.choosedIndex = 1;
}

//排序
- (IBAction)clickPQBtn:(id)sender {
    if (self.choosedIndex == 2) {
        self.choosedIndex = -1;
    }
    else
        self.choosedIndex = 2;
}

#pragma mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchDetailCellID];
    BuildingDetailModel *m = self.dataSource[indexPath.row];
    [cell loadContentsByM:m];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BuildingDetailModel *m = self.dataSource[indexPath.row];

    if (self.cellClickBlock) {
        self.cellClickBlock(m);
    }

}

#pragma mark - set & get

- (void)setChoosedIndex:(NSInteger)choosedIndex {

    _choosedIndex = choosedIndex;
    
    self.sortView.hasQB = YES;
    [self.sortView reloadContents];
    
    if (_choosedIndex == 1) {
        [self.catagoryBtn setTitleColor:[UIColor colorWithHexCode:@"#d93d45"] forState:UIControlStateNormal];
        [self.sortBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.sortView.rightCollection reloadData];
        self.sortView.hidden = NO;
        self.tb.hidden = YES;
        self.dropView.hidden = YES;

    }
    else if (_choosedIndex == 2) {
        [self.sortBtn setTitleColor:[UIColor colorWithHexCode:@"#d93d45"] forState:UIControlStateNormal];
        [self.catagoryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.sortView.hidden = YES;
        self.tb.hidden = NO;
        self.dropView.hidden = NO;
        self.hLayoutConstraint.constant  = 0;
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            self.hLayoutConstraint.constant = 132;
            [self.dropView.dropTB reloadData];
            [self layoutIfNeeded];
        }];
    }
    else {
        self.sortView.hidden = YES;
        self.tb.hidden = NO;
        self.dropView.hidden = YES;
        [self.sortBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.catagoryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark 刷新/加载方法
-(void)refreshMethod{
    //方便测试延时两秒后执行隐藏操作
    page = 1;
    if (self.pullRefreshBlock) {
        self.pullRefreshBlock(self.sortRecordId,page);
    }
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tb.xl_header endRefreshing];
    });
}

-(void)loadMoreMethod{
    //方便测试延时两秒后执行隐藏操作
    if (self.pullRefreshBlock) {
        page = page + 1;
        self.pullRefreshBlock(self.sortRecordId,page);
    }
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tb.xl_footer endRefreshing];
    });
}

@end
