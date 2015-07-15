//
//  MANavigation.h
//  MapKit_static
//
//  Created by yi chen on 3/16/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*!
 @brief 导航策略
 */
typedef NS_ENUM(NSInteger, MADrivingStrategy) {
    MADrivingStrategyFastest  = 0, //速度最快
    MADrivingStrategyMinFare  = 1, //避免收费
    MADrivingStrategyShortest = 2, //距离最短
    
    MADrivingStrategyNoHighways   = 3, //不走高速
    MADrivingStrategyAvoidCongestion = 4, //躲避拥堵
    
    MADrivingStrategyAvoidHighwaysAndFare    = 5, //不走高速且避免收费
    MADrivingStrategyAvoidHighwaysAndCongestion = 6, //不走高速且躲避拥堵
    MADrivingStrategyAvoidFareAndCongestion  = 7, //躲避收费和拥堵
    MADrivingStrategyAvoidHighwaysAndFareAndCongestion = 8 //不走高速躲避收费和拥堵
};


@interface MANaviConfig : NSObject

/*!
 @brief 终点
 */
@property (nonatomic, assign) CLLocationCoordinate2D destination;

/*!
 @brief 应用返回的Scheme
 */
@property (nonatomic, retain) NSString * appScheme;

/*!
 @brief 应用名称
 */
@property (nonatomic, retain) NSString * appName;

/*!
 @brief 导航策略
 */
@property (nonatomic, assign) MADrivingStrategy style;

@end


@interface MANavigation : NSObject

/*!
 @brief 调起高德地图app驾车导航
 @param config 配置参数
 @return 是否成功。若为YES则成功调起，若为NO则无法调起，可使用+ (void)getLatestAMapApp;方法获取最新版高德地图app
 */
+ (BOOL)openAMapNavigation:(MANaviConfig *)config;

/*!
 @brief 打开高德地图AppStore页面
 */
+ (void)getLatestAMapApp;

@end
