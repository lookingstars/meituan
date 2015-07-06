//
//  RushDataModel.h
//  meituan
//  抢购Model
//  Created by jinzelu on 15/6/26.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface RushDataModel : NSObject

@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSMutableArray *share;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *start;
@property(nonatomic, strong) NSNumber *listJumpToTouch;

@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, strong) NSString *descBefore;
@property(nonatomic, strong) NSMutableArray *deals;
@property(nonatomic, strong) NSNumber *end;
@property(nonatomic, strong) NSString *touchUrlForList;

@property(nonatomic, strong) NSString *descIn;
@property(nonatomic, strong) NSString *descAfter;

@end
