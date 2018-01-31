//
//  LiveInViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "LiveInViewController.h"
#import "UploadImageCollectionViewCell.h"

#import "SuPhotoPicker.h"

#import "SortView.h"
#import "CustomPickerView.h"

#import "UIImage+wsExtension.h"

#import "AFHttpUtil.h"
#import "NSObject+SBJson.h"

#import "ZFBView.h"

///////
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
////zfb
/////////

#import "SuccessViewController.h"

@interface LiveInViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSMutableArray *uploadedImageDataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *uploadCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadCollectionHConstraint;
//商家分类
@property (weak, nonatomic) IBOutlet UILabel *businessKindLbl;
@property (copy, nonatomic) NSNumber *catagoryID;
//商家名称
@property (weak, nonatomic) IBOutlet UITextField *businessName;

//商家地址
@property (weak, nonatomic) IBOutlet UILabel *sellerChooseAddressLbl;
@property (copy, nonatomic) NSNumber *regionId;

//商家子地址
@property (weak, nonatomic) IBOutlet UITextField *subAddressTxt;
//商家坐标

@property (weak, nonatomic) IBOutlet UILabel *coordLabel;

//商家电话

@property (weak, nonatomic) IBOutlet UITextField *businessPhoneTxt;

//手机号码
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneNumberTxt;
//主营内容
@property (weak, nonatomic) IBOutlet UITextView *businessManagedZoneTxtView;

//广告
@property (weak, nonatomic) IBOutlet UITextView *businessAdvertismentTxtView;

@property (weak, nonatomic) IBOutlet UIButton *normalBusinessBtn;

@property (weak, nonatomic) IBOutlet UIButton *highLevelBusinessBtn;
//推荐人
@property (weak, nonatomic) IBOutlet UITextField *recommenderNumber;
/////

@property (weak, nonatomic) IBOutlet SortView *sortV;

@property (strong, nonatomic) CustomPickerView *pickerView;

@property(nonatomic, assign) NSInteger normalBusinesFlag;

@end

@implementation LiveInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //initial
    
    ///collectionview
    self.uploadCollectionHConstraint.constant = 120.0;
    self.uploadCollectionView.delegate = self;
    self.uploadCollectionView.dataSource = self;
    ////
    
    self.normalBusinesFlag = 1;
    
    self.businessManagedZoneTxtView.layer.borderWidth = 0.5;
    self.businessManagedZoneTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.businessAdvertismentTxtView.layer.borderWidth = 0.5;
    self.businessAdvertismentTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    
    //////sort view
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktohide:)];
    tapGes.numberOfTapsRequired = 1;
    tapGes.delegate = self;
    [self.sortV addGestureRecognizer:tapGes];
    self.sortV.tag = 2;

    __weak typeof(self) weakSelf = self;
    self.sortV.chooseKindBlock = ^(CatagoryModel *leftM, CatagoryModel *m) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.sortV.hidden = YES;
        strongSelf.businessKindLbl.text = [NSString stringWithFormat:@"%@,%@",leftM.cName,m.cName];
        strongSelf.catagoryID = m.cID;
    };

    ////// sort view
    
    
    ///picker view
    self.pickerView.doRequireAddressBlock = ^(ProvinceModel *p, CityModel *c, AreaModel *a) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.pickerView.hidden = YES;
        //address
        if (a) {
            strongSelf.sellerChooseAddressLbl.text = [NSString stringWithFormat:@"%@%@%@",p.province,c.city,a.area];
            strongSelf.regionId = a.aID;
        }
        else {
            strongSelf.sellerChooseAddressLbl.text = [NSString stringWithFormat:@"%@%@",p.province,c.city];
            strongSelf.regionId = c.cId;
        }
    };
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

