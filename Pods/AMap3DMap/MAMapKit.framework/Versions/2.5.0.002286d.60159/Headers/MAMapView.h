//
//  MAMapView.h
//  MAMapKitDemo
//
//  Created by songjian on 12-12-21.
//  Copyright (c) 2012年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MATypes.h"
#import "MAOverlay.h"
#import "MAOverlayView.h"
#import "MAAnnotationView.h"
#import "MAAnnotation.h"
#import "MAMapStatus.h"

/**
 * MAMapView 的layer 支持中心点, 缩放级别, 旋转角度, 摄像机俯视角度. 这四个地图状态属性的CABasicAnimation, CAKeyframeAnimation.
 *
 * ***************************************************
 * 说明
 *
 * CAMediaTimingFunction 支持的类型如下:
 * 1> kCAMediaTimingFunctionLinear (default)
 * 2> kCAMediaTimingFunctionEaseIn
 * 3> kCAMediaTimingFunctionEaseOut
 * 4> kCAMediaTimingFunctionEaseInEaseOut
 *
 * CAAnimation 支持的变量如下:
 * 1> duration
 * 2> timingFunction
 * 3> delegate
 *
 * CAPropertyAnimation 支持的变量如下:
 * 1> keyPath
 *
 * CABasicAnimation 支持的变量如下:
 * 1> fromValue
 * 2> toValue
 *
 * CAKeyframeAnimation 支持的变量如下:
 * 1> values
 * 2> keyTimes
 * 3> timingFunctions
 *
 * *****************************************************
 *    Add CABasicAnimation Example:
 *
 *    CLLocationCoordinate2D toCoordiante = CLLocationCoordinate2DMake(39.989870, 116.480940);
 *    CABasicAnimation *centerAnimation = [CABasicAnimation animationWithKeyPath:kMAMapLayerCenterMapPointKey];
 *    centerAnimation.duration       = 3.f;
 *    centerAnimation.toValue        = [NSValue valueWithMAMapPoint:MAMapPointForCoordinate(toCoordiante)];
 *    centerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
 *    [mapView.layer addAnimation:centerAnimation forKey:kMAMapLayerCenterMapPointKey];
 *
 *    Add CAKeyframeAnimation Example:
 *
 *    CAKeyframeAnimation *zoomLevelAnimation = [CAKeyframeAnimation animationWithKeyPath:kMAMapLayerZoomLevelKey];
 *    zoomLevelAnimation.duration = 3.f;
 *    zoomLevelAnimation.values   = @[@(15), @(12), @(18)];
 *    zoomLevelAnimation.keyTimes = @[@(0.f), @(0.4f), @(1.f)];
 *    [mapView.layer addAnimation:zoomLevelAnimation forKey:kMAMapLayerZoomLevelKey];
 *
 *    Remove animation Example:
 *    [mapView.layer removeAnimationForKey:kMAMapLayerZoomLevelKey];
 *
 **/

/*!
 @brief 中心点(MAMapPoint)key, 封装成[NSValue valueWithMAMapPoint:].
 */
extern NSString * const kMAMapLayerCenterMapPointKey;

/*!
 @brief 缩放级别key, 范围[minZoomLevel, maxZoomLevel], 封装成NSNumber.
 */
extern NSString * const kMAMapLayerZoomLevelKey;

/*!
 @brief 旋转角度key, 范围[0, 360), 封装成NSNumber.
 */
extern NSString * const kMAMapLayerRotationDegreeKey;

/*!
 @brief 摄像机俯视角度, 范围[0, 45], 封装成NSNumber.
 */
extern NSString * const kMAMapLayerCameraDegreeKey;


enum {
	MAUserTrackingModeNone = 0, // the user's location is not followed
	MAUserTrackingModeFollow, // the map follows the user's location
	MAUserTrackingModeFollowWithHeading, // the map follows the user's location and heading
};

typedef NSInteger MAUserTrackingMode;

@class MAUserLocation;
@class MATouchPoi;
@class MACircle;

@protocol MAMapViewDelegate;

/*!
 @brief 地图view
 */
@interface MAMapView : UIView

/*!
 @brief 代理
 */
@property (nonatomic, assign) id <MAMapViewDelegate> delegate;

/*!
 @brief 地图类型
 */
@property (nonatomic) MAMapType mapType;

/*!
 @brief logo位置, 必须在mapView.bounds之内，否则会被忽略
 */
@property (nonatomic) CGPoint logoCenter;

/*!
 @brief logo的宽高
 */
@property (nonatomic, readonly) CGSize logoSize;

/*!
 @brief 是否显示底图标注
 */
