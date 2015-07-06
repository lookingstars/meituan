//
//  DiscountCell.h
//  meituan
//
//  Created by jinzelu on 15/7/2.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DiscountDelegate <NSObject>

@optional
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title;

@end



@interface DiscountCell : UITableViewCell

/**
 *  懒的写复用的view了，改用for创建
 */

/**
 *  接收set方式传参
 */
@property(nonatomic, strong) NSMutableArray *discountArray;

@property(nonatomic, assign) id<DiscountDelegate> delegate;


@end