#pragma mark - collection data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.uploadedImageDataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UploadImageCollectionViewCell *ucell = [collectionView dequeueReusableCellWithReuseIdentifier:UploadImageCellID forIndexPath:indexPath];
    ucell.img.image = self.uploadedImageDataArray[indexPath.row];
    ucell.deleteBtn.hidden = (indexPath.row <= 1);
    __weak typeof(self) weakSelf = self;
    ucell.deleteBlock = ^(UploadImageCollectionViewCell *cell){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSIndexPath *idx = [collectionView indexPathForCell:cell];
        [strongSelf.uploadedImageDataArray removeObjectAtIndex:idx.row];
        [strongSelf refreshUploadArea];
    };
    return ucell;
}

#pragma mark - collection view flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    PPLog(@"hello in ");
    if (indexPath.row == 0) {
        [self appearImageChooser:self.uploadedImageDataArray.count];
    }
}

#pragma mark - lazy load

- (NSMutableArray *)uploadedImageDataArray {
    if (!_uploadedImageDataArray) {
        _uploadedImageDataArray = [NSMutableArray array];
        [_uploadedImageDataArray addObject:[UIImage imageNamed:@"my_camera"]];
        [_uploadedImageDataArray addObject:[UIImage imageNamed:@"my_photo"]];
    }
    return _uploadedImageDataArray;
}

- (CustomPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[CustomPickerView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_pickerView];
        _pickerView.hidden = YES;
    }
    return _pickerView;
}

#pragma mark - img choose

- (void)appearImageChooser:(NSUInteger)count {
    __weak typeof(self) weakSelf = self;
    SuPhotoPicker *picker = [[SuPhotoPicker alloc] init];
    [picker showInSender:self handle:^(NSArray<UIImage *> *photos) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (photos.count > 0) {
            for (UIImage *photo in photos) {
                if (![strongSelf hasSameImg:photo]) {
                    [strongSelf.uploadedImageDataArray addObject:photo];
                    [strongSelf refreshUploadArea];
                }
            }
        }
        PPLog(@"%@",photos);
    }];
}

- (BOOL)hasSameImg:(UIImage *)img {
    /*
    NSData *data = UIImagePNGRepresentation(img);

    for (UIImage *m in self.uploadedImageDataArray) {
        NSData *data1 = UIImagePNGRepresentation(m);
        if ([data isEqual:data1]) {
            return YES;
        }
    }
   //  ios 11 UIImagePNGRepresentation 有bug
   // Unable to load image data, /var/mobile/Media/DCIM/
    */
    //上传图片
    img.randomNum = [NSNumber numberWithInteger:[self randomInt:1 to:10000000]];

    NSString *strUrl = [BaseUrl stringByAppendingString:@"merchant/uploadImage"];
    CTURLModel *model = [CTURLModel initWithUrl:strUrl params:nil];
    model.isEncrpty = NO;
    [WSBaseRequest uploadImagesWithURL:model name:@"pic" images:@[img] fileNames:@[@"imgs1"] imageScale:0.4 imageType:@"png" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        PPLog(@"success: %@ %@",img.randomNum,responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue] == 0) {
            img.imgNameFromServer = [NSString stringWithFormat:@"%@",dic[@"data"]];
        }
        else {
            [WSMessageAlert showMessage:@"上传图片失败，请重新添加"];
        }
    } failure:^(NSError *error) {
        [WSMessageAlert showMessage:@"上传图片失败，请重新添加"];
    }];
    
    return NO;
}

- (NSInteger) randomInt:(NSInteger) begin to:(NSInteger) end {
    NSInteger randomInt = (arc4random() % end) + begin;
    return randomInt;
}

- (void)refreshUploadArea {
    [self.uploadCollectionView reloadData];
    self.uploadCollectionHConstraint.constant = self.uploadCollectionView.collectionViewLayout.collectionViewContentSize.height;
}


#pragma mark -商家分类
- (IBAction)clickSortBtn:(id)sender {
    self.sortV.hidden = NO;
}


- (void)clicktohide:(UITapGestureRecognizer *)ges {
    self.sortV.hidden = YES;
}

