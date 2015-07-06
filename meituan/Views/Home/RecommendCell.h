//
//  RecommendCell.h
//  meituan
//
//  Created by jinzelu on 15/7/1.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

#import "DisDealModel.h"//折扣model

@interface RecommendCell : UITableViewCell

@property(nonatomic, strong) UIImageView *shopImage;
@property(nonatomic, strong) UILabel *shopNameLabel;
@property(nonatomic, strong) UILabel *shopInfoLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *soldedLabel;


@property(nonatomic, strong) RecommendModel *recommendData;

@property(nonatomic, strong) DisDealModel *dealData;

@end
