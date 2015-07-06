//
//  DisTopicModel.h
//  meituan
//
//  Created by jinzelu on 15/7/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisTopicModel : NSObject

@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSMutableDictionary *share;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *rule;
@property(nonatomic, strong) NSString *imageurl;

@end
