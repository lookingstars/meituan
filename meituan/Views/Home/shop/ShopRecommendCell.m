//
//  ShopRecommendCell.m
//  meituan
//
//  Created by jinzelu on 15/7/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ShopRecommendCell.h"

@interface ShopRecommendCell ()
{
    UIImageView *_shopImageView;
    UILabel *_shopNameLabel;
    UILabel *_shopInfoLabel;
    UILabel *_shopPriceLabel;
}

@end

@implementation ShopRecommendCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图
        _shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        _shopImageView.layer.masksToBounds = YES;
        _shopImageView.layer.cornerRadius = 4;
        [self addSubview:_shopImageView];
        //标题
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, screen_width-100, 30)];
        _shopNameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_shopNameLabel];
        //详情
        _shopInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, screen_width-100-10, 50)];
        _shopInfoLabel.numberOfLines = 2;
        _shopInfoLabel.font = [UIFont systemFontOfSize:13];
        _shopInfoLabel.textColor = [UIColor lightGrayColor];
        _shopInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_shopInfoLabel];
        //价格
        _shopPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 100, 20)];
        _shopPriceLabel.font = [UIFont systemFontOfSize:13];
        _shopPriceLabel.textColor = navigationBarColor;
        [self addSubview:_shopPriceLabel];
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopRecM:(ShopRecommendModel *)shopRecM{
    _shopRecM = shopRecM;
    
    NSString *imgUrl = [shopRecM.imgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [_shopImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    _shopNameLabel.text = shopRecM.brandname;
    _shopInfoLabel.text = [NSString stringWithFormat:@"[%@]%@",shopRecM.range,shopRecM.title];
    _shopPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[shopRecM.price doubleValue]];
}

@end
