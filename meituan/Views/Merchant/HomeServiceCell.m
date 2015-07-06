//
//  HomeServiceCell.m
//  meituan
//
//  Created by jinzelu on 15/7/6.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "HomeServiceCell.h"

@implementation HomeServiceCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
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

-(void)initViews{
    for (int i = 0; i < 10; ++i) {
        
        int x = i%2;
        int y = i/2;
        //背景
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x*(screen_width-15)/2+5*(x+1), y*125+5, (screen_width-15)/2, 120)];
        backView.backgroundColor = [UIColor redColor];
        backView.tag = 10+i;
        backView.hidden = YES;
        [self addSubview:backView];
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
        [backView addGestureRecognizer:tap];
        
        //图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height-40)];
        imageView.tag = 50+i;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backView addSubview:imageView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), backView.frame.size.width, 30)];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"我是标题";
        titleLabel.tag = 100+i;
        [backView addSubview:titleLabel];
    }    
}


-(void)setHomeServiceArray:(NSMutableArray *)homeServiceArray{
    _homeServiceArray = homeServiceArray;
    for (int i = 0; i < homeServiceArray.count; i++) {
        UIView *backView = [self viewWithTag:10+i];
        backView.hidden = NO;
        HomeServiceModel *homeM = homeServiceArray[i];
        backView.backgroundColor = [self stringTOColor:homeM.background];
        //
        UIImageView *imageView = (UIImageView *)[self viewWithTag:50+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:homeM.cateImgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        
        //
        UILabel *titleLabel = (UILabel *)[self viewWithTag:100+i];
        titleLabel.text = homeM.cateName;
        
        
    }
}


-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    NSInteger tag = sender.view.tag-10;
    [self.delegate didSelectAtIndex:tag];
}







- (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}





@end