@property (nonatomic, assign) BOOL showsLabels;

/*!
 @brief 是否显示交通
 */
@property (nonatomic, getter = isShowTraffic) BOOL showTraffic;

/*!
 @brief 是否隐藏楼块, 默认为NO
 */
@property (nonatomic, getter = isBuildingsDisabled) BOOL buildingsDisabled;

/*!
 @brief 是否支持缩放
 */
@property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;

/*!
 @brief 是否支持平移
 */
@property (nonatomic, getter = isScrollEnabled) BOOL scrollEnabled;

/*!
 @brief 是否支持旋转
 */
@property (nonatomic, getter = isRotateEnabled) BOOL rotateEnabled;

/*!
 @brief 是否支持单击地图获取POI信息(默认为NO)
 对应的回调是 - (void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois
 */
@property (nonatomic) BOOL touchPOIEnabled;

/*!
 @brief 设置地图旋转角度(逆时针为正向)
 */
@property (nonatomic) CGFloat rotationDegree;

/*!
 @brief 设置地图旋转角度(逆时针为正向)
 @param animated 动画
 @param duration 动画时间
 */
- (void)setRotationDegree:(CGFloat)rotationDegree animated:(BOOL)animated duration:(CFTimeInterval)duration;

/*!
 @brief 设置地图相机角度(范围为[0.f, 45.f])
 */
@property (nonatomic) CGFloat cameraDegree;

- (void)setCameraDegree:(CGFloat)cameraDegree animated:(BOOL)animated duration:(CFTimeInterval)duration;

/*!
 @brief 是否支持camera旋转
 */
@property (nonatomic, getter = isRotateCameraEnabled) BOOL rotateCameraEnabled;

/*!
 @brief 是否显示罗盘
 */
@property (nonatomic, assign) BOOL showsCompass;

/*!
 @brief 罗盘原点位置
 */
@property (nonatomic) CGPoint compassOrigin;

/*!
 @brief 罗盘的宽高
 */
@property (nonatomic, readonly) CGSize compassSize;

/*!
 @brief 设置罗盘的图片
 */
- (void)setCompassImage:(UIImage *)image;

/*!
 @brief 是否显示比例尺
 */
@property (nonatomic) BOOL showsScale;

/*!
 @brief 比例尺原点位置
 */
@property (nonatomic) CGPoint scaleOrigin;

/*!
 @brief 比例尺的最大宽高
 */
@property (nonatomic, readonly) CGSize scaleSize;

/*!
 @brief 在当前缩放级别下, 基于地图中心点, 1 screen point 对应的距离(单位是米).
 @return 对应的距离(单位是米)
 */
- (double)metersPerPointForCurrentZoomLevel;

/*!
 @brief 在指定的缩放级别下, 基于地图中心点, 1 screen point 对应的距离(单位是米).
 @param zoomLevel 指定的缩放级别, 在[minZoomLevel, maxZoomLevel]范围内.
 @return 对应的距离(单位是米)
 */
- (double)metersPerPointForZoomLevel:(CGFloat)zoomLevel;

/*!
 @brief 当前地图的经纬度范围，设定的该范围可能会被调整为适合地图窗口显示的范围
 */
@property (nonatomic) MACoordinateRegion region;
- (void)setRegion:(MACoordinateRegion)region animated:(BOOL)animated;

/*!
 @brief 当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
 */
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;

/*!
 @brief 设置地图状态
 @param animated 是否动画
 @param duration 动画时间 默认动画时间为0.35s
 */
- (void)setMapStatus:(MAMapStatus *)status
            animated:(BOOL)animated;

- (void)setMapStatus:(MAMapStatus *)status
            animated:(BOOL)animated
            duration:(CFTimeInterval)duration;

- (MAMapStatus *)getMapStatus;

/*!
 @brief 根据当前地图视图frame的大小调整region范围
 @param region 要调整的经纬度范围
 @return 调整后的经纬度范围
 */
- (MACoordinateRegion)regionThatFits:(MACoordinateRegion)region;

/*!
 @brief 可见区域
 */
@property (nonatomic) MAMapRect visibleMapRect;
- (void)setVisibleMapRect:(MAMapRect)mapRect animated:(BOOL)animated;

/*!
 @brief 缩放级别
 */
@property (nonatomic) CGFloat zoomLevel;
- (void)setZoomLevel:(CGFloat)zoomLevel animated:(BOOL)animated;

/*!
 @brief 根据指定的枢纽点来缩放地图
 @param zoomLevel 缩放级别
 @param pivot 枢纽点(基于地图view的坐标系)
 @param animated 是否动画
 */
