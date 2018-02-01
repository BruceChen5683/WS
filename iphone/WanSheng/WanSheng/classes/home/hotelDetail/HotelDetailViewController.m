//
//  HotelDetailViewController.m
//  PopView
//
//  Created by ctzq on 2018/1/8.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "HotelAddressTableViewCell.h"
#import "HotelImgTitleTableViewCell.h"
#import "HotelAdvertiseTableViewCell.h"
#import "HotelCommentTableViewCell.h"
#import "UIColor+JGHexColor.h"
#import "HotelAdertisment.h"
#import "HotelModifyViewController.h"
#import "OpenInfo.h"
#import <UIImageView+WebCache.h>

#import "HomeBannerView.h"
#import "ZKPhotoBrowser.h"
#import <SDCycleScrollView/SDCollectionViewCell.h>

@interface HotelDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    BOOL isCollect;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) HomeBannerView *introImg;

@property (nonatomic, strong) NSMutableArray *hotArray;

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    
    self.view.backgroundColor = [UIColor colorWithHexCode:@"#e9e9e9"];
    
    [self checkCollectOrNot];
    
    [self requireSimliar];
    
    [self scannerAction];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //获取单个详情
    [self requireSingleDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [AdaptFrame ws_bottom:self.view]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.backgroundColor = [UIColor colorWithHexCode:@"#e9e9e9"];
        _tableview.showsVerticalScrollIndicator = NO;
        if ([_tableview respondsToSelector:@selector(separatorInset)]) {
            _tableview.separatorInset = UIEdgeInsetsZero;
        }
        _tableview.tableFooterView = [UIView new];
        if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableview setLayoutMargins:UIEdgeInsetsZero];
        }
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableview registerNib:[UINib nibWithNibName:@"HotelAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotelAddressCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelImgTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotelImgTitCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelAdvertiseTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotelAdvertiseCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotelCommentCell"];
        _tableview.tableHeaderView = self.introImg;
    }
    return _tableview;
}

- (NSMutableArray *)convertedImag:(NSArray *)imgs {
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger i=0; i<imgs.count; i++) {
        NSString * str = imgs[i]? imgs[i]:@"";
        if (![str hasPrefix:@"http"]) {
            str = [BaseImgUrl stringByAppendingString:str];
        }
        [result addObject:str];
    }
    return result;
}

- (HomeBannerView *)introImg {
    if (!_introImg) {
        _introImg = [[HomeBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _introImg.delegate = self;
    }
    
    //_introImg.userInteractionEnabled = true;
    //TODO: chuli images
    //_introImg.imageURLStringsGroup = [self convertedImag:self.buildModel.images];
    _introImg.placeholderImage = [UIImage imageNamed:@"listDefault2"];
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 20, 44, 44);
    [btnBack setImage:[UIImage imageNamed:@"jdgb1_return2"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_introImg addSubview:btnBack];
    
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.tag = 88;
    btnSave.frame = CGRectMake(self.view.frame.size.width-44, 20, 44, 44);
    [btnSave setImage:[UIImage imageNamed:@"jdgb1_star2"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_introImg addSubview:btnSave];
    return _introImg;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else {
        return 1 + self.hotArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 88;
        } else if(indexPath.row == 1 || indexPath.row == 2){
            return 44;
            
        } else {
            return 54;
        }
    } else {
        if (indexPath.row == 0) {
            return 54;
        } else {
            return 90;
        }
    }
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"hotelAddressCell";
    static NSString *identifier1 = @"hotelImgTitCell";
    static NSString *identifier2 = @"hotelAdvertiseCell";
    static NSString *identifier3 = @"hotelCommentCell";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HotelAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [cell setContents:self.buildModel];
            return cell;
        } else if (indexPath.row == 1) {
            HotelImgTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.title.text = self.buildModel.phone;
            cell.markImg.image = [UIImage imageNamed:@"icon_classifyl_phone"];
            return cell;
        } else if (indexPath.row == 2) {
            HotelImgTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.title.text = self.buildModel.cellphone;
            cell.markImg.image =[UIImage imageNamed:@"icon_classifyl_cellphone"];
            return cell;
        }else if (indexPath.row == 3) {
            HotelAdvertiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            cell.advertiseName.text = self.buildModel.mainProducts;
            cell.adverTitleLbl.text = @"主营：";
            return cell;
        }else if (indexPath.row == 4) {
            HotelAdvertiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            cell.advertiseName.text = self.buildModel.adWord;
            cell.adverTitleLbl.text = @"广告：";
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            HotelImgTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.title.text = @"同类商家";
            cell.markImg.image =[UIImage imageNamed:@"icon_classifyl_similar"];

            return cell;
        } else {
            HotelCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            BuildingDetailModel *m = self.hotArray[indexPath.row - 1];
            [cell loadContents:m];
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 地址
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                
                NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
                baiduMapDic[@"title"] = @"使用百度地图导航";
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/marker?location=40.047669,116.313082&title=我的位置&content=百度奎科大厦"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
            else {
                [WSMessageAlert showMessage:@"请安装百度地图"];
                return;
            }
        } else if (indexPath.row == 1) {
            //电话
            HotelImgTitleTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",cell.title.text];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
   
        } else if (indexPath.row == 2) {
           //手机
            HotelImgTitleTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",cell.title.text];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else if (indexPath.row == 3) {
           //主营
            HotelAdvertiseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            [self showAdertisment:@"主营" content:cell.advertiseName.text btn:1];
            
        }else if (indexPath.row == 4) {
            //广告
            HotelAdvertiseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
           // modifyctl
            [self showAdertisment:@"广告" content:cell.advertiseName.text btn:2];
        }
    } else {
        if (indexPath.row == 0) {
            //do nothing
        } else {
           //酒店详情
            HotelDetailViewController *hotCtl = [[HotelDetailViewController alloc] init];
            hotCtl.buildModel = self.hotArray[indexPath.row - 1];
            [self.navigationController pushViewController:hotCtl animated:YES];
        }
    }
}