#pragma mark -商家地址

- (IBAction)clickBusinessAddress:(id)sender {
    self.pickerView.hidden = NO;
    [self.view bringSubviewToFront:self.pickerView];
}

#pragma mark -商家坐标

- (IBAction)clickAcquireCoords:(id)sender {
    
    BaiDuMapViewController *map = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"baiductl"];

    map.getAddrssBlock = ^(NSString *address, CLLocationCoordinate2D location) {
        if (address.length <= 0) {
            self.coordLabel.text = @"未知地点,请再试一次";
        } else {
            self.coordLabel.text = [NSString stringWithFormat:@"%.6lf,%.6lf",location.latitude,location.longitude];
        }
    };
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark - 普通，高级商家选择

- (void)setNormalBusinesFlag:(NSInteger)normalBusinesFlag {
    _normalBusinesFlag = normalBusinesFlag;
    if (normalBusinesFlag == 1) {
        [self.normalBusinessBtn setImage:[UIImage imageNamed:@"icon_my_selected"] forState:UIControlStateNormal];
        [self.highLevelBusinessBtn setImage:[UIImage imageNamed:@"icon_my_unselected"] forState:UIControlStateNormal];
    }
    else {
        [self.normalBusinessBtn setImage:[UIImage imageNamed:@"icon_my_unselected"] forState:UIControlStateNormal];
        [self.highLevelBusinessBtn setImage:[UIImage imageNamed:@"icon_my_selected"] forState:UIControlStateNormal];
    }
}
- (IBAction)normalBuniessClicked:(id)sender {
    self.normalBusinesFlag = 1;
}
- (IBAction)highLevelBusinessClicked:(id)sender {
    self.normalBusinesFlag = 2;
}

#pragma mark - 提交审核

- (IBAction)commitInfo:(id)sender {
    
    if ([self.businessKindLbl.text isEqualToString:@"请选择商家所属的分类"]) { [WSMessageAlert showMessage:@"请选择商家所属的分类"];return ;}
    if (self.businessName.text.length == 0) { [WSMessageAlert showMessage:@"请输入商家名称"];return;}
    if ([self.sellerChooseAddressLbl.text isEqualToString:@"请选择商家的地址"]){ [WSMessageAlert showMessage:@"请选择商家的地址"]; return;}
    if (self.subAddressTxt.text.length == 0) {[WSMessageAlert showMessage:@"请输入详细地址"]; return;}
    if (self.cellPhoneNumberTxt.text.length == 0)  {[WSMessageAlert showMessage:@"请输入商家的手机号码"]; return;}
    if ([self.businessManagedZoneTxtView.text hasPrefix:@"请输入商家的主营内容"]) { [WSMessageAlert showMessage:@"请输入商家的主营内容"]; return;}
    if ([self.businessAdvertismentTxtView.text hasPrefix:@"请输入商家的广告内容"]) { [WSMessageAlert showMessage:@"请输入商家的广告内容"];return;}
    if (self.uploadedImageDataArray.count == 2){ [WSMessageAlert showMessage:@"请上传商家照片"];return;}
    if (self.uploadedImageDataArray.count > 7){ [WSMessageAlert showMessage:@"上传的商家照片不能超过5张"];return;}

    //all passed
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.businessName.text forKey:@"name"];
    [params setValue:[NSString stringWithFormat:@"%@",self.regionId] forKey:@"region"];
    [params setValue:[NSString stringWithFormat:@"%@",self.catagoryID] forKey:@"categoryId"];
    [params setValue:self.cellPhoneNumberTxt.text forKey:@"cellphone"];
    [params setValue:self.businessManagedZoneTxtView.text forKey:@"mainProducts"];
    [params setValue:self.businessAdvertismentTxtView.text forKey:@"adWord"];
    if (self.businessPhoneTxt.text > 0) {
        [params setValue:self.businessPhoneTxt.text forKey:@"phone"];
    }
    if ([self.coordLabel.text rangeOfString:@","].location != NSNotFound) {
        NSArray *arr = [self.coordLabel.text componentsSeparatedByString:@","];
        if (arr.count == 2) {
            [params setValue:arr[0] forKey:@"lat"];
            [params setValue:arr[1] forKey:@"lng"];
        }
    }
    [params setValue:self.subAddressTxt.text forKey:@"address"];
    
    NSMutableString * adstrr = [[NSMutableString alloc] initWithString:@""];
    for (NSInteger i = 2; i < self.uploadedImageDataArray.count; i++) {
        UIImage *img = self.uploadedImageDataArray[i];
        [adstrr appendString:img.imgNameFromServer];
        if (i!= self.uploadedImageDataArray.count - 1) {
            [adstrr appendString:@","];
        }
    }
    [params setValue:adstrr forKey:@"imageIdStr"];
    if (self.normalBusinesFlag == 1) {
        [params setValue:@"normal" forKey:@"type"];
    } else {
        [params setValue:@"vip" forKey:@"type"];
    }
    
    if (self.recommenderNumber.text.length > 0) {
        [params setValue:self.recommenderNumber.text forKey:@"referee"];
    }
    
    CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:@"merchant/addMerchant"] params:params];

    __weak typeof(self) weakSelf = self;
    [AFHttpUtil doPostWithUrl:model callback:^(BOOL isSuccessed, id result) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (isSuccessed) {
            NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [jsonStr JSONValue];
            PPLog(@"%@ response: %@",model.description,dic.description);
            if ([dic[@"errcode"] integerValue] == 0) {
                //弹出框
                //支付宝支付
                [strongSelf invokeZFB:dic[@"data"]];
       
            } else {
                [WSMessageAlert showMessage:@"Sorry,入驻申请提交失败"];
            }
        }else {
            [WSMessageAlert showMessage:@"Sorry,入驻申请提交失败"];
        }
    }];

}

