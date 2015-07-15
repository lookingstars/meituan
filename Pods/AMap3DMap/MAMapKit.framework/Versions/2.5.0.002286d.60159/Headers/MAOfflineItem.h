//
//  MAOfflineItem.h
//  MapKit_static
//
//  Created by songjian on 14-4-23.
//  Copyright (c) 2014年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MAOfflineItemStatusNone = 0,    /* 不存在. */
    MAOfflineItemStatusCached,      /* 缓存状态. */
    MAOfflineItemStatusInstalled,   /* 已安装. */
    MAOfflineItemStatusExpired      /* 已过期. */
}MAOfflineItemStatus;

@interface MAOfflineItem : NSObject

/* 名字. */
@property (nonatomic, copy, readonly) NSString *name;

/* 简拼. */
@property (nonatomic, copy, readonly) NSString *jianpin;

/* 拼音. */
@property (nonatomic, copy, readonly) NSString *pinyin;

/* 区域编码. */
@property (nonatomic, copy, readonly) NSString *adcode;

/* 离线数据大小. */
@property (nonatomic, assign, readonly) long long size;

/* 状态. */
@property (nonatomic, assign, readonly) MAOfflineItemStatus itemStatus;

/* 已下载大小(当itemStatus == MAOfflineItemStatusCached 时有效). */
@property (nonatomic, assign, readonly) long long downloadedSize;

@end
