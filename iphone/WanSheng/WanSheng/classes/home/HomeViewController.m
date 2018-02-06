//
//  HomeViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePMDView.h"
#import "HomeHotCollectionViewCell.h"
#import "HotelDetailViewController.h"
#import "HomeMenuView.h"

#import "ZJBLTabbarController.h"
#import "KindsViewController.h"
//#import "PBLocation.h"

#import "CityPickerController.h"
#import "OpenInfo.h"

#import <JZLocationConverter/JZLocationConverter.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (weak, nonatomic) IBOutlet HomeBannerView *cycleImgsView;
@property (weak, nonatomic) IBOutlet HomePMDView *cycletxtView;

@property (weak, nonatomic) IBOutlet UICollectionView *hotcollection;

@property (weak, nonatomic) IBOutlet UILabel *cityLbl;
//热门商家数据
@property (strong, nonatomic) NSMutableArray *hotDataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHConstraint;

@property(weak, nonatomic) IBOutlet HomeMenuView *homeMenu;

@property (strong, nonatomic) CityPickerController *cpCtl;


//baidu
@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path1 =[[NSBundle mainBundle] pathForResource:@"listDefault2" ofType:@"png"];
    NSArray *urlArr = @[path1];
    self.cycleImgsView.imageURLStringsGroup = urlArr;
    self.cycleImgsView.delegate = self;
    
    self.hotcollection.delegate = self;
    self.hotcollection.dataSource = self;

   // [self refreshHotdataCollection];
    
    self.homeMenu.menuClicked = ^(NSString* name){
        [[ZJBLTabbarController sharedZJBLTabbarController] goToSelectCtrlWithTitle:@"分类" Index:1];
        NSArray *ctls = [ZJBLTabbarController sharedZJBLTabbarController].childViewControllers;
        for (UIViewController *v in ctls) {
            if ([v.childViewControllers[0] isKindOfClass:[KindsViewController class]]) {
                KindsViewController *kindCtl = (KindsViewController *)v.childViewControllers[0];
                [kindCtl gotoLeftByName:name];
                break ;
            }
        }
        
    };
    
    //启动请求和服务
   // [self locationService1];
    NSLog(@"启动请求和服务--------");
    [self.locationService startUserLocationService];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    self.cycletxtView.pmdArray = @[@"万商连万家，方便你我他-欢迎加入神州万商。",@"万商连万家，方便你我他-欢迎加入神州万商。"];

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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotDataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotCellID forIndexPath:indexPath];
    BuildingDetailModel *m = self.hotDataArray[indexPath.row];
    [cell loadContents:m];
    return cell;
}

#pragma mark - collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HotelDetailViewController *hotCtl = [[HotelDetailViewController alloc] init];
    hotCtl.buildModel  = self.hotDataArray[indexPath.row];
    [self.navigationController pushViewController:hotCtl animated:YES];
}

#pragma mark - flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth - 30)/2.0, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - actions
//点击左上角城市
- (IBAction)clickCity:(id)sender {
    //[WSMessageAlert showMessage:@"调试中"];
    
    UIView * v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    v.tag = 31;
    v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlankArea:)];
    tapges.numberOfTapsRequired = 1;
    tapges.delegate = self;
    [v addGestureRecognizer:tapges];
    [self.view addSubview:v];
    if ([OpenInfo shared].currentCity) {
        self.cpCtl.view.frame = CGRectMake(0, 44 + [AdaptFrame ws_top:self.view], ScreenWidth, 500);
    } else {
        self.cpCtl.view.frame = CGRectMake(0, 44 + [AdaptFrame ws_top:self.view], ScreenWidth, 456);
    }
    [v addSubview:self.cpCtl.view];
    
}

- (void)clickBlankArea:(UITapGestureRecognizer *)ges {
    [ges.view removeFromSuperview];
}

- (CityPickerController *)cpCtl {
    if (!_cpCtl) {
        _cpCtl = [[CityPickerController alloc] init];
        _cpCtl.view.frame = CGRectMake(0, 44 + [AdaptFrame ws_top:self.view], ScreenWidth, 500);
        __weak typeof(self) weakSelf = self;
        _cpCtl.chooseCityBlock = ^(CityModel *m, AreaModel *a) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [[strongSelf.cpCtl.view superview] removeFromSuperview];
            [OpenInfo shared].currentCity = m;
            [OpenInfo shared].currentArea = a;
            strongSelf.cityLbl.text = [strongSelf cityLabelShow:m a:a];
            [strongSelf refreshUI];
        };
        [self addChildViewController:_cpCtl];
    }
    return _cpCtl;
}

//搜你所需
- (IBAction)clickSearch:(id)sender {
    [[ZJBLTabbarController sharedZJBLTabbarController] goToSelectCtrlWithTitle:@"搜索" Index:2];

}

- (void)refreshHotdataCollection {
    [self.hotcollection reloadData];
    [[self.hotcollection superview] layoutIfNeeded];
    self.collectionHConstraint.constant = self.hotcollection.collectionViewLayout.collectionViewContentSize.height + 30;
}

#pragma mark - lazy load

- (NSMutableArray *)hotDataArray {
    if (!_hotDataArray) {
        _hotDataArray = [NSMutableArray array];
      
    }
    return _hotDataArray;
}

