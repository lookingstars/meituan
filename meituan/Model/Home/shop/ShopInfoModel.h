//
//  ShopInfoModel.h
//  meituan
//
//  Created by jinzelu on 15/7/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfoModel : NSObject

//模型里字段太多，只选了几个需要用的
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSString *imgurl;
@property(nonatomic, strong) NSString *mname;
@property(nonatomic, strong) NSString *title;


@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, strong) NSNumber *value;//原价

@property(nonatomic, strong) NSNumber *solds;//已售

@end