- (void)setZoomLevel:(CGFloat)zoomLevel atPivot:(CGPoint)pivot animated:(BOOL)animated;

/*!
 @brief 最小缩放级别
 */
@property (nonatomic, readonly) CGFloat minZoomLevel;

/*!
 @brief 最大缩放级别
 */
@property (nonatomic, readonly) CGFloat maxZoomLevel;

/*!
 @brief 调整投影矩形比例
 @param mapRect 要调整的投影矩形
 @return 调整后的投影矩形
 */
- (MAMapRect)mapRectThatFits:(MAMapRect)mapRect;

/*!
 @brief 根据当前地图视图frame的大小调整投影范围
 @param mapRect 要调整的投影范围
 @return 调整后的投影范围
 */
- (void)setVisibleMapRect:(MAMapRect)mapRect edgePadding:(UIEdgeInsets)insets animated:(BOOL)animate;

/*!
 @brief 根据嵌入数据来调整投影矩形比例
 @param mapRect 要调整的投影矩形
 @param insets 嵌入数据
 @return 调整后的投影矩形
 */
- (MAMapRect)mapRectThatFits:(MAMapRect)mapRect edgePadding:(UIEdgeInsets)insets;

/*!
 @brief 将经纬度转换为指定view坐标系的坐标
 @param coordinate 经纬度
 @param view 指定的view
 @return 基于指定view坐标系的坐标
 */
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view;

/*!
 @brief 将指定view坐标系的坐标转换为经纬度
 @param point 指定view坐标系的坐标
 @param view 指定的view
 @return 经纬度
 */
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;

/*!
 @brief 将经纬度region转换为指定view坐标系的rect
 @param region 经纬度region
 @param view 指定的view
 @return 指定view坐标系的rect
 */
- (CGRect)convertRegion:(MACoordinateRegion)region toRectToView:(UIView *)view;

/*!
 @brief 将指定view坐标系的rect转换为经纬度region
 @param rect 指定view坐标系的rect
 @param view 指定的view
 @return 经纬度region
 */