- (void)showAdertisment:(NSString *)title content:(NSString *)content btn:(NSInteger)btn{
    
    HotelAdertisment *hotelV = [[[NSBundle mainBundle]loadNibNamed:@"HotelAdertisment" owner:self options:nil]objectAtIndex:0];
    CGFloat hL = [title isEqualToString:@"主营"] ? 200:250;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - hL - [AdaptFrame ws_safeAreaInset:self.view].bottom ;
    hotelV.frame = CGRectMake(0, y, ScreenWidth, hL);
    hotelV.titleLbl.text = title;
    hotelV.content.text = content;
    [hotelV.clickBtn setTitle:[NSString stringWithFormat:@"修改%@内容",title] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    
    __weak HotelAdertisment *tmphotelV = hotelV;
    hotelV.goclickBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
       HotelModifyViewController *modify =  [[UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"modifyctl"];
        modify.buildModel = strongSelf.buildModel;
        modify.source = [title isEqualToString:@"主营"] ? 1: 2;
        [strongSelf.navigationController pushViewController:modify animated:YES];
        [tmphotelV.superview removeFromSuperview];
    };
    UIView * v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [v addSubview:hotelV];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackView:)];
    ges.numberOfTapsRequired = 1;
    [v addGestureRecognizer:ges];
    
    [self.view addSubview:v];

}

- (void)clickBackView:(UITapGestureRecognizer *)ges {
    [ges.view removeFromSuperview];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [AdaptFrame ws_bottom:self.view]);
}

- (void)back {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)save {
    //收藏
    NSDictionary *dic = @{ITEMIDKEY:[NSString stringWithFormat:@"%@",self.buildModel.cID],
                          ITEMNameKEY:self.buildModel.name? self.buildModel.name:@""};
    if (isCollect) {
        isCollect = !isCollect;
        [[OpenInfo shared] deleteDicInCollect:dic];
    }
    else {
        isCollect = !isCollect;
        [[OpenInfo shared] addToCollect:dic];
    }
    [self checkCollectOrNot];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requireSimliar {
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/getHotList/%@",[OpenInfo shared].currentArea.aID]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        [strongSelf.hotArray removeAllObjects];
        
        if ([dic[@"errcode"] integerValue]  == 0) {
            NSArray *data = dic[@"data"];
            for (NSDictionary *d in data) {
                BuildingDetailModel *item = [[BuildingDetailModel alloc] init];
                [item setValuesForKeysWithDictionary:d];
                [strongSelf.hotArray addObject:item];
            }
        }
     
        [strongSelf.tableview reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)requireSingleDetail {
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/detail/%@",self.buildModel.cID]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue]  == 0) {
            NSDictionary *data = dic[@"data"];
            [self.buildModel setValuesForKeysWithDictionary:data];
        }
        self.introImg.imageURLStringsGroup = [self convertedImag:self.buildModel.images];
        [strongSelf.tableview reloadData];
        [strongSelf checkCollectOrNot];
    } failure:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

#pragma mark - 检查是否收藏

- (void)checkCollectOrNot {
    isCollect = NO;
    NSArray *result = [OpenInfo shared].collectArray;
    for (NSDictionary *dic in result) {
        if ([dic[ITEMIDKEY] integerValue] == self.buildModel.cID.integerValue) {
            //
            for (UIButton *tmpB in _introImg.subviews) {
                if (tmpB.tag == 88) {
                    [tmpB setImage:[UIImage imageNamed:@"jdgb1_star4"] forState:UIControlStateNormal];
                    isCollect = YES;
                }
            }
            return;
        }
    }
    for (UIButton *tmpB in _introImg.subviews) {
        if (tmpB.tag == 88) {
            [tmpB setImage:[UIImage imageNamed:@"jdgb1_star2"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 浏览

- (void)scannerAction {
    NSDictionary *dic = @{ITEMIDKEY:[NSString stringWithFormat:@"%@",self.buildModel.cID],
                          ITEMNameKEY:self.buildModel.name? self.buildModel.name:@""};
    [[OpenInfo shared] addToScanned:dic];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    UICollectionView *collection = [cycleScrollView valueForKey:@"mainView"];
    NSIndexPath *idx = [NSIndexPath indexPathForRow:index inSection:0];
    SDCollectionViewCell *cell = (SDCollectionViewCell *)[collection cellForItemAtIndexPath:idx];
    [ZKPhotoBrowser showWithImageUrls:[self convertedImag:self.buildModel.images] currentPhotoIndex:index sourceSuperView:cell.imageView];
}

@end
