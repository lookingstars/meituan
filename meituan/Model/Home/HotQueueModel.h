//
//  HotQueueModel.h
//  meituan
//
//  Created by jinzelu on 15/7/1.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotQueueModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *imageUrl ;
@property(nonatomic, strong) NSNumber *within;
@property(nonatomic, strong) NSString *comment;
@property(nonatomic, strong) NSString *serviceUrl;

@end
