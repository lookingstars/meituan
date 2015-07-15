//
//  JZKindFilterCell.m
//  meituan
//
//  Created by jinzelu on 15/7/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZKindFilterCell.h"

@interface JZKindFilterCell ()
{
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UIButton *_numberBtn;
}

@end

@implementation JZKindFilterCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.frame = frame;
        //
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        //
//        NSLog(@"self.frame.size.width:%f",self.frame.size.width);
        _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberBtn.frame = CGRectMake(self.frame.size.width-85, 12, 80, 15);
        _numberBtn.font = [UIFont systemFontOfSize:11];
        _numberBtn.layer.cornerRadius = 7;
        _numberBtn.layer.masksToBounds = YES;
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateNormal];
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateHighlighted];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_numberBtn];
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        lineView.backgroundColor = RGB(192, 192, 192);
        [self.contentView addSubview:lineView];
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


-(void)setGroupM:(JZMerCateGroupModel *)groupM{
    _groupM = groupM;
    _nameLabel.text = groupM.name;
    
    if (groupM.list == nil) {
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@",groupM.count] forState:UIControlStateNormal];
    }else{
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@>",groupM.count] forState:UIControlStateNormal];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@>",groupM.count];
    CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(80, 15) lineBreakMode:NSLineBreakByWordWrapping];
    
    _numberBtn.frame = CGRectMake(self.frame.size.width-10-textSize.width-10, 12, textSize.width+10, 15);
    
}


@end
