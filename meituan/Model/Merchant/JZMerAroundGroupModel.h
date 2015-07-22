//
//  JZMerAroundGroupModel.h
//  meituan
//
//  Created by jinzelu on 15/7/22.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface JZMerAroundGroupModel : NSObject

@property (nonatomic, strong) NSString *squareimgurl;/**< 图片url */
@property (nonatomic, strong) NSString *mname;/**< 店名 */
@property (nonatomic, strong) NSString *range;/**< 范围 */
@property (nonatomic, strong) NSString *title;/**<  标题 */
@property (nonatomic, strong) NSNumber *price;/**<  现价 */

@property (nonatomic, strong) NSNumber *value;/**<  原价 */
@property (nonatomic, strong) NSNumber *rating;/**<  评分 */
@property (nonatomic, strong) NSNumber *rate_count;
@property (nonatomic, strong) NSNumber *id;

@end
