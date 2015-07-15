//
//  MATouchPoi.h
//  MapKit_static
//
//  Created by songjian on 13-7-17.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MATouchPoi : NSObject

/*!
 @brief 名称
 */
@property (nonatomic, copy, readonly) NSString *name;

/*!
 @brief 经纬度坐标
 */
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

@end
