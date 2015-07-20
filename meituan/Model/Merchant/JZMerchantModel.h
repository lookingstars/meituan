//
//  JZMerchantModel.h
//  meituan
//
//  Created by jinzelu on 15/7/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZMerchantModel : NSObject

@property (nonatomic, strong) NSString *frontImg;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *avgScore;//星星
@property (nonatomic, strong) NSNumber *markNumbers;//评价个数
@property (nonatomic, strong) NSString *cateName;

@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSNumber *avgPrice;
@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, strong) NSString *poiid;




@end
