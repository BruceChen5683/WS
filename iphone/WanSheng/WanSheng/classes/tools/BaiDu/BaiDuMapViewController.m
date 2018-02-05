//
//  BaiDuMapViewController.m
//  Test-cy
//
//  Created by chenyun on 2018/1/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaiDuMapViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BaiDuMapViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate> {
    
    MBProgressHUD *hud;
}

@property (nonatomic, strong) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (weak, nonatomic) IBOutlet UIView *bkmContentView;


@end

@implementation BaiDuMapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    self.mapView.zoomLevel = 17;
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.geoSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoSearch.delegate = self;
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_green"]];
    self.imgView.frame = CGRectZero;
    [self.mapView addSubview:self.imgView];
    
}

- (void)createSignImageView {

    // 把当前定位的经纬度换算为了View上的坐标
    CGPoint point = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.mapView];
    // 当解析出现错误的时候，会出现超出屏幕的情况，一种是大于了屏幕，一种是小于了屏幕
    if (point.x > ScreenWidth || point.x < ScreenWidth / 5){
        point.x = self.mapView.center.x;
        point.y = self.mapView.center.y;
    }
    
    self.imgView.frame = CGRectMake(0, 0, 30, 30);
    self.imgView.center = point;
    
}

#pragma mark - 用户方向更新

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
}

#pragma mark - 用户位置更新

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_locationService stopUserLocationService];//取消定位  这个一定要写，不然无法移动定位了
//    _mapView.centerCoordinate = userLocation.location.coordinate;
    NSLog(@" _mapView.centerCoordinate------%f-----%f", _mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    
//    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
//    option.reverseGeoPoint = userLocation.location.coordinate;
//    BOOL flag=[self.geoSearch reverseGeoCode:option];
//    if (flag) {
//
//    }
    
    // 添加大头针
//    BMKPointAnnotation *userAnnotation = [[BMKPointAnnotation alloc] init];
//    userAnnotation.coordinate = userLocation.location.coordinate;
//    userAnnotation.title = @"eee";
//    [_mapView addAnnotation:userAnnotation];
    [self createSignImageView];
}

#pragma mark - 定位失败

- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"%@", error);
}

#pragma mark - 大头针

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPinAnnotationView class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        annotationView.canShowCallout= YES;      //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop=YES;         //设置标注动画显示，默认为NO
        annotationView.draggable = YES;          //设置标注可以拖动，默认为NO
        return annotationView;
    }
    return nil;
}

#pragma mark - 点击大头针

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"点击了大头针");
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){mapView.region.center.latitude,mapView.region.center.longitude};
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = pt;
    BOOL flag = [self.geoSearch reverseGeoCode:option];
    if (flag) {
    }
    NSLog(@"搜索位置");
}

#pragma mark - 地址搜索

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"当前位置--------%@", result.address);
    if (result.address.length > 0) {
        self.address = result.address;
        self.location = result.location;
    } else {
        NSLog(@"定位错误，重新定位");
    }
}

//地图被拖动的时候，需要时时的渲染界面，当渲染结束的时候我们就去定位然后获取图片对应的经纬度

#pragma mark - 地图渲染每一帧画面过程(一动就进入)

- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status {
//    NSLog(@"onDrawMapFrame");
}

#pragma  mark - 地图区域即将改变时会调用此接口

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"regionWillChangeAnimated");
}

#pragma mark - 地图区域改变完成后会调用此接口

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated");
  
    // 地图中心点
    CGPoint touchPoint = self.imgView.center;
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    [hud hideAnimated:YES];
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
//    NSArray *annotationArr = mapView.annotations;
//    [mapView removeAnnotations:annotationArr];
    
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//    annotation.coordinate = touchMapCoordinate;
//    annotation.title = @"eeesssssss";
//    [_mapView addAnnotation:annotation];
    if (touchMapCoordinate.latitude == 0 || touchMapCoordinate.longitude == 0) {
        touchMapCoordinate = self.mapView.centerCoordinate;
    }
    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = touchMapCoordinate;
    BOOL flag=[self.geoSearch reverseGeoCode:option];
    if (flag) {
        
    }


}

#pragma mark - 地图渲染完毕后会调用此接口(最后走)

- (void)mapViewDidFinishRendering:(BMKMapView *)mapView {
    NSLog(@"DidFinishRendering");
    // 地图中心点
    /*
    CGPoint touchPoint = self.imgView.center;
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
    [self createSignImageView];
    //    NSArray *annotationArr = mapView.annotations;
    //    [mapView removeAnnotations:annotationArr];
    
    //    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    //    annotation.coordinate = touchMapCoordinate;
    //    annotation.title = @"eeesssssss";
    //    [_mapView addAnnotation:annotation];
    
    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = touchMapCoordinate;
    BOOL flag=[self.geoSearch reverseGeoCode:option];
    if (flag) {
        
    }
     */
}

#pragma mark - 点中底图标注后会回调此接口

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi {
    NSLog(@"点中底图标注后会回调此接口");
    CLLocationCoordinate2D coordinate = mapPoi.pt;
    [mapView setCenterCoordinate:coordinate animated:YES];
    return;
    /*
    //长按之前删除所有标注
    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:arrayAnmation];
    //设置地图标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = mapPoi.text;
    [_mapView addAnnotation:annotation];
    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
    re.reverseGeoPoint = coordinate;
    [self.geoSearch reverseGeoCode:re];
    BOOL flag =[self.geoSearch reverseGeoCode:re];
    if (!flag){
        NSLog(@"search failed!");
    }
     */
}

#pragma mark - 点中底图空白处会回调此接口

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"点中底图空白处会回调此接口");
    hud = [WSMessageAlert showMessage:@"获取经纬度中" nohide:YES];
    [mapView setCenterCoordinate:coordinate animated:YES];
    return;
    /*
    //长按之前删除所有标注
    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:arrayAnmation];
    //设置地图标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
//    annotation.title = mapPoi.text;/
    [_mapView addAnnotation:annotation];
    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
    re.reverseGeoPoint = coordinate;
    [self.geoSearch reverseGeoCode:re];
    BOOL flag =[self.geoSearch reverseGeoCode:re];
    if (!flag){
        NSLog(@"search failed!");
    }
     */
}

- (void)dealloc {
    self.mapView.delegate = nil;
    self.locationService.delegate = nil;
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

- (IBAction)doFinish:(id)sender {
    if (self.getAddrssBlock) {
        self.getAddrssBlock(self.address,self.location);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
