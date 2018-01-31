//
//  RecommendViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "RecommendViewController.h"
#import "ContentTableViewCell.h"
#import "CtSheetView.h"
#import "LookMyRecommendsViewController.h"
#import "WechatShareManager.h"

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UIView *topView;

@property(nonatomic, weak) IBOutlet UITableView *contentTable;

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) WechatShareManager *wechatManager;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentTable.tableFooterView = [[UIView alloc] init];
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    
    if ([self.contentTable respondsToSelector:@selector(separatorInset)]) {
        self.contentTable.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.contentTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.contentTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[self imageResize :[UIImage imageNamed:@"bg_recommend"] andResizeTo:self.topView.frame.size]];

    //[self.contentTable reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
   // self.topView.backgroundColor = [UIColor colorWithPatternImage:[self imageResize :[UIImage imageNamed:@"bg_recommend"] andResizeTo:self.topView.frame.size]];

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
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TJCellId];
    ContentCellModel *m = self.dataSource[indexPath.row];
    [cell loadContent:m];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //
        //www.sz-ws.cn/join.html
        /*
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:@"www.sz-ws.cn/join.html"];
        [WSMessageAlert showMessage:@"分享链接复制成功"];
         */
       // return ;
        __weak typeof(self) weakSelf = self;
        CtSheetView * ctSheet = [[CtSheetView alloc] initWithMap:@{@"name":@"推  荐  人：",@"nameValue":@"请输入您的名称或称呼",@"number":@"手机号码：",@"numberValue":@"请输入您的手机号码",@"tips":@"好友入驻万商, \“推荐人\”填写你的手机号，您将得到佣金10元。",@"commitName":@"点击推荐"} clickBlock:^(NSString *name, NSString *phone) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.wechatManager shareUrl:@"www.sz-ws.cn/join.html" title:@"推荐好友加入万商" description:@"好友入驻万商, \“推荐人\”填写你的手机号，您将得到佣金10元。" image:[UIImage imageNamed:@"listDefault2.png"] toScene:(int)WXSceneSession];
        }];
        [self shareToView:ctSheet];
    }
    else if (indexPath.row == 1) {
        /*
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:@"www.sz-ws.cn/join.html"];
        [WSMessageAlert showMessage:@"分享链接复制成功"];
        */
      //  return ;
        __weak typeof(self) weakSelf = self;
        CtSheetView * ctSheet = [[CtSheetView alloc] initWithMap:@{@"name":@"推  荐  人：",@"nameValue":@"请输入您的名称或称呼",@"number":@"手机号码：",@"numberValue":@"请输入您的手机号码",@"tips":@"推荐好友成为万商代理，服务商家，创造财富",@"commitName":@"点击推荐"} clickBlock:^(NSString *name, NSString *phone) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.wechatManager shareUrl:@"www.sz-ws.cn/join.html" title:@"推荐好友加入代理" description:@"推荐好友成为万商代理，服务商家，创造财富" image:[UIImage imageNamed:@"listDefault2.png"] toScene:(int)WXSceneSession];
        }];
        [self shareToView:ctSheet];
    }
    else if (indexPath.row == 2) {
        LookMyRecommendsViewController *lookctl = [[UIStoryboard storyboardWithName:@"RecommendStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"lookmyrecommendCtl"];
        [self.navigationController pushViewController:lookctl animated:YES];
    }
}

- (void)shareToView:(CtSheetView *)ctSheet {
    ctSheet.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ctSheet];
    ctSheet.backgroundColor = [UIColor clearColor];
    ctSheet.containtView.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.height- 180 - 69 - [AdaptFrame ws_bottom:self.view], [UIScreen mainScreen].bounds.size.width, 180);
    [UIView animateWithDuration:0.5 animations:^{
        ctSheet.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        ContentCellModel *m1 = [[ContentCellModel alloc] initWithImgName:@"icon_recommend_enter" title:@"推荐好友入驻万商" desp:@"推荐人得佣金"];
        ContentCellModel *m2 = [[ContentCellModel alloc] initWithImgName:@"icon_recommend_friend" title:@"推荐好友加入代理" desp:@"携手万商，拥抱财富"];
        ContentCellModel *m3 = [[ContentCellModel alloc] initWithImgName:@"icon_recommend_money" title:@"查看我的推荐" desp:@""];
        [_dataSource addObject:m1];
        [_dataSource addObject:m2];
        [_dataSource addObject:m3];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - lazy load

- (WechatShareManager *)wechatManager {
    if (!_wechatManager) {
        _wechatManager = [[WechatShareManager alloc] init];
    }
    return _wechatManager;
}


@end
