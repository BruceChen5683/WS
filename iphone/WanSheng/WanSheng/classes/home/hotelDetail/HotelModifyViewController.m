//
//  HotelModifyViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/11.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HotelModifyViewController.h"
#import "AFHttpUtil.h"
#import "NSObject+SBJson.h"

@interface HotelModifyViewController ()

@property ( copy , nonatomic) NSString *smscode;

@end

@implementation HotelModifyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.confirmBtn addTarget:self
                        action:@selector(clickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadContens];
    
    [self.clickAquireBtn addTarget:self action:@selector(sendSms) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadContens {

    self.pageTitle.text = self.source == 1? @"修改主营内容":@"修改广告内容";
    self.hotelTitle.text = self.buildModel.name;
    self.addressLbl.text = self.buildModel.address;
    self.phoneLbl.text = self.buildModel.cellphone;
    self.changeTitleLbl.text = self.source == 1? @"请输入与新主营内容：":@"请输入与新广告内容：";
    self.changedTextView.text = self.source == 1? self.buildModel.mainProducts:self.buildModel.adWord;
}

- (void)clickConfirmBtn {
    
    ///api/merchant/changeAd
    if (self.proveTxtfield.text.length < 1) {
        [WSMessageAlert showMessage:@"请输入校验码"];
        return;
    }
    
    if (![self.proveTxtfield.text isEqualToString:self.smscode]) {
        [WSMessageAlert showMessage:@"验证码不正确"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@",self.buildModel.cID] forKey:@"id"];
    if (self.source == 1) {
        [params setValue:self.changedTextView.text forKey:@"mainProducts"];
    }
    else {
        [params setValue:self.changedTextView.text forKey:@"adWord"];
    }
    NSString *interfacePathUrl = self.source == 1? @"merchant/changeMainProducts":@"merchant/changeAd";
    CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:interfacePathUrl] params:params];
    __weak typeof(self) weakSelf = self;
    [AFHttpUtil doPostWithUrl:model callback:^(BOOL isSuccessed, id result) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (isSuccessed) {
            NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [jsonStr JSONValue];
            if ([dic[@"errcode"] integerValue] == 0) {
                [WSMessageAlert showMessage:@"修改成功"];
                [strongSelf.navigationController popViewControllerAnimated:YES];
            } else {
               [WSMessageAlert showMessage:@"Sorry,修改失败"];
            }
        }else {
            [WSMessageAlert showMessage:@"Sorry,修改失败"];
        }
    }];
}

- (void)setSource:(NSInteger)source {
    
    _source = source;

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


#pragma mark - 短信

- (void)sendSms {
    //http://39.106.208.193:8080/ws/api/msg/sendMsg/18611759864
    NSString *str = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"msg/sendMsg/%@",self.buildModel.cellphone]];
    __weak typeof(self) weakSelf = self;
    self.clickAquireBtn.enabled = NO;
    self.clickAquireBtn.userInteractionEnabled = NO;
    MBProgressHUD *hud = [WSMessageAlert showMessage:@"验证码发送中" nohide:YES];
    CTURLModel *model = [CTURLModel initWithUrl:str params:nil];
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        [hud hideAnimated:YES];
        if ([dic[@"errcode"] integerValue] == 0) {
            [WSMessageAlert showMessage:@"发送成功"];
            strongSelf.smscode = dic[@"data"];
        }
        else {
            [WSMessageAlert showMessage:@"获取失败"];
        }

    } failure:^(NSError *error) {
        [hud hideAnimated:YES];
        [WSMessageAlert showMessage:error.description];
    }];

}

@end
