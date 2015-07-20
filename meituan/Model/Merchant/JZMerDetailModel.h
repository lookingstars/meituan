//
//  JZMerDetailModel.h
//  meituan
//
//  Created by jinzelu on 15/7/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZMerDetailModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *avgScore;//星星
@property (nonatomic, strong) NSNumber *avgPrice;//人均
@property (nonatomic, strong) NSString *frontImg;//背景图
@property (nonatomic, strong) NSString *addr;//地址

@property (nonatomic, strong) NSString *phone;//电话
@property (nonatomic, strong) NSString *featureMenus;//推荐菜


@end
