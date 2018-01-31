//
//  AddressPickerView.m
//  WanSheng
//
//  Created by mao on 2018/1/16.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "AddressPickerView.h"

@implementation AddressPickerView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
    }
    return self;
}

#pragma mark - picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    if (self.provinceArr.count == 0) {
        return 0;
    }
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component)
    {
        return self.provinceArr.count;
    }
    else if(1==component)
    {
        if (self.provinceArr.count == 0) {return 0;}
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model =   self.provinceArr[rowProvince];
        return model.citiesArr.count;
    }
    else
    {   NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        if (self.provinceArr.count == 0) {return 0;}
        ProvinceModel *model = self.provinceArr[rowProvince];
        if (model.citiesArr.count == 0) {
            return 0;
        }
        CityModel *cityModel = model.citiesArr[rowCity];
        if (cityModel.areaArray.count > 0) {
            return cityModel.areaArray.count;
        }
        return 0;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component)
    {
        ProvinceModel *model = self.provinceArr[row];
        return model.province;
    }
    else if(1==component)
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model = self.provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[row];
        return cityModel.city;
    }else
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = self.provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr.count > rowCity? model.citiesArr[rowCity]:nil;
        AreaModel *areaModel = cityModel.areaArray.count > row? cityModel.areaArray[row]:nil;
        return areaModel.area;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component)
    {
        ProvinceModel *p = self.provinceArr[row];
        [self requireCitysBelongProvice:p.pID pm:p];
        //  [pickerView reloadComponent:1];
        //  [pickerView reloadComponent:2];
        
    } if(1 == component)
    {
        NSInteger idx = [pickerView selectedRowInComponent:0];
        ProvinceModel *p = self.provinceArr[idx];
        CityModel * m = p.citiesArr[row];
        
        [self requireAreaBelongCity:m.cId pm:p cm:m];
        //[pickerView reloadComponent:2];
    }
    
}

#pragma mark - lazyload

- (NSMutableArray *)provinceArr {
    if (!_provinceArr) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

#pragma mark - requet data

- (void)sendReqs {
    
    //所有省份
    CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:@"region/getProvinces"] params:nil];
    __weak typeof(self) weakSelf = self;
    
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue] == 0) {
            NSMutableArray * data = dic[@"data"];
            [strongSelf.provinceArr removeAllObjects];
            for (NSDictionary *d in data) {
                ProvinceModel *p = [[ProvinceModel alloc] init];
                p.province = d[@"province"];
                p.pID = d[@"id"];
                p.isNewRecord = d[@"isNewRecord"];
                [strongSelf.provinceArr addObject:p];
            }
            [strongSelf refreshPicker:0];
            if (strongSelf.provinceArr.count > 0) {
                NSInteger selectidx = [_pickerView selectedRowInComponent:0];
                if (selectidx < 0) {
                    selectidx = 0;
                }
                ProvinceModel *t = strongSelf.provinceArr[selectidx];
                [strongSelf requireCitysBelongProvice:t.pID pm:t];
            }
           // [strongSelf uiConfig];
            if (strongSelf.notifyUIBlock) {
                strongSelf.notifyUIBlock();
            }
            [strongSelf refreshPicker:0];
            
        } else {
            [WSMessageAlert showMessage:@"获取省份接口失败，请重试"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requireCitysBelongProvice:(NSNumber *)pID pm:(ProvinceModel *)pm{
    
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"region/getCity/%@",pID]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue] == 0) {
            NSMutableArray * data = dic[@"data"];
            [pm.citiesArr removeAllObjects];
            
            //  CityModel *qxz = [[CityModel alloc] init];
            //   qxz.city = @"请选择";
            //   qxz.cId = @(-1);
            //  [pm.citiesArr addObject:qxz];
            
            for (NSDictionary *d in data) {
                CityModel *p = [[CityModel alloc] init];
                p.city = d[@"city"];
                p.cId = d[@"id"];
                p.isNewRecord = d[@"isNewRecord"];
                p.provinceid = d[@"provinceid"];
                // [strongSelf.provinceArr addObject:p];
                [pm.citiesArr addObject:p];
            }
            [strongSelf refreshPicker:1];

            NSInteger selectidx = [_pickerView selectedRowInComponent:1];
            if (pm.citiesArr.count > 0) {
                if (pm.citiesArr.count < selectidx) {
                    selectidx = 0;
                }
                if (selectidx < 0) {
                    selectidx = 0;
                }
                CityModel *t = pm.citiesArr[selectidx];
                [strongSelf requireAreaBelongCity:t.cId pm:pm cm:t];
            }
            [strongSelf refreshPicker:1];
            
        } else {
            [WSMessageAlert showMessage:@"获取城市接口失败，请重试"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requireAreaBelongCity:(NSNumber *)cityID pm:(ProvinceModel *)pm cm:(CityModel *)cm {
    if (cityID.integerValue == -1) {
        //刷新 picker view
        [cm.areaArray removeAllObjects];
        [self refreshPicker:2];
        return;
    }
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"region/getArea/%@",cityID]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue] == 0) {
            NSMutableArray * data = dic[@"data"];
            [cm.areaArray removeAllObjects];
            
            AreaModel *qxz = [[AreaModel alloc] init];
            qxz.area = @"请选择";
            qxz.aID = @(-1);
            [cm.areaArray addObject:qxz];
            
            for (NSDictionary *d in data) {
                AreaModel *p = [[AreaModel alloc] init];
                p.area = d[@"area"];
                p.aID = d[@"id"];
                p.isNewRecord = d[@"isNewRecord"];
                p.cityid = d[@"cityid"];
                [cm.areaArray addObject:p];
            }
            //刷新 picker view
            [strongSelf refreshPicker:2];
        } else {
            [WSMessageAlert showMessage:@"获取城市接口失败，请重试"];
        }
    }failure:^(NSError *error) {
        
    }];
}


- (void)refreshPicker:(NSInteger)compenent {
    [_pickerView reloadAllComponents];
}

@end
