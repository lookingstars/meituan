//
//  MAPinAnnotationView.h
//  MAMapKitDemo
//
//  Created by songjian on 13-1-7.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "MAMapKit.h"

typedef NS_ENUM(NSUInteger, MAPinAnnotationColor){
    MAPinAnnotationColorRed = 0,
    MAPinAnnotationColorGreen,
    MAPinAnnotationColorPurple
};
//typedef NSUInteger MAPinAnnotationColor;

/*!
 @brief 提供类似大头针效果的annotation view
 */
@interface MAPinAnnotationView : MAAnnotationView

/*!
 @brief 大头针的颜色，有MAPinAnnotationColorRed, MAPinAnnotationColorGreen, MAPinAnnotationColorPurple三种
 */
@property (nonatomic) MAPinAnnotationColor pinColor;

/*!
 @brief 动画效果
 */
@property (nonatomic) BOOL animatesDrop;

@end
