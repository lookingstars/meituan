//
//  MAMapStatus.h
//  MapKit_static
//
//  Created by yi chen on 1/27/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

@interface MAMapStatus : NSObject

/*!
 @brief 地图的中心点，改变该值时，地图的比例尺级别不会发生变化
 */
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;

/*!
 @brief 缩放级别
 */
@property (nonatomic) CGFloat zoomLevel;
/*!
 @brief 设置地图旋转角度(逆时针为正向)
 */
@property (nonatomic) CGFloat rotationDegree;
/*!
 @brief 设置地图相机角度(范围为[0.f, 45.f])
 */
@property (nonatomic) CGFloat cameraDegree;

/*!
 @brief 地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心。
 */
@property (nonatomic) CGPoint screenAnchor;

/*!
 @brief 根据指定参数生成对应的status
 @param coordinate 地图的中心点，改变该值时，地图的比例尺级别不会发生变化
 @param zoomLevel 缩放级别
 @param rotationDegree 设置地图旋转角度(逆时针为正向)
 @param cameraDegree 设置地图相机角度(范围为[0.f, 45.f])
 @param screenAnchor 地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心。
 @return 生成的Status
 */
+ (instancetype)statusWithCenterCoordinate:(CLLocationCoordinate2D)coordinate
                                 zoomLevel:(CGFloat)zoomLevel
                            rotationDegree:(CGFloat)rotationDegree
                              cameraDegree:(CGFloat)cameraDegree
                              screenAnchor:(CGPoint)screenAnchor;

/*!
 @brief 根据指定参数初始化对应的status
 @param coordinate 地图的中心点，改变该值时，地图的比例尺级别不会发生变化
 @param zoomLevel 缩放级别
 @param rotationDegree 设置地图旋转角度(逆时针为正向)
 @param cameraDegree 设置地图相机角度(范围为[0.f, 45.f])
 @param screenAnchor 地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心。
 @return 生成的Status
 */
- (id)initWithCenterCoordinate:(CLLocationCoordinate2D)coordinate
                     zoomLevel:(CGFloat)zoomLevel
                rotationDegree:(CGFloat)rotationDegree
                  cameraDegree:(CGFloat)cameraDegree
                  screenAnchor:(CGPoint)screenAnchor;

@end