- (void)invokeZFB:(NSNumber *)number {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ZFBView" owner:self options:nil];
    ZFBView *zfbView = (ZFBView *)nibs[0];
    if (self.normalBusinesFlag == 1) {
        //normal
        [zfbView.payBtn setTitle:@"支付年入驻费20元" forState:UIControlStateNormal];
    }
    else {
        [zfbView.payBtn setTitle:@"支付年入驻费2000元" forState:UIControlStateNormal];
    }
    __weak typeof(self) weakSelf = self;
    zfbView.payFee = ^(NSInteger selectIdx) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (selectIdx == 0) {
            //zfb
            PPLog(@"zfb pay start");
            [strongSelf beginPay:strongSelf.normalBusinesFlag == 1? 20.0:2000.0 number:number];
        }
    };
    zfbView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:zfbView];
}

#pragma mark gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag == 2) {
        return YES;
    }
    return NO;
}

#pragma mark - zfb

- (void)beginPay:(CGFloat)money number:(NSNumber *)number{
    
    CTURLModel *m = [CTURLModel initWithUrl:[NSString stringWithFormat:@"%@pay/toPay/%@",BaseUrl,number] params:nil];
    [WSBaseRequest GET:m success:^(id responseObject) {
        NSDictionary * dic =(NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue] == 0) {
            NSString *sign = dic[@"data"];
             [[AlipaySDK defaultService] payOrder:sign fromScheme:@"WanSheng" callback:^(NSDictionary *resultDic) {
                 if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                     //成功
                     SuccessViewController *success = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"successctl"];
                     [self.navigationController pushViewController:success animated:YES];
                 }
                 else {
                     [WSMessageAlert showMessage:resultDic[@"memo"]];
                 }
            }];
        }
    } failure:^(NSError *error) {
        
    }];

}