- (NSString *)cityLabelShow:(CityModel *)m a:(AreaModel *)a {
    NSString *str = a? [NSString stringWithFormat:@"%@%@",m.city,a.area]:m.city;
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark -requests

- (void)locationService1 {
    /*
    __weak typeof(self) weakSelf = self;
    [[PBLocation location] startLocationAddress:^(BOOL isSuccess, PBLocationModel *locationModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        isSuccess = NO;
        if (isSuccess) {
            strongSelf.cityLbl.text = [NSString stringWithFormat:@"%@%@",locationModel.locality,locationModel.subLocality];
            CityModel *m = [[CityModel alloc] init];
            m.city = strongSelf.cityLbl.text;
            [OpenInfo shared].currentCity = m;
            [OpenInfo shared].currentArea = nil;
            
            //坐标存储的时候高德地图坐标转为百度坐标
            CLLocationCoordinate2D bdLocation2D = [JZLocationConverter wgs84ToBd09:[JZLocationConverter gcj02ToWgs84:locationModel.currentLocation.coordinate]];
            [OpenInfo shared].bdLocation2D = bdLocation2D;
            
          
        } else {
            strongSelf.cityLbl.text = @"北京市东城区";
            CityModel *m = [[CityModel alloc] init];
            m.city = @"北京市";
            [OpenInfo shared].currentCity = m;
            AreaModel *area = [[AreaModel alloc] init];
            area.area = @"东城区";
            area.aID = @(110101);
            [OpenInfo shared].currentArea = area;
        }
        [strongSelf refreshUI];
        
    }];
*/
}

#pragma mark - gesture
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    //判断是不是点的collectionView
    if (touch.view.tag == 31) {
        return YES;
    }
    return  NO;
}

#pragma mark - refresh

- (void)refreshUI {
    [self refreshHotSeller];
    [self refreshBanner];
}

- (void)refreshBanner {
   // /api/banner/list/110101
    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"banner/list/%@",[OpenInfo choosedId]]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSDictionary *dic = (NSDictionary *)responseObject;

        NSMutableArray *urlArray = [NSMutableArray array];
        if ([dic[@"errcode"] integerValue]  == 0) {
            NSArray *data = dic[@"data"];
            for (NSDictionary *d in data) {
                if ([d[@"bannerUrl"] length] > 0) {
                    [urlArray addObject:d[@"bannerUrl"]];
                }
            }
        }
        strongSelf.cycleImgsView.placeholderImage = [UIImage imageNamed:@"listDefault"];
        strongSelf.cycleImgsView.imageURLStringsGroup = urlArray;
        strongSelf.cycleImgsView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        strongSelf.cycleImgsView.backgroundColor = [UIColor whiteColor];
    } failure:^(NSError *error) {
        
        
    }];
    
}


- (void)refreshHotSeller {

    NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/getHotList/%@",[OpenInfo choosedId]]];
    CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
    __weak typeof(self) weakSelf = self;
    [WSBaseRequest GET:model success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        [strongSelf.hotDataArray removeAllObjects];
        
        if ([dic[@"errcode"] integerValue]  == 0) {
            NSArray *data = dic[@"data"];
            for (NSDictionary *d in data) {
                BuildingDetailModel *item = [[BuildingDetailModel alloc] init];
                [item setValuesForKeysWithDictionary:d];
                [strongSelf.hotDataArray addObject:item];
            }
        }
        [strongSelf refreshHotdataCollection];
        
    } failure:^(NSError *error) {
        
       
    }];
}


#pragma mark cycle img delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}


#pragma mark - baidu location

- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService =  [[BMKLocationService alloc] init];
        _locationService.desiredAccuracy = 300;
        _locationService.delegate = self;
    }
    return _locationService;
}

- (BMKGeoCodeSearch *)geoSearch {
    if (!_geoSearch) {
        _geoSearch = [[BMKGeoCodeSearch alloc] init];
        _geoSearch.delegate = self;
    }
    return _geoSearch;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    if (userLocation.location) {
        //BDLocation getAdCode()
        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
        option.reverseGeoPoint = [userLocation location].coordinate;
        [OpenInfo shared].bdLocation2D = [userLocation location].coordinate;
        NSLog(@"反解析--------");
         [self.geoSearch reverseGeoCode:option];//反解析
        //[self.locationService stopUserLocationService];
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (result.address.length > 0) {
        NSLog(@"OK--------");
        self.cityLbl.text = [NSString stringWithFormat:@"%@%@",result.addressDetail.city,result.addressDetail.district];
        CityModel *m = [[CityModel alloc] init];
        m.city = result.addressDetail.city;
        m.cId = [NSNumber numberWithLongLong:(result.addressDetail.adCode.longLongValue / 100)*100];
        [OpenInfo shared].currentCity = m;
        [OpenInfo shared].cityCode = result.cityCode;
        AreaModel *area = [[AreaModel alloc] init];
        area.area = result.addressDetail.district;
        area.aID = [NSNumber numberWithLongLong:result.addressDetail.adCode.longLongValue];
        [OpenInfo shared].currentArea = area;
        [self refreshUI];
        
        [self.locationService stopUserLocationService];
    } else {
        NSLog(@"定位错误，重新定位");
    }
}
@end
