//
//  MAOfflineMap.h
//
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAOfflineProvince.h"
#import "MAOfflineItemNationWide.h"
#import "MAOfflineItemMunicipality.h"

typedef enum{
    MAOfflineMapDownloadStatusWaiting,       /* 以插入队列，等待中. */
    MAOfflineMapDownloadStatusStart,         /* 开始下载. */
    MAOfflineMapDownloadStatusProgress,      /* 下载过程中. */
    MAOfflineMapDownloadStatusCompleted,     /* 下载成功. */
    MAOfflineMapDownloadStatusCancelled,     /* 取消. */
    MAOfflineMapDownloadStatusUnzip,         /* 解压缩. */
    MAOfflineMapDownloadStatusFinished,      /* 全部顺利完成. */
    MAOfflineMapDownloadStatusError          /* 发生错误. */
}MAOfflineMapDownloadStatus;

/* 离线下载错误domain. */
extern NSString * const MAOfflineMapErrorDomain;

enum{
  /* 未知的错误. */
  MAOfflineMapErrorUnknown = -1,

  /* 写入临时目录失败. */
  MAOfflineMapErrorCannotWriteToTmp = -2,
    
  /* 打开归档文件失败. */
  MAOfflineMapErrorCannotOpenZipFile = -3,
    
  /* 解归档文件失败. */
  MAOfflineMapErrorCannotExpand = -4
};

/* 当downloadStatus == MAOfflineMapDownloadStatusProgress 时, info参数是个NSDictionary,
 如下两个key用来获取已下载和总和的数据大小(单位byte), 对应的是NSNumber(long long) 类型. */
extern NSString * const MAOfflineMapDownloadReceivedSizeKey;
extern NSString * const MAOfflineMapDownloadExpectedSizeKey;

typedef void(^MAOfflineMapDownloadBlock)(MAOfflineMapDownloadStatus downloadStatus, id info);
typedef void(^MAOfflineMapNewestVersionBlock)(BOOL hasNewestVersion);

@interface MAOfflineMap : NSObject

/*!
 @brief 获取MAOfflineMap 单例
 @return MAOfflineMap
 */
+ (MAOfflineMap *)sharedOfflineMap;

/*!
 @brief 省份数组(每个元素均是MAOfflineProvince类型)
 */
@property (nonatomic, readonly) NSArray *provinces;

/*!
 @brief 直辖市数组(每个元素均是MAOfflineItemMunicipality类型)
 */
@property (nonatomic, readonly) NSArray *municipalities;

/*!
 @brief 全国概要图
 */
@property (nonatomic, readonly) MAOfflineItemNationWide *nationWide;

/*!
 @brief 城市数组, 包括普通城市与直辖市.
 */
@property (nonatomic, readonly) NSArray *cities;

/*!
 @brief 离线数据的版本号(由年月日组成, 如@"20130715")
 */
@property (nonatomic, readonly) NSString *version;

/*!
 @brief 启动下载
 @param item 数据
 @prarm shouldContinueWhenAppEntersBackground 进入后台是否允许继续下载
 @param downloadBlock 下载过程block
 */
- (void)downloadItem:(MAOfflineItem *)item shouldContinueWhenAppEntersBackground:(BOOL)shouldContinueWhenAppEntersBackground downloadBlock:(MAOfflineMapDownloadBlock)downloadBlock;

/*!
 @brief 监测是否正在下载
 @param item 条目
 @return 是否在下载
 */
- (BOOL)isDownloadingForItem:(MAOfflineItem *)item;

/*!
 @brief 暂停下载
 @param item 条目
 */
- (void)pauseItem:(MAOfflineItem *)item;

/*!
 @brief 取消全部下载
 */
- (void)cancelAll;

/*!
 @brief 清除所有在磁盘上的离线地图数据, 之后调用[mapView reloadMap]会使其立即生效.
 */
- (void)clearDisk;

/*!
 @brief 监测新版本
 @param newestVersionBlock 回调block
 */
- (void)checkNewestVersion:(MAOfflineMapNewestVersionBlock)newestVersionBlock;

@end

@interface MAOfflineMap (Deprecated)

/*!
 @brief 城市数组(每个元素均是MAOfflineCity类型)
 */
@property (nonatomic, readonly) NSArray *offlineCities __attribute__ ((deprecated("use cities instead")));

/*!
 @brief 启动下载 (进入后台就停止下载)
 @param city 城市数据
 @param downloadBlock 下载过程block
 */
- (void)downloadCity:(MAOfflineCity *)city downloadBlock:(MAOfflineMapDownloadBlock)downloadBlock __attribute__ ((deprecated("use - (void)downloadItem:(MAOfflineItem *)item shouldContinueWhenAppEntersBackground:(BOOL)shouldContinueWhenAppEntersBackground downloadBlock:(MAOfflineMapDownloadBlock)downloadBlock instead")));

/*!
 @brief 启动下载
 @param city 城市数据
 @prarm shouldContinueWhenAppEntersBackground 进入后台是否允许继续下载
 @param downloadBlock 下载过程block
 */
- (void)downloadCity:(MAOfflineCity *)city shouldContinueWhenAppEntersBackground:(BOOL)shouldContinueWhenAppEntersBackground downloadBlock:(MAOfflineMapDownloadBlock)downloadBlock __attribute__ ((deprecated("use - (void)downloadItem:(MAOfflineItem *)item shouldContinueWhenAppEntersBackground:(BOOL)shouldContinueWhenAppEntersBackground downloadBlock:(MAOfflineMapDownloadBlock)downloadBlock instead")));

/*!
 @brief 监测是否正在下载
 @param city 城市数据
 @return 是否在下载
 */
- (BOOL)isDownloadingForCity:(MAOfflineCity *)city __attribute__ ((deprecated("use - (BOOL)isDownloadingForItem:(MAOfflineItem *)item instead")));

/*!
 @brief 暂停下载
 @param city 城市数据
 */
- (void)pause:(MAOfflineCity *)city __attribute__ ((deprecated("use - (void)pauseItem:(MAOfflineItem *)item instead")));

@end
