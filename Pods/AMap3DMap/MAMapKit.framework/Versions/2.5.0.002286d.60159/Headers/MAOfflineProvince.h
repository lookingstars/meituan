//
//  MAOfflineProvince.h
//  MapKit_static
//
//  Created by songjian on 14-4-24.
//  Copyright (c) 2014年 songjian. All rights reserved.
//

#import "MAOfflineItem.h"
#import "MAOfflineItemCommonCity.h"

@interface MAOfflineProvince : MAOfflineItem

/* 包含的城市数组(都是MAOfflineItemCommonCity类型). */
@property (nonatomic, strong, readonly) NSArray *cities;

@end
