//
//  MyFootsViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "MyFootsViewController.h"
#import "MyFootTableViewCell.h"
#import "OpenInfo.h"
#import "HotelDetailViewController.h"

@interface MyFootsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak) IBOutlet UITableView *contentTable;

@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation MyFootsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    self.contentTable.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSource = [OpenInfo shared].scannedArray;
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
    
    MyFootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FootCelllID];
    NSDictionary *tmp = self.dataSource[indexPath.row];
    cell.textLabel.text = tmp[ITEMNameKEY];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *tmp = self.dataSource[indexPath.row];
        [[OpenInfo shared] deleteDicInScanned:tmp];
        self.dataSource = [OpenInfo shared].scannedArray;
        [tableView reloadData];
    }
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
