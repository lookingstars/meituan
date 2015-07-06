//
//  DiscountModel.h
//  meituan
//
//  Created by jinzelu on 15/7/2.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject

@property(nonatomic, strong) NSNumber *position;
@property(nonatomic, strong) NSString *typeface_color;
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSMutableDictionary *share;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *module;
@property(nonatomic, strong) NSString *maintitle;
@property(nonatomic, strong) NSString *tplurl;
@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, strong) NSString *imageurl;


@property(nonatomic, strong) NSNumber *solds;
@property(nonatomic, strong) NSString *deputytitle;


@end
