//
//  MAOverlayPathView.h
//  MAMapKit
//
//
//  Copyright (c) 2011年 Autonavi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAOverlayView.h"
#import "MALineDrawType.h"

/*!
 @brief 该类提供使用CGPathRef来绘制overlay,默认的操作是将fill attributes, stroke attributes设置到CAShapeLayer中, 可以使用该类的子类MACircleView, MAPolylineView, MAPolygonView或者继承该类, 如果继承该类，需要重载-(void)createPath方法
 */
@interface MAOverlayPathView : MAOverlayView

/*!
 @brief 填充颜色,默认是kMAOverlayViewDefaultFillColor
 */
@property (retain) UIColor *fillColor;

/*!
 @brief 笔触颜色,默认是kMAOverlayViewDefaultStrokeColor
 */
@property (retain) UIColor *strokeColor;

/*!
 @brief 笔触宽度,默认是0
 */
@property CGFloat lineWidth;

/*!
 @brief LineJoin,默认是kMALineJoinBevel
 */
@property MALineJoinType lineJoinType;

/*!
 @brief LineCap,默认是kMALineCapButt
 */
@property MALineCapType lineCapType;

/*!
 @brief MiterLimit,默认是10.f
 */
@property CGFloat miterLimit;

/*!
 @brief 是否绘制成虚线, 默认是NO
 */
@property BOOL lineDash;

#pragma mark - Deprecated

/*!
 @brief LineJoin,默认是kCGLineJoinRound
 */
@property CGLineJoin lineJoin __attribute__ ((deprecated("not workable. use lineJoinType")));

/*!
 @brief LineCap,默认是kCGLineCapRound
 */
@property CGLineCap lineCap __attribute__ ((deprecated("not workable. use lineCapType")));

/*!
 @brief LineDashPhase,默认是0.f
 */
@property CGFloat lineDashPhase __attribute__ ((deprecated("not workable")));

/*!
 @brief LineDashPattern,默认是nil
 */
@property (copy) NSArray *lineDashPattern __attribute__ ((deprecated("not workable")));

/*!
 @brief 子类需要重载该方法并设置(self.path = newPath)
 */
- (void)createPath __attribute__ ((deprecated("not workable")));

/*!
 @brief 当前的path
 */
@property CGPathRef path __attribute__ ((deprecated("not workable")));

/*!
 @brief 释放当前path,调用之后 path == NULL
 */
- (void)invalidatePath __attribute__ ((deprecated("not workable")));

/*!
 @brief 将当前的stroke attributes设置到指定的context
 @param context 目标context
 @param zoomScale 当前缩放比例值
 */
- (void)applyStrokePropertiesToContext:(CGContextRef)context atZoomScale:(CGFloat)zoomScale __attribute__ ((deprecated("not workable")));

/*!
 @brief 将当前的fill attributes设置到指定的context
 @param context 目标context
 @param zoomScale 当前缩放比例值
 */
- (void)applyFillPropertiesToContext:(CGContextRef)context atZoomScale:(CGFloat)zoomScale __attribute__ ((deprecated("not workable")));

/*!
 @brief 绘制path
 @param path 要绘制的path
 @param context 目标context
 */
- (void)strokePath:(CGPathRef)path inContext:(CGContextRef)context __attribute__ ((deprecated("not workable")));

/*!
 @brief 填充path
 @param path 要绘制的path
 @param context 目标context
 */
- (void)fillPath:(CGPathRef)path inContext:(CGContextRef)context __attribute__ ((deprecated("not workable")));

@end
