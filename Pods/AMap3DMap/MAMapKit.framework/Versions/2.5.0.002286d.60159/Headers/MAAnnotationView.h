//
//  MAAnnotationView.h
//  MAMapKitDemo
//
//  Created by songjian on 13-1-7.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#if (__IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED)

enum {
    MAAnnotationViewDragStateNone = 0,      // View is at rest, sitting on the map.
    MAAnnotationViewDragStateStarting,      // View is beginning to drag (e.g. pin lift)
    MAAnnotationViewDragStateDragging,      // View is dragging ("lift" animations are complete)
    MAAnnotationViewDragStateCanceling,     // View was not dragged and should return to it's starting position (e.g. pin drop)
    MAAnnotationViewDragStateEnding         // View was dragged, new coordinate is set and view should return to resting position (e.g. pin drop)
};

typedef NSUInteger MAAnnotationViewDragState;

#endif // #if (__IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED)

@class MAAnnotationViewInternal;
@protocol MAAnnotation;

/*!
 @brief 标注view
 */
@interface MAAnnotationView : UIView

/*!
 @brief 初始化并返回一个annotation view
 @param annotation 关联的annotation对象
 @param reuseIdentifier 如果要重用view,传入一个字符串,否则设为nil,建议重用view
 @return 初始化成功则返回annotation view,否则返回nil
 */
- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

/*!
 @brief 复用标识
 */
@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

/*!
 @brief 当从reuse队列里取出时被调用
 */
- (void)prepareForReuse;

/*!
 @brief 关联的annotation
 */
@property (nonatomic, strong) id <MAAnnotation> annotation;

/*!
 @brief 显示的image
 */
@property (nonatomic, strong) UIImage *image;

/*!
 @brief 默认情况下, annotation view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
 */
@property (nonatomic) CGPoint centerOffset;

/*!
 @brief 默认情况下, 弹出的气泡位于view正中上方，可以设置calloutOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
 */
@property (nonatomic) CGPoint calloutOffset;

/*!
 @brief 默认为YES,当为NO时view忽略触摸事件
 */
@property (nonatomic, getter=isEnabled) BOOL enabled;

@property (nonatomic, getter=isHighlighted) BOOL highlighted;

/*!
 @brief 设置是否处于选中状态
 */
@property (nonatomic, getter=isSelected) BOOL selected;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@property (nonatomic) BOOL canShowCallout;

/*!
 @brief 显示在气泡左侧的view
 */
@property (strong, nonatomic) UIView *leftCalloutAccessoryView;

/*!
 @brief 显示在气泡右侧的view
 */
@property (strong, nonatomic) UIView *rightCalloutAccessoryView;

/*!
 @brief 是否支持拖动
 */
@property (nonatomic, getter=isDraggable) BOOL draggable NS_AVAILABLE(NA, 4_0);

/*!
 @brief 当前view的拖动状态
 */
@property (nonatomic) MAAnnotationViewDragState dragState NS_AVAILABLE(NA, 4_0);
- (void)setDragState:(MAAnnotationViewDragState)newDragState animated:(BOOL)animated NS_AVAILABLE(NA, 4_2);

@end
