//
//  JZMerchantCell.m
//  meituan
//
//  Created by jinzelu on 15/7/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMerchantCell.h"

@interface JZMerchantCell ()
{
    UIImageView *_merchantImage;
    UILabel *_merchantNameLabel;
    
    UILabel *_cateNameLabel;
    
}

@end

@implementation JZMerchantCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图
        _merchantImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 72)];
        _merchantImage.layer.masksToBounds = YES;
        _merchantImage.layer.cornerRadius = 4;
        [self.contentView addSubview:_merchantImage];
        
        //店名
        _merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, screen_width-110-10, 30)];
        _merchantNameLabel.font = [UIFont systemFontOfSize:15];
        _merchantNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_merchantNameLabel];
        
        //cateName
        _cateNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, screen_width-110-10, 30)];
        _cateNameLabel.font = [UIFont systemFontOfSize:13];
        _cateNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_cateNameLabel];
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

-(void)setJzMerM:(JZMerchantModel *)jzMerM{
    _jzMerM = jzMerM;
    
    NSString *imgUrl = [jzMerM.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [_merchantImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    _merchantNameLabel.text = jzMerM.name;
    _cateNameLabel.text = [NSString stringWithFormat:@"%@  %@",jzMerM.cateName,jzMerM.areaName];
}





@end
