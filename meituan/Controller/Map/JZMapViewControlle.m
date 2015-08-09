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
#import "NetworkSingleton.h"
#import "CustomAnnotationView.h"

#import "JZMAAroundAnnotation.h"
#import "JZMAAroundModel.h"
#import "MJExtension.h"

#define kDefaultCalloutViewMargin       -8
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAroundMerchantData];
    });
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


//请求数据
//请求分类数据
-(void)getGroupData{
    NSString *urlStr = @"http://api.meituan.com/group/v2/deal/cate-show-list?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=ZcDSShW9Lc%2BTgbSrYF1Zt8hpdnc%3D&__skno=BD01BF5A-9B25-4152-898D-FC8D29B025A8&__skts=1436947023.082103&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&cityId=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage_map&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
}

//获取附近商家列表
-(void)getAroundMerchantData{
    //取100组
    NSString *urlStr = @"http://api.meituan.com/group/v1/deal/select/position/39.983478,116.318049/cate/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=ji%2BV3hnRG9MHGaryLpiFV9Fiw5o%3D&__skno=1F082187-597D-4636-B088-B54186954C10&__skts=1436951992.642581&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&distance=2051&fields=slug%2Ccate%2Csubcate%2Crdplocs%2Cimgurl%2Ctitle%2Csmstitle%2Cprice%2Cbrandname%2Cmname%2Crating%2Crate-count%2Capplelottery%2Cid&limit=30&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&mypos=39.983478%2C116.318049&offset=0&sort=defaults&ste=_b0&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage_map&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    
    [[NetworkSingleton sharedManager] getAroundMerchantResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"地图：获取附近商家成功");
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        if (dataArray.count>0) {
            
            [_mapView removeAnnotations:_annotations];
            [_annotations removeAllObjects];

            
            
            for (int i = 0; i < dataArray.count; i++) {
                JZMAAroundModel *jzmaaroundM = [JZMAAroundModel objectWithKeyValues:dataArray[i]];
                //创建annotation
                
                JZMAAroundAnnotation *annotation = [[JZMAAroundAnnotation alloc] init];
                
                annotation.jzmaaroundM = jzmaaroundM;
                annotation.title = jzmaaroundM.mname;
                annotation.subtitle = [NSString stringWithFormat:@"%@元",jzmaaroundM.price];
                annotation.coordinate = CLLocationCoordinate2DMake(LATITUDE_DEFAULT, LONGITUDE_DEFAULT);
                if (jzmaaroundM.rdplocs.count>0) {
                    NSDictionary *dic = jzmaaroundM.rdplocs[0];
                    NSNumber *lat = [dic objectForKey:@"lat"];
                    NSNumber *lng = [dic objectForKey:@"lng"];
                    annotation.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
                }
                [_annotations addObject:annotation];
//                [_mapView addAnnotation:annotation];
                
            }
            [self performSelectorOnMainThread:@selector(updateUI)withObject:_annotations waitUntilDone:YES];
        }
    } failureBlock:^(NSString *error){
        NSLog(@"地图：获取附近商家失败:%@",error);
    }];
}

-(void)updateUI{
    NSLog(@"个数:%ld",_annotations.count);
    for (int i = 0; i < _annotations.count; i++) {
        [_mapView addAnnotation:_annotations[i]];
    }
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
    
    
    // 调整自定义callout的位置，使其可以完全显示
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:_mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin));
        
        if (!CGRectContainsRect(_mapView.frame, frame))
        {
            CGSize offset = [self offsetToContainRect:frame inRect:_mapView.frame];
            
            CGPoint theCenter = _mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }

}

//显示地图标示view  大头针
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        if ([annotation isKindOfClass:[JZMAAroundAnnotation class]]){
            annotationView.jzAnnotation = (JZMAAroundAnnotation *)annotation;
        }
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"icon_map_cateid_1"];
        // 设置中⼼心点偏移,使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
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
    
    //清空
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
    [_pois removeAllObjects];
    
    //
    if (response.pois.count > 0) {
        _pois = [[NSMutableArray alloc] initWithArray:response.pois];
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





#pragma mark - Helpers

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
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
