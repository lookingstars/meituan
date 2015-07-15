//
//  MAPolylineView.h
//  MAMapKit
//
//  
//  Copyright (c) 2011年 Autonavi Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "MAPolyline.h"
#import "MAOverlayPathView.h"

/*!
 @brief 此类是MAPolyline的显示多段线view,可以通过MAOverlayPathView修改其fill和stroke attributes
 */
@interface MAPolylineView : MAOverlayPathView

/*!
 @brief 根据指定的MAPolyline生成一个多段线view
 @param polyline 指定MAPolyline
 @return 新生成的多段线View
 */
- (id)initWithPolyline:(MAPolyline *)polyline;

/*!
 @brief 关联的MAPolyline model
 */
@property (nonatomic, readonly) MAPolyline *polyline;

@end
