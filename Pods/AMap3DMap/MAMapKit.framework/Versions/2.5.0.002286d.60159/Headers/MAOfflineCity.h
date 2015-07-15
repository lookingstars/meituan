//
//  MAOfflineCity.h
//
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAOfflineItem.h"

typedef enum{
    MAOfflineCityStatusNone      __attribute__((deprecated("use MAOfflineItemStatusNone instead")))         = MAOfflineItemStatusNone,      /* 不存在. */
    MAOfflineCityStatusCached    __attribute__((deprecated("use MAOfflineItemStatusCached instead")))       = MAOfflineItemStatusCached,    /* 缓存状态. */
    MAOfflineCityStatusInstalled __attribute__((deprecated("use MAOfflineItemStatusInstalled instead")))    = MAOfflineItemStatusInstalled, /* 已安装. */
    MAOfflineCityStatusExpired   __attribute__((deprecated("use MAOfflineItemStatusExpired instead")))      = MAOfflineItemStatusExpired    /* 已过期. */
}MAOfflineCityStatus;

@interface MAOfflineCity : MAOfflineItem

/*!
 @brief 城市编码
 */
@property (nonatomic, copy, readonly) NSString *cityCode;

/*!
 @brief 城市名称
 */
@property (nonatomic, copy, readonly) NSString *cityName __attribute__ ((deprecated("use name instead")));

/*!
 @brief 下载地址
 */
@property (nonatomic, copy, readonly) NSString *urlString __attribute__ ((deprecated("Not supported in future version")));

/*!
 @brief 离线数据状态
 */
@property (nonatomic, assign, readonly) MAOfflineCityStatus status __attribute__ ((deprecated("use itemStatus instead")));

@end