- (MACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;

/*!
 @brief 是否显示用户位置
 */
@property (nonatomic) BOOL showsUserLocation;

/*!
 @brief 当前的位置数据
 */
@property (nonatomic, readonly) MAUserLocation *userLocation;

/*!
 @brief 是否自定义用户位置精度圈(userLocationAccuracyCircle)对应的 view, 默认为 NO.
 如果为YES: 会调用 - (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay 若返回nil, 则不加载.
 如果为NO : 会使用默认的样式.
 */
@property (nonatomic) BOOL customizeUserLocationAccuracyCircleRepresentation;

/*!
 @brief 用户位置精度圈 对应的overlay.
 */
@property (nonatomic, readonly) MACircle *userLocationAccuracyCircle;

/*!
 @brief 定位用户位置的模式
 */
@property (nonatomic) MAUserTrackingMode userTrackingMode;
- (void)setUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated;

/*!
 @brief 当前位置再地图中是否可见
 */
@property (nonatomic, readonly, getter=isUserLocationVisible) BOOL userLocationVisible;

/*!
 @brief 向地图窗口添加标注，需要实现MAMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 @param annotation 要添加的标注
 */
- (void)addAnnotation:(id <MAAnnotation>)annotation;

/*!
 @brief 向地图窗口添加一组标注，需要实现MAMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 @param annotations 要添加的标注数组
 */
- (void)addAnnotations:(NSArray *)annotations;

/*!
 @brief 移除标注
 @param annotation 要移除的标注
 */
- (void)removeAnnotation:(id <MAAnnotation>)annotation;

/*!
 @brief 移除一组标注
 @param annotation 要移除的标注数组
 */
- (void)removeAnnotations:(NSArray *)annotations;

/*!
 @brief 标注数组
 */
@property (nonatomic, readonly) NSArray *annotations;

/*!
 @brief 获取指定投影矩形范围内的标注
 @param mapRect 投影矩形范围
 @return 标注集合
 */
- (NSSet *)annotationsInMapRect:(MAMapRect)mapRect;

/*!
 @brief 根据标注数据过去标注view
 @param annotation 标注数据
 @return 对应的标注view
 */
- (MAAnnotationView *)viewForAnnotation:(id <MAAnnotation>)annotation;

/*!
 @brief 从复用内存池中获取制定复用标识的annotation view
 @param identifier 复用标识
 @return annotation view
 */
- (MAAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;

/*!
 @brief 选中标注数据对应的view
 @param annotation 标注数据
 @param animated 是否有动画效果
 */
- (void)selectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated;

/*!
 @brief 取消选中标注数据对应的view
 @param annotation 标注数据
 @param animated 是否有动画效果
 */
- (void)deselectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated;

/*!
 @brief 处于选中状态的标注数据数据(其count == 0 或 1)
 */
@property (nonatomic, copy) NSArray *selectedAnnotations;

/*!
 @brief annotation 可见区域
 */
@property (nonatomic, readonly) CGRect annotationVisibleRect;

/*!
 @brief 设置地图使其可以显示数组中所有的annotation。
 */
- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated;

@end

/*!
 @brief 绘制overlay的层级
 */
typedef NS_ENUM(NSInteger, MAOverlayLevel) {
    MAOverlayLevelAboveRoads = 0, // 在地图底图标注和兴趣点图标之下绘制overlay
    MAOverlayLevelAboveLabels // 在地图底图标注和兴趣点图标之上绘制overlay
};

/*!
 @brief 地图view关于overlay类别
 */
@interface MAMapView (OverlaysAPI)

/*!
 @brief Overlay数组
 */
@property (nonatomic, readonly) NSArray *overlays;

/*!
 @brief 取位于level下的overlays
*/
- (NSArray *)overlaysInLevel:(MAOverlayLevel)level;

/*!
 @brief 向地图窗口添加Overlay。
        需要实现MAMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View。
        默认添加层级：MAGroundOverlay默认层级为MAOverlayLevelAboveRoads，其余overlay类型默认层级为MAOverlayLevelAboveLabels
 @param overlay 要添加的overlay
 */
- (void)addOverlay:(id <MAOverlay>)overlay;

/*!
 @brief 向地图窗口添加一组Overlay，需要实现MAMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
        默认添加层级：MAOverlayLevelAboveLabels

 @param overlays 要添加的overlay数组
 */
- (void)addOverlays:(NSArray *)overlays;

/*!
 @brief 向地图窗口添加Overlay，需要实现MAMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 @param overlay 要添加的overlay
 @param level 添加的overlay所在层级
 */
- (void)addOverlay:(id <MAOverlay>)overlay level:(MAOverlayLevel)level;

/*!
 @brief 向地图窗口添加一组Overlay，需要实现MAMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 @param overlays 要添加的overlay数组
 @param level 添加的overlay所在层级
 */
- (void)addOverlays:(NSArray *)overlays level:(MAOverlayLevel)level;

/*!
 @brief 移除Overlay
 @param overlay 要移除的overlay
 */
- (void)removeOverlay:(id <MAOverlay>)overlay;

/*!
 @brief 移除一组Overlay
 @param overlays 要移除的overlay数组
 */
- (void)removeOverlays:(NSArray *)overlays;

/*!
 @brief 在指定层级的指定的索引处添加一个Overlay
 @param overlay 要添加的overlay
 @param index 指定的索引
 @param level 指定的层级
 
 注：各个层级的索引分开计数；
    若index大于level层级的最大索引，则添加至level层级的最大索引之后。
 */
- (void)insertOverlay:(id <MAOverlay>)overlay atIndex:(NSUInteger)index level:(MAOverlayLevel)level;

/*!
 @brief 在指定的Overlay之上插入一个overlay
 @param overlay 带添加的Overlay
 @param sibling 用于指定相对位置的Overlay
 */
- (void)insertOverlay:(id <MAOverlay>)overlay aboveOverlay:(id <MAOverlay>)sibling;

/*!
 @brief 在指定的Overlay之下插入一个overlay
 @param overlay 带添加的Overlay
 @param sibling 用于指定相对位置的Overlay
 */
- (void)insertOverlay:(id <MAOverlay>)overlay belowOverlay:(id <MAOverlay>)sibling;

/*!
 @brief 在指定的索引处添加一个Overlay
 @param overlay 要添加的overlay
 @param index 指定的索引
 */
- (void)insertOverlay:(id <MAOverlay>)overlay atIndex:(NSUInteger)index;

/*!
 @brief 交换指定索引处的Overlay
 @param index1 索引1
 @param index2 索引2
 */
- (void)exchangeOverlayAtIndex:(NSUInteger)index1 withOverlayAtIndex:(NSUInteger)index2;

/*!
 @brief 交换两个overlay
 @param overlay1
 @param overlay2
*/
- (void)exchangeOverlay:(id <MAOverlay>)overlay1 withOverlay:(id <MAOverlay>)overlay2;

/*!
 @brief 查找指定overlay对应的View，如果该View尚未创建，返回nil
 @param overlay 指定的overlay
 @return 指定overlay对应的View
 */
- (MAOverlayView *)viewForOverlay:(id <MAOverlay>)overlay;

@end

/*!
 @brief 地图view关于截图的类别
 */
@interface MAMapView (Snapshot)

/*!
 @brief 在指定区域内截图(默认会包含该区域内的annotationView)
 @param rect 指定的区域
 @return 截图image
 */
- (UIImage *)takeSnapshotInRect:(CGRect)rect;

@end

/*!
 @brief 地图view关于离线下载的类别
 */
@interface MAMapView (Offline)

/*!
 @brief 将离线地图解压到 Documents/3dvmap/ 目录下后，调用此函数使离线数据生效,
 对应的回调分别是 offlineDataWillReload:(MAMapView *)mapView, offlineDataDidReload:(MAMapView *)mapView.
 */
- (void)reloadMap;

@end

@interface MAMapView (OpenGLES)

/*!
 @brief 停止/开启 OpenGLES 指令绘制操作
 对应的回调是 - (void)mapView:(MAMapView *)mapView didChangeOpenGLESDisabled:(BOOL)openGLESDisabled
 */
@property (nonatomic) BOOL openGLESDisabled;

@end

/*!
 @brief 定位相关参数的类别
 */
@interface MAMapView (LocationOption)

/*!
 @brief 设定定位的最小更新距离。默认为kCLDistanceFilterNone，会提示任何移动。
 */
@property(nonatomic) CLLocationDistance distanceFilter;

/*!
 @brief 设定定位精度。默认为kCLLocationAccuracyBest。
 */
@property(nonatomic) CLLocationAccuracy desiredAccuracy;

/*!
 @brief 设定最小更新角度。默认为1度，设定为kCLHeadingFilterNone会提示任何角度改变。
 */
@property(nonatomic) CLLocationDegrees headingFilter;

/**
 *  指定定位是否会被系统自动暂停。默认为YES。只在iOS 6.0之后起作用。
 */
@property(nonatomic) BOOL pausesLocationUpdatesAutomatically;

@end

/*!
 @brief 地图view的delegate
 */
@protocol MAMapViewDelegate <NSObject>
@optional

/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

/*!
 @brief 地图开始加载
 @param mapview 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView;

/*!
 @brief 地图加载成功
 @param mapView 地图View
 @param dataSize 数据大小
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView dataSize:(NSInteger)dataSize;

/*!
 @brief 地图加载失败
 @param mapView 地图View
 @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error;

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation;

/*!
 @brief 当mapView新添加annotation views时，调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

/*!
 @brief 当选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view;

/*!
 @brief 当取消选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view;

/*!
 @brief 在地图View将要启动定位时，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView;

/*!
 @brief 在地图View停止定位后，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView;

/*!
 @brief 位置或者设备方向更新后，会调用此函数, 这个回调已废弃由 -(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation 来替代
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation __attribute__ ((deprecated("use -(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation instead")));

/*!
 @brief 位置或者设备方向更新后，会调用此函数
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

/*!
 @brief 定位失败后，会调用此函数
 @param mapView 地图View
 @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error;

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
fromOldState:(MAAnnotationViewDragState)oldState;

/*!
 @brief 根据overlay生成对应的View
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay;

/*!
 @brief 当mapView新添加overlay views时，调用此接口
 @param mapView 地图View
 @param overlayViews 新添加的overlay views
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews;

/*!
 @brief 标注view的accessory view(必须继承自UIControl)被点击时，触发该回调
 @param mapView 地图View
 @param annotationView callout所属的标注view
 @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

/*!
 @brief 当userTrackingMode改变时，调用此接口
 @param mapView 地图View
 @param mode 改变后的mode
 @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated;

/*!
 @brief 离线地图数据将要被加载, 调用reloadMap会触发该回调，离线数据生效前的回调.
 @param mapview 地图View
 */
- (void)offlineDataWillReload:(MAMapView *)mapView;

/*!
 @brief 离线地图数据加载完成, 调用reloadMap会触发该回调，离线数据生效后的回调.
 @param mapview 地图View
 */
- (void)offlineDataDidReload:(MAMapView *)mapView;

/*!
 @brief 当openGLESDisabled变量改变时，调用此接口
 @param mapView 地图View
 @param mode 改变后的openGLESDisabled
 */
- (void)mapView:(MAMapView *)mapView didChangeOpenGLESDisabled:(BOOL)openGLESDisabled;

/*!
 @brief 当touchPOIEnabled == YES时，单击地图使用该回调获取POI信息
 @param mapView 地图View
 @param pois 获取到的poi数组(由MATouchPoi组成)
 */
- (void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois;

@end
