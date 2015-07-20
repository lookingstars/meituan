//
//  JZMerDetailImageCell.h
//  meituan
//
//  Created by jinzelu on 15/7/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JZMerDetailImageCell : UITableViewCell

@property(nonatomic, strong) NSString *BigImgUrl;
@property(nonatomic, strong) NSString *SmallImgUrl;
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, strong) NSNumber *avgPrice;
@property(nonatomic, strong) NSString *shopName;

@end
