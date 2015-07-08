//
//  ShopPriceCell.m
//  meituan
//
//  Created by jinzelu on 15/7/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ShopPriceCell.h"

@implementation ShopPriceCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //折扣价
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 130, 65)];
        self.priceLabel.font = [UIFont systemFontOfSize:35];
        self.priceLabel.textColor = navigationBarColor;
//        self.priceLabel.text = @"100.5元";
        [self.contentView addSubview:self.priceLabel];
        //原价
        self.oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+10, 30, 100, 30)];
        self.oldPriceLabel.textColor = [UIColor lightGrayColor];
//        self.oldPriceLabel.text = @"110元";
        [self.contentView addSubview:self.oldPriceLabel];
                
        
        
        //立即抢购
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(screen_width-10-100, 10, 100, 40);
        buyBtn.backgroundColor = RGB(252, 158, 40);
        [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.layer.cornerRadius = 4;
        [self.contentView addSubview:buyBtn];
        
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

@end
