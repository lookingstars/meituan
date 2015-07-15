//
//  MATileOverlayView.h
//  MapKit_static
//
//  Created by Li Fei on 11/25/13.
//  Copyright (c) 2013 songjian. All rights reserved.
//

#import "MAOverlayView.h"
#import "MATileOverlay.h"

/*!
 @brief 此类是将MAOverlayView中的覆盖tiles显示在地图上的view;
 */
@interface MATileOverlayView : MAOverlayView

/*!
 @brief 覆盖在球面墨卡托投影上的图片tiles的数据源
 */
@property (nonatomic ,readonly) MATileOverlay *tileOverlay;

/*!
 @brief 根据指定的tileOverlay生成将tiles显示在地图上的View
 @param tileOverlay 制定了覆盖图片，以及图片的覆盖区域的groundOverlay
 @return 以tileOverlay新生成View
 */
- (id)initWithTileOverlay:(MATileOverlay *)tileOverlay;

@end
