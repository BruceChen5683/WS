//
//  BaseController.m
//  ChooseArea
//
//  Created by 朱帅 on 2016/10/25.
//  Copyright © 2016年 zhushuai. All rights reserved.
//

#import "CityPickerController.h"
//#import "AreaModel.h"
//#import "CityModel.h"
//#import "ProvinceModel.h"
#import "CityHeadView.h"
#import "CurrentCityTableViewCell.h"
#import "HotCityTableViewCell.h"
#import "WSBaseRequest.h"
#import "OpenInfo.h"
#import "AddressPickerView.h"

@interface CityPickerController ()<UITableViewDelegate,UITableViewDataSource>
{
    AddressPickerView *pickerView;
    
    UITableView *tableView;
}

@property(nonatomic, strong) NSMutableArray *hotCityArr;

@property(nonatomic, strong) CityModel *locationCity;

@end

@implementation CityPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationCity = [OpenInfo shared].currentCity;
    
    self.view.backgroundColor = [UIColor clearColor];

    pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 216)];
    __weak typeof(self) weakSelf = self;
    pickerView.notifyUIBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf uiConfig];
    };

    [self requireHotCitys];
    [pickerView sendReqs];
}

- (void)uiConfig
{
    //picker view 有默认高度216
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.scrollEnabled = NO;
    [tableView registerClass:[CityHeadView class] forHeaderFooterViewReuseIdentifier:@"headView"];
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"CurrentCityTableViewCell" bundle:nil] forCellReuseIdentifier:@"currentCity"];
    [tableView registerNib:[UINib nibWithNibName:@"HotCityTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotCityTC"];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [tableView reloadData];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [btn addTarget:self action:@selector(clickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    tableView.tableFooterView = btn;
    tableView.backgroundColor = [UIColor clearColor];
}

- (void)clickConfirm:(UIButton *)btn {
    //[[self.view superview] removeFromSuperview];
    
    
    NSInteger selectOne = [pickerView.pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [pickerView.pickerView selectedRowInComponent:1];
    NSInteger selectThree = [pickerView.pickerView selectedRowInComponent:2];
    
    ProvinceModel *model = pickerView.provinceArr.count > selectOne? pickerView.provinceArr[selectOne]:nil;
    CityModel *cityModel = model.citiesArr.count > selectTwo? model.citiesArr[selectTwo]:nil;
    AreaModel *areaModel = cityModel.areaArray.count > selectThree? cityModel.areaArray[selectThree]:nil;

    if (areaModel.aID.integerValue == -1) {
        //选择的是城市
        if (self.chooseCityBlock) {
            self.chooseCityBlock(cityModel, nil);
        }
    }
    else {
        if (self.chooseCityBlock) {
            self.chooseCityBlock(cityModel, areaModel);
        }
    }

}

#pragma mark - lazy load

- (NSMutableArray *)hotCityArr {
    if (!_hotCityArr) {
        _hotCityArr = [NSMutableArray array];
    }
    return _hotCityArr;
}

- (CityModel *)generate:(NSNumber *)cid name:(NSString *)name {
    CityModel *current = [[CityModel alloc] init];
    current.city = name;
    current.cId = cid;
    return current;
}


#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.locationCity.city.length == 0) {
            return 0;
        }
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1) {
        if (self.hotCityArr.count%4 == 0) {
            return (self.hotCityArr.count /4)*44 + 20;
        }
        return (self.hotCityArr.count /4 +1)*44 + 20;
    }
    return 220;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        if (section == 0) {
            if  (self.locationCity.city.length == 0){
                return 0;
            }
    }
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CityHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    if (section == 0) {
        headView.label.text = @"当前城市";
    }else if (section == 1) {
        headView.label.text = @"热门城市";
    }else {
        headView.label.text = @"所有城市";
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CurrentCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentCity"];
        cell.cityName.text = self.locationCity.city;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else if (indexPath.section == 1) {
        HotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCityTC"];
        cell.hotArr = self.hotCityArr;
        __weak typeof(self) weakSelf = self;
        cell.clickCollectionCellBlock = ^(NSInteger row) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CityModel *m = strongSelf.hotCityArr[row];
            if (strongSelf.chooseCityBlock) {
                strongSelf.chooseCityBlock(m,nil);
            }
        };
        [cell.collectionView reloadData];
        return cell;
    } else {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:pickerView];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (self.chooseCityBlock) {
            self.chooseCityBlock(self.locationCity,nil);
        }
    }
}



- (void)requireHotCitys {
    ///api/region/getHotCity 这个是获取热门城市
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"region/getHotCity"]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        [strongSelf.hotCityArr removeAllObjects];
        if ([dic[@"errcode"] integerValue] == 0) {
            NSArray *data = dic[@"data"];
            for (NSDictionary *tmp in data) {
                CityModel *tmodel = [[CityModel alloc] init];
                tmodel.cId = tmp[@"id"];
                tmodel.isNewRecord = tmp[@"isNewRecord"];
                tmodel.city = tmp[@"city"];
                tmodel.provinceid = tmp[@"provinceid"];
                [strongSelf.hotCityArr addObject:tmodel];
            }
            [tableView reloadData];
        } else {
            [WSMessageAlert showMessage:@"获取城市接口失败，请重试"];
        }
    }failure:^(NSError *error) {
        
    }];
}

@end
