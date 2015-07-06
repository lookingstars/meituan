//
//  HomeServiceModel.h
//  meituan
//
//  Created by jinzelu on 15/7/6.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeServiceModel : NSObject

@property(nonatomic, strong) NSString *background;
@property(nonatomic, strong) NSNumber *cateId;
@property(nonatomic, strong) NSString *cateImgUrl;
@property(nonatomic, strong) NSString *cateName;
@property(nonatomic, strong) NSString *clickable;

@property(nonatomic, strong) NSString *jumpType;
@property(nonatomic, strong) NSString *jumpUrl;
@property(nonatomic, strong) NSString *open;
@property(nonatomic, strong) NSString *showType;


@end
