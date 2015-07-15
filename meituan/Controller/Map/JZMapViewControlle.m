//
//  JZMapViewControlle.m
//  meituan
//
//  Created by jinzelu on 15/7/14.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMapViewControlle.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#define MAPKEY @"2812f1e8b5f3c1473e8928ae9130e63d"

@interface JZMapViewControlle ()<MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    UIButton *_locationBtn;//定位按钮
    
    //地址转码
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    
    //附近搜索数据
    NSMutableArray *_pois;
    NSMutableArray *_annotations;
    
}
@end

@implementation JZMapViewControlle

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initMapView];
    [self setNav];
    [self initControls];
    [self initSearch];
    [self initAttributes];//初始化数据
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.frame = CGRectMake(15, 20, 30, 30);
    [backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
}

-(void)initMapView{
    [MAMapServices sharedServices].apiKey = MAPKEY;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 1;
}

-(void)initControls{
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _locationBtn.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds)-80, 40, 40);
    _locationBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;//
    _locationBtn.backgroundColor = [UIColor whiteColor];
    _locationBtn.layer.cornerRadius = 5;
    [_locationBtn setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:_locationBtn];
    
}

-(void)initSearch{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:MAPKEY Delegate:self];
}

- (void)initAttributes
{
    _annotations = [NSMutableArray array];
    _pois = [NSMutableArray array];
}

//相应事件
-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)locateAction{
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow) {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
    [self searchAction];
}

//逆地理编码
//发起搜索请求
-(void)reGeoAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

//
-(void)searchAction{
    if (_currentLocation == nil || _search == nil) {
        NSLog(@"search failed");
        return;
    }
    
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    request.searchType = AMapSearchType_PlaceAround;//附近搜索
    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    request.keywords = @"餐饮";
    [_search AMapPlaceSearch:request];
}







#pragma mark - MAMapViewDelegate
//更新位置
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
//    NSLog(@"userLocation:%@",userLocation.location);
    _currentLocation = [userLocation.location copy];
}

//替换定位图标
-(void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{
    if (mode == MAUserTrackingModeNone) {
        [_locationBtn setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }else{
        [_locationBtn setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}

//点击大头针时
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self reGeoAction];
    }
    
//    CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude)
//    _mapView setCenterCoordinate:(CLLocationCoordinate2D) animated:
//    _currentLocation = view.annotation
}

//显示地图标示view  大头针
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.canShowCallout = YES;
//        annotationView.image = [UIImage imageNamed:@"icon_map_cateid_3"];
        
        
        NSLog(@"+++++++");
        return annotationView;
    }
    
    return nil;
}



#pragma mark - AMapSearchDelegate
//搜索失败
-(void)searchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"request :%@,error :%@",request,error);
}

//逆地址编码
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"response:%@",response);
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0) {
        title = response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}

//地址搜索回调
-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response{
    NSLog(@"地址搜索 requset:%@",request);
    NSLog(@"地址搜索 response:%@",response);
    
    //清空
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
    [_pois removeAllObjects];
    
    //
    if (response.pois.count > 0) {
        _pois = [[NSMutableArray alloc] initWithArray:response.pois];
//        _pois = response.pois;
        for (int i = 0; i < _pois.count; i++) {
            //标注
            AMapPOI *poi = _pois[i];
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
            annotation.title = poi.name;
            annotation.subtitle = poi.address;
            
            [_annotations addObject:annotation];
            
            [_mapView addAnnotation:annotation];
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
