//
//  MyShoucangViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "MyShoucangViewController.h"
#import "SCTableViewCell.h"
#import "OpenInfo.h"
#import "HotelDetailViewController.h"

@interface MyShoucangViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UITableView *contentTable;

@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation MyShoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [OpenInfo shared].collectArray;
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    self.contentTable.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSource = [OpenInfo shared].collectArray;
    [self.contentTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SCellID];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[ITEMNameKEY];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *tmp = self.dataSource[indexPath.row];
    HotelDetailViewController *detail = [[HotelDetailViewController alloc] init];
    BuildingDetailModel *model = [[BuildingDetailModel alloc] init];
    model.cID = [NSNumber numberWithInteger:[tmp[ITEMIDKEY] integerValue]];
    model.name = tmp[ITEMNameKEY];
    detail.buildModel = model;
    [self.navigationController pushViewController: detail animated:YES];
    
}



@end
