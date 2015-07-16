//
//  JZMAAroundAnnotation.h
//  meituan
//
//  Created by jinzelu on 15/7/15.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "JZMAAroundModel.h"

@interface JZMAAroundAnnotation : MAPointAnnotation

@property(nonatomic, strong) JZMAAroundModel *jzmaaroundM;

@end
