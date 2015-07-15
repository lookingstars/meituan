//
//  MAGeometry.h
//  MAMapKitDemo
//
//  Created by songjian on 12-12-21.
//  Copyright (c) 2012年 songjian. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>


#ifdef __cplusplus
extern "C" {
#endif
    
    typedef struct {
        CLLocationDegrees latitudeDelta;
        CLLocationDegrees longitudeDelta;
    } MACoordinateSpan;

    typedef struct {
        CLLocationCoordinate2D center;
        MACoordinateSpan span;
    } MACoordinateRegion;

    static inline MACoordinateSpan MACoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
    {
        return (MACoordinateSpan){latitudeDelta, longitudeDelta};
    }

    typedef struct {
        CLLocationCoordinate2D northEast;
        CLLocationCoordinate2D southWest;
    } MACoordinateBounds;

    static inline MACoordinateBounds MACoordinateBoundsMake(CLLocationCoordinate2D northEast,CLLocationCoordinate2D southWest)
    {
        return (MACoordinateBounds){northEast, southWest};
    }
    
    static inline MACoordinateRegion MACoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, MACoordinateSpan span)
    {
        return (MACoordinateRegion){centerCoordinate, span};
    }

    extern MACoordinateRegion MACoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate,
                                                                 CLLocationDistance latitudinalMeters,
                                                                 CLLocationDistance longitudinalMeters);
    
    typedef struct {
        double x;
        double y;
    } MAMapPoint;

    typedef struct {
        double width;
        double height;
    } MAMapSize;

    typedef struct {
        MAMapPoint origin;
        MAMapSize size;
    } MAMapRect;
    
    /*!
     const常量定义
     */
    extern const MAMapSize MAMapSizeWorld;
    
    extern const MAMapRect MAMapRectWorld;
    
    extern const MAMapRect MAMapRectNull;
    
    extern const MAMapRect MAMapRectZero;


    static inline BOOL MAMapRectIsNull(MAMapRect rect) {
        return isinf(rect.origin.x) || isinf(rect.origin.y);
    }
    
    static inline BOOL MAMapRectIsEmpty(MAMapRect rect) {
        return MAMapRectIsNull(rect) || (rect.size.width == 0.0 && rect.size.height == 0.0);
    }

    /*!
     @brief 经纬度转投影
     */
    extern MAMapPoint MAMapPointForCoordinate(CLLocationCoordinate2D coordinate);

    /*!
     @brief 投影转经纬度
     */
    extern CLLocationCoordinate2D MACoordinateForMapPoint(MAMapPoint mapPoint);

    /*!
     @brief 投影Rect转经纬度Rect
     */
    extern MACoordinateRegion MACoordinateRegionForMapRect(MAMapRect rect);

    /*!
     @brief 经纬度Rect转投影Rect
     */
    extern MAMapRect MAMapRectForCoordinateRegion(MACoordinateRegion region);

    static inline MAMapPoint MAMapPointMake(double x, double y)
    {
        return (MAMapPoint){x, y};
    }

    static inline MAMapSize MAMapSizeMake(double width, double height)
    {
        return (MAMapSize){width, height};
    }

    static inline MAMapRect MAMapRectMake(double x, double y, double width, double height)
    {
        return (MAMapRect){MAMapPointMake(x, y), MAMapSizeMake(width, height)};
    }

    static inline double MAMapRectGetMinX(MAMapRect rect)
    {
        return rect.origin.x;
    }

    static inline double MAMapRectGetMinY(MAMapRect rect)
    {
        return rect.origin.y;
    }

    static inline double MAMapRectGetMidX(MAMapRect rect)
    {
        return rect.origin.x + rect.size.width / 2.0;
    }

    static inline double MAMapRectGetMidY(MAMapRect rect)
    {
        return rect.origin.y + rect.size.height / 2.0;
    }

    static inline double MAMapRectGetMaxX(MAMapRect rect)
    {
        return rect.origin.x + rect.size.width;
    }

    static inline double MAMapRectGetMaxY(MAMapRect rect)
    {
        return rect.origin.y + rect.size.height;
    }

    static inline double MAMapRectGetWidth(MAMapRect rect)
    {
        return rect.size.width;
    }

    static inline double MAMapRectGetHeight(MAMapRect rect)
    {
        return rect.size.height;
    }

    /*!
     @brief 判断点是否在矩形内
     */
    extern BOOL MAMapRectContainsPoint(MAMapRect rect, MAMapPoint point);
    
    /*!
     @brief 判断两矩形是否相交
     */
    extern BOOL MAMapRectIntersectsRect(MAMapRect rect1, MAMapRect rect2);

    /*!
     @brief 判断矩形rect1是否包含矩形rect2
     */
    extern BOOL MAMapRectContainsRect(MAMapRect rect1, MAMapRect rect2);
    
    /*!
     @brief 合并两个MAMapRect
     */
    extern MAMapRect MAMapRectUnion(MAMapRect rect1, MAMapRect rect2);

    /*!
     @brief 判断点是否在圆内
     */
    extern BOOL MACircleContainsPoint(MAMapPoint point, MAMapPoint center, double radius);
    
    extern BOOL MACircleContainsCoordinate(CLLocationCoordinate2D point, CLLocationCoordinate2D center, double radius);
    
    /*!
     @brief 判断点是否在多边形内
     */
    extern BOOL MAPolygonContainsPoint(MAMapPoint point, MAMapPoint *polygon, NSUInteger count);
    
    extern BOOL MAPolygonContainsCoordinate(CLLocationCoordinate2D point, CLLocationCoordinate2D *polygon, NSUInteger count);
    
    /*!
     获取在lineStart和lineEnd组成的线段上距离point距离最近的点.
     @param lineStart 线段起点.
     @param lineEnd   线段终点.
     @param point     测试点.
     @return 距离point最近的点坐标.
     */
    extern MAMapPoint MAGetNearestMapPointFromLine(MAMapPoint lineStart, MAMapPoint lineEnd, MAMapPoint point);
    
    /*!
     @brief 单位投影的距离
     */
    extern CLLocationDistance MAMetersPerMapPointAtLatitude(CLLocationDegrees latitude);
        
    /*!
     @brief 1米对应的投影
     */
    extern double MAMapPointsPerMeterAtLatitude(CLLocationDegrees latitude);

    /*!
     @brief 投影两点之间的距离
     */
    extern CLLocationDistance MAMetersBetweenMapPoints(MAMapPoint a, MAMapPoint b);

    /*!
     @brief 经纬度间的面积(单位 平方米)
     */
    extern double MAAreaBetweenCoordinates(CLLocationCoordinate2D leftTop, CLLocationCoordinate2D rightBottom);
    
    /*!
     获取墨卡托投影切块回调block，如果是无效的映射，则返回(-1, -1, 0, 0, 0, 0).
     
     @param offsetX 左上点距离所属tile的位移X, 单位像素.
     @param offsetY 左上点距离所属tile的位移Y, 单位像素.
     @param minX    覆盖tile的最小x.
     @param maxX    覆盖tile的最大x.
     @param minY    覆盖tile的最小y.
     @param maxY    覆盖tile的最大y.
     */
    typedef void (^AMapTileProjectionBlock)(int offsetX, int offsetY, int minX, int maxX, int minY, int maxY);
    
    /*!
     根据所给经纬度区域获取墨卡托投影切块信息.
     
     @param bounds          经纬度区域.
     @param levelOfDetails  对应缩放级别, 取值0-20。
     @param tileProjection  返回的切块信息block.
     */
    extern void MAGetTileProjectionFromBounds(MACoordinateBounds bounds, int levelOfDetails, AMapTileProjectionBlock tileProjection);
    
    
#ifdef __cplusplus
}
#endif

@interface NSValue (NSValueMAGeometryExtensions)

+ (NSValue *)valueWithMAMapPoint:(MAMapPoint)mapPoint;
+ (NSValue *)valueWithMAMapSize:(MAMapSize)mapSize;
+ (NSValue *)valueWithMAMapRect:(MAMapRect)mapRect;

- (MAMapPoint)MAMapPointValue;
- (MAMapSize)MAMapSizeValue;
- (MAMapRect)MAMapRectValue;

@end

