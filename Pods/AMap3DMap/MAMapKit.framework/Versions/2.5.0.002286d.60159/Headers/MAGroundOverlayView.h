//
//  MAGroundOverlayView.h
//  MapKit_static
//
//  Created by Li Fei on 11/13/13.
//  Copyright (c) 2013 songjian. All rights reserved.
//

#import "MAOverlayView.h"
#import "MAGroundOverlay.h"

/*!
 @brief 此类是将MAGroundOverlay中的覆盖图片显示在地图上的view;
 */
@interface MAGroundOverlayView : MAOverlayView

/*!
 @brief groundOverlay 具有覆盖图片，以及图片覆盖的区域
 */
@property (nonatomic ,readonly) MAGroundOverlay *groundOverlay;

/*!
 @brief 根据指定的GroundOverlay生成将图片显示在地图上View
 @param groundOverlay 制定了覆盖图片，以及图片的覆盖区域的groundOverlay
 @return 以GroundOverlay新生成View
 */
- (id)initWithGroundOverlay:(MAGroundOverlay *)groundOverlay;

@end