- (void)doAPPay:(CGFloat)money {
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2018012302037018";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC0rPaEA1yQT/NW\
    6/BLAILWJiIDN4uqFN5nRHJReXx+6S1Kwrt28svv2WNxTFkyPLB3YShan34xoj3X\
    snJAfpGrXQ4uvqSNXW2TJLVQoPCjd/gJd1OtCkp2UclP04dvrvarZxRhwvjBJihd\
    H2GspoclmC01gHb8GH1AUNFfuJKIgsLuMZm97r9En6eWdH+GXmLfHvhDQfTt/TrM\
    KuOAKY2Y7AlJE+sRzCnOR5FbneKMXImAreScWOqYxST38kYoepYYfEmTRGKul/NN\
    9yksc6Cth3xXWDnhJ55AhU9ruQ3HdYi6Vekl9Wx8h08sG/R4BapTshj+CRltuWC4\
    pNT06WvzAgMBAAECggEATFZQCdMJxwegvvcNHgNnRGf0MvvDDOeoWGV5D6eOzGhk\
    9JN2dXl8ZSiqdXJWtX0i6i2oyTFeNkZgbsQ8tbdEgOzeUy3FhN0WsPbvjNOTGN5V\
    dFpwhko0z+0aa5nqPWvlWOJCoFOqmqEuqLnboQDzVRUI9PQEUdtfAE+lRxZLA1XW\
    jrQeEi1D8PhVRWHN0liyMthaYLl68IptDPuQFw1TK8pxfuxOCt9QfG9AuRw82PYd\
    Vs+IKKzDh0a2VS54FPQPjFk/R7b/e47SiXgUPjhbHWchXQvfbFwUHkAn86JXmtWY\
    0ogarSkrwSeO45tr3bGje/G3ptmgp8EStyOxxY3XUQKBgQDcp4iqRf45nPiDP9kj\
    fkvBvFm/WvA7rd18+22v5MfsoyyY8uDTAR0918KQ1uEHMI/JS+OcN6ZuWLPJGBDK\
    5PlZytIa8VTI7TACvQDcy7Rcb6BXnAmtNgmF7WwcldoUc4T9nUmt/A/rgp8F1Be2\
    pSTzXYajmpTOr8k2TIlCrTSWXQKBgQDRngCg3OwCY5/DFM7YHpIiaBq6ro5zBg0p\
    kIjdHxzS5G0D2/YREJ2CejX2lfZAZdAOzOve9YF3IMefZw6RZu5hQw/5tD0oKeSC\
    RKV6tlC365AQoYUOD/NSfhFR3UOyxqlgfekbSv7rcOsKih9tY6mVdfbpmHkV5upa\
    +egyUlxGjwKBgGNJGyyK3A6ufAAKzbizzoC5MKTy1V/1JtFjDQL1baQj9CBKQTGQ\
    sciu+gRUO+MRTdGkzSDwxXmnfhZBNuUkzLJDmfC3oI/cchr5UpcHLfvd2ocxVgVT\
    aEuT/m6KWxuSs0eu64VXAw7UsptbyOPNQWgkMD4Tg1vRKze8jpKq/xudAoGAcIWM\
    eM2eszmfTS0iS8k9UNLpZkTFmuEot6MqlOhapKqSCnxM/qQYqS3JQfEGG1OL+CXw\
    h+Lp+HTUM7EylMLYO8WwEa67FZBHZdZLri+n7NK6pvLNZdsSFrotufA4owMZcP6l\
    30zGwsP+p821SRcytVR5krOSbDtkmimEh17GwekCgYAiBViA9kHpILb1VtJ5LIOe\
    v0n2Svs/hXQFkVh2m5BNU0gE3eU9jQqjZ0NyEKrwbFa/KAWA8KjVhsS/Jy1QXJrH\
    Y2Lo8xWE1LSVyBdtoSepMe2ARECTggmLcimM8A7s2dxDuhKa7ozZKldP+BJhr9NK\
    cgnKH2J5aw6DwIdyMLoh4g==";
    NSString *rsaPrivateKey = @"";
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", money]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"WanSheng";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
