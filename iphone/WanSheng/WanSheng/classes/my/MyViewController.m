//
//  MyViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "MyViewController.h"
#import "ContentTableViewCell.h"

#import "AboutWSViewController.h"
#import "LiveInViewController.h"
#import "ApplyViewController.h"
#import "ContactKFViewController.h"

#import "MyShoucangViewController.h"
#import "MyFootsViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UITableView *contentTable;

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.contentTable.tableFooterView = [[UIView alloc] init];
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TbCellId];
    ContentCellModel *m = self.dataSource[indexPath.row];
    [cell loadContent:m];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //入驻万商
        LiveInViewController *liveCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"rzctl"];
        [self.navigationController pushViewController:liveCtl animated:YES];
    }
    else if (indexPath.row == 1) {
        //申请成为地区代理
        ApplyViewController *appleCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"applyctl"];
        [self.navigationController pushViewController:appleCtl animated:YES];
    }
    else if (indexPath.row == 2) {
    //联系客服
        ContactKFViewController *contactCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"kfctl"];
        [self.navigationController pushViewController:contactCtl animated:YES];
    }
    else if (indexPath.row == 3) {
    //关于万商
        AboutWSViewController *aboutCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"aboutctl"];
        [self.navigationController pushViewController:aboutCtl animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        ContentCellModel *m1 = [[ContentCellModel alloc] initWithImgName:@"icon_my_money" title:@"入驻万商" desp:@"无门槛"];
        ContentCellModel *m2 = [[ContentCellModel alloc] initWithImgName:@"icon_my_apply" title:@"申请成为地区代理" desp:@"拥抱财富"];
        ContentCellModel *m3 = [[ContentCellModel alloc] initWithImgName:@"icon_my_service" title:@"联系客服" desp:@"用心服务"];
        ContentCellModel *m4 = [[ContentCellModel alloc] initWithImgName:@"icon_my_about" title:@"关于万商" desp:@"产品介绍"];
        [_dataSource addObject:m1];
        [_dataSource addObject:m2];
        [_dataSource addObject:m3];
        [_dataSource addObject:m4];
    }
    return _dataSource;
}
- (IBAction)clickStore:(id)sender {
    //点击收藏
    MyShoucangViewController *scCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"myscCtl"];
    [self.navigationController pushViewController:scCtl animated:YES];
}

- (IBAction)clickFoots:(id)sender {
    //点击足迹
    MyFootsViewController *fcCtl = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"myzjCtl"];
    [self.navigationController pushViewController:fcCtl animated:YES];
}

@end
