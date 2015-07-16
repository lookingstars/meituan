//
//  JZMAAroundModel.h
//  meituan
//
//  Created by jinzelu on 15/7/15.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZMAAroundModel : NSObject

@property(nonatomic, strong) NSString *mname;//标题
@property(nonatomic, strong) NSNumber *price;//价格
@property(nonatomic, strong) NSString *imgurl;//图片

@property(nonatomic, strong) NSMutableArray *rdplocs;//坐标等

@end
