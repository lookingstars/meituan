//
//  JZMerCateGroupModel.h
//  meituan
//
//  Created by jinzelu on 15/7/10.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZMerCateGroupModel : NSObject

@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSNumber *index;
@property(nonatomic, strong) NSNumber *parentID;
@property(nonatomic, strong) NSNumber *count;
@property(nonatomic, strong) NSString *name;


@property(nonatomic, strong) NSMutableArray *list;



@end
