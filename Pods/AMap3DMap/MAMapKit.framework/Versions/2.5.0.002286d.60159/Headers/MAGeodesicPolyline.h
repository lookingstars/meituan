//
//  MAGeodesicPolyline.h
//  MapKit_static
//
//  Created by songjian on 13-10-23.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "MAPolyline.h"

@interface MAGeodesicPolyline : MAPolyline

+ (instancetype)polylineWithPoints:(MAMapPoint *)points count:(NSUInteger)count;
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

@end
