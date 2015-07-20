//
//  JZMerDetailImageCell.m
//  meituan
//
//  Created by jinzelu on 15/7/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMerDetailImageCell.h"

@interface JZMerDetailImageCell ()
{
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    UILabel *_avgPriceLabel;
    UILabel *_shopNameLabel;
}

@end

@implementation JZMerDetailImageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //大图
//        NSLog(@"==%f   %f",[self bounds].size.width,[self bounds].size.height);
//        NSLog(@"++%f",screen_width);
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        [_bigImageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        [self addSubview:_bigImageView];
        
        //小图
        _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-10-80, 85, 80, 80)];
        [_smallImageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        _smallImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _smallImageView.layer.borderWidth = 1;
        [self addSubview:_smallImageView];
        
        //店名
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, screen_width-90-10, 30)];
        _shopNameLabel.textColor = [UIColor whiteColor];
        _shopNameLabel.text = @"优衣库店";
        _shopNameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_shopNameLabel];
        NSLog(@"优衣库种子：*********");
        //星星
        for (int i = 0; i < 5; ++i) {
            UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            starBtn.tag = 100 + i;
            starBtn.frame = CGRectMake(10+i*15, 130, 13, 13);
            [starBtn setImage:[UIImage imageNamed:@"icon_rating_star_not_picked"] forState:UIControlStateNormal];
            [starBtn setImage:[UIImage imageNamed:@"icon_rating_star_picked"] forState:UIControlStateSelected];
            [self addSubview:starBtn];
        }
        //人均
        _avgPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+5*15, 123, 80, 30)];
        _avgPriceLabel.textColor = [UIColor whiteColor];
        _avgPriceLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_avgPriceLabel];
        
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

-(void)setBigImgUrl:(NSString *)BigImgUrl{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:BigImgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
}

-(void)setShopName:(NSString *)shopName{
    _shopNameLabel.text = shopName;
}

-(void)setAvgPrice:(NSNumber *)avgPrice{
    _avgPriceLabel.text = [NSString stringWithFormat:@"人均：%@元",avgPrice];
}

@end
