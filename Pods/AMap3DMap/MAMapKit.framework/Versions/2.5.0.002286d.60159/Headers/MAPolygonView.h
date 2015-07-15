//
//  MAPolygonView.h
//  MAMapKit
//
//  
//  Copyright (c) 2011年 Autonavi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MAPolygon.h"
#import "MAOverlayPathView.h"

/*!
 @brief 此类是MAPolygon的显示多边形view,可以通过MAOverlayPathView修改其fill和stroke attributes
 */
@interface MAPolygonView : MAOverlayPathView

/*!
 @brief 根据指定的多边形生成一个多边形View
 @param polygon 指定的多边形数据对象
 @return 新生成的多边形View
 */
- (id)initWithPolygon:(MAPolygon *)polygon;

/*!
 @brief 关联的MAPolygon model
 */
@property (nonatomic, readonly) MAPolygon *polygon;

@end