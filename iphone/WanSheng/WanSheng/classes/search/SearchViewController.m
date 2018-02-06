//
//  SearchViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SearchViewController.h"
#import "HistoryTableViewCell.h"
#import "UIColor+JGHexColor.h"
#import "SearchResultView.h"
#import "HotelDetailViewController.h"
#import "AFHttpUtil.h"
#import "NSObject+SBJson.h"
#import "OpenInfo.h"
#define DataStore @"dataStore"

@interface SearchViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;

@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak,nonatomic) IBOutlet UITableView *historytable;
@property (strong, nonatomic) NSArray *historyDataSource;
@property (weak, nonatomic) IBOutlet SearchResultView *searchView;

//搜索的结果
@property (strong, nonatomic) NSMutableArray *searchedResultArray;

@property(strong, nonatomic) CatagoryModel *filterModel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.searchView.hidden = YES;

    __weak typeof(self)weakSelf = self;
    self.searchView.cellClickBlock = ^(BuildingDetailModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        HotelDetailViewController *hotCtl = [[HotelDetailViewController alloc] init];
        hotCtl.buildModel = m;
        [strongSelf.navigationController pushViewController:hotCtl animated:YES];
        
    };
    
    self.searchView.colectioncellClickBlock = ^(BuildingDetailModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        HotelDetailViewController *hotCtl = [[HotelDetailViewController alloc] init];
        hotCtl.buildModel = m;
        [strongSelf.navigationController pushViewController:hotCtl animated:YES];
    };
    
    self.searchView.callSearchAgainBlock = ^(CatagoryModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.filterModel = m;
        [strongSelf searchListContent:strongSelf.searchView.sortRecordId page:1];

    };
    
    self.searchView.pullRefreshBlock = ^(NSNumber *sortID, NSInteger page){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf searchListContent:strongSelf.searchView.sortRecordId page:page];
    };
    
    //初始化
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 18, 18)];
    [v addSubview:img];
    img.image = [UIImage imageNamed:@"icon_home_search"];
    self.searchTxtField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTxtField.leftView = v;
    self.searchTxtField.delegate = self;
    
    self.historytable.delegate = self;
    self.historytable.dataSource = self;
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, ScreenWidth, 60);
    [btn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexCode:@"#f3001e"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(clickRemoveAllRecords) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottonV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    bottonV.backgroundColor = [UIColor clearColor];
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-15, 0.5)];
    sep.backgroundColor = [UIColor colorWithHexCode:@"#cccccc"];
    [bottonV addSubview:btn];
    [bottonV addSubview:sep];

    self.historytable.tableFooterView = bottonV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  //  if (self.searchTxtField.text.length == 0) {
        //pop 搜索页面
    self.historyView.hidden = NO;
    self.searchView.hidden = YES;
    [self refreshHistory];
  //  }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTxtField resignFirstResponder];
    self.historyView.hidden = YES;

    return YES;
}

#pragma mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyDataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellId];
    cell.textLabel.text = self.historyDataSource[indexPath.row];
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchTxtField.text = self.historyDataSource[indexPath.row];
    
    if (self.searchView) {
        self.searchView.sortView.recordLeft = nil;
        self.searchView.sortView.recordRight = nil;
        self.searchView.sortView.selectIndex = 0;
        self.filterModel = nil;
    }
    
    [self clickSearch:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self readFromLocal].count > 0) {
        return 30;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self readFromLocal].count > 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        v.backgroundColor = [UIColor colorWithHexCode:@"#e9e9e9"];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.text = @"历史记录";
        [v addSubview:lbl];
        return v;
    }
    return [UIView new];
}

/*
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"历史记录"];
}
*/
#pragma mark -lazy load

- (NSArray *)historyDataSource {
    if (!_historyDataSource) {
        _historyDataSource = [self readFromLocal];
    }
    return _historyDataSource;
}

- (NSMutableArray *)searchedResultArray {
    if (!_searchedResultArray) {
        _searchedResultArray = [NSMutableArray array];
    }
    return _searchedResultArray;
}

#pragma mark -refresh

- (void)refreshHistory {
    self.historyDataSource = [self readFromLocal];
    if (self.historyDataSource.count == 0) {
        self.historytable.hidden = YES;
    } else {
        self.historytable.hidden = NO;
    }
    self.searchView.hidden = YES;
    [self.historytable reloadData];
}

- (void)refreshSearch {
    self.searchView.hidden = NO;
    self.historyView.hidden = YES;
    self.searchView.dataSource = self.searchedResultArray;
    [self.searchView.tb reloadData];
}

#pragma mark -简易版的数据库存储


#pragma mark - 触发事件

- (void)addToLocal:(NSString *)str {
    NSArray *result = [self readFromLocal];
    NSMutableArray *arr = [NSMutableArray array];
    if (result.count > 0) {
        [arr addObjectsFromArray:result];
    }
    BOOL find = NO;
    for (NSString *tmp in result) {
        if ([tmp isEqualToString:str]) {
            find = YES;
        }
    }
    if (!find) {
        [arr addObject:str];
        NSUserDefaults *userStandard = [NSUserDefaults standardUserDefaults];
        [userStandard setValue:arr forKey:DataStore];
        [userStandard synchronize];
    }
}

- (void)clickRemoveAllRecords {
    NSUserDefaults *userStandard = [NSUserDefaults standardUserDefaults];
    [userStandard removeObjectForKey:DataStore];
    [userStandard synchronize];
    [self refreshHistory];
}

- (NSArray *)readFromLocal {
    NSUserDefaults *userStandard = [NSUserDefaults standardUserDefaults];
    NSArray *result = [userStandard valueForKey:DataStore];
    return result;
}

- (IBAction)clickSearch:(id)sender {
    if (self.searchTxtField.text.length > 0) {
        [self addToLocal:self.searchTxtField.text];
        [self refreshHistory];
    }
    [self searchListContent:@(0) page:1];
}


- (void)searchListContent:(NSNumber *)sortID  page:(NSInteger)page {
    // begin search
    [self.searchTxtField resignFirstResponder];
    self.searchView.choosedIndex = -1;
    //获取数据
    ///api/merchant/query 搜索
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[NSString stringWithFormat:@"%@",[OpenInfo choosedId]] forKey:@"region"];
    [params setValue:self.searchTxtField.text forKey:@"queryText"];
    [params setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"pageNo"];

    //需要加种类筛选 TODO
    if (self.filterModel) {
        [params setValue:[NSString stringWithFormat:@"%@",self.filterModel.cID] forKey:@"category"];
    }
    
    CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:@"merchant/query"] params:params];
    __weak typeof(self) weakSelf = self;
    
    [AFHttpUtil doPostWithUrl:model callback:^(BOOL isSuccessed, id result) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (isSuccessed) {
            NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [jsonStr JSONValue];
            if (page == 1) {
                [strongSelf.searchedResultArray removeAllObjects];
            }
            PPLog(@"%@ response:%@",model.description,dic.description);
            
            if ([dic[@"errcode"] integerValue] == 0) {
                NSArray *data = dic[@"data"];
                for (NSDictionary *tmp in data) {
                    BuildingDetailModel *m = [[BuildingDetailModel alloc] init];
                    [m setValuesForKeysWithDictionary:tmp];
                    [strongSelf.searchedResultArray addObject:m];
                }
                [strongSelf refreshSearch];
            } else {
                [WSMessageAlert showMessage:@"抱歉，没查询到相关数据"];
            }
        }else {
            [WSMessageAlert showMessage:@"查询失败"];
        }
    }];

}


@end
