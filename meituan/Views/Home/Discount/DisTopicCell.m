//
//  DisTopicCell.m
//  meituan
//
//  Created by jinzelu on 15/7/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DisTopicCell.h"

@interface DisTopicCell ()
{
    UIImageView *_topicImage;
    
    UIView *_lineView;
}

@end

@implementation DisTopicCell

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


//懒加载
-(DisTopicModel *)disTopic{
    if (_disTopic == nil) {
        //
        NSLog(@"disTopic  为nil");
        return _disTopic;
    }else{
        NSLog(@"disTopic  !!!为nil");
        return _disTopic;
    }
}

-(NSMutableArray *)LabelsArray{
    if (_LabelsArray == nil) {
        NSLog(@"_LabelsArray  为nil");
        return _LabelsArray;
    }else{
        NSLog(@"_LabelsArray  !!!!为nil");
        return _LabelsArray;
    }
}

-(void)initViews{
    //
    _topicImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
    _topicImage.image = [UIImage imageNamed:@"bg_customReview_image_default"];
    [self.contentView addSubview:_topicImage];
    
    //背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, screen_width, 40)];
    [self.contentView addSubview:backView];
    
    //组
    for (int i = 0; i < 4; i++) {
        UIButton *segBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segBtn.frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 40);
        segBtn.tag = 30+i;
        segBtn.font = [UIFont systemFontOfSize:15];
        [segBtn setTitleColor:navigationBarColor forState:UIControlStateSelected];
        [segBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segBtn setTitle:@"我是标题啊" forState:UIControlStateNormal];
        [segBtn addTarget:self action:@selector(OnTapSegBtn:) forControlEvents:UIControlEventTouchUpInside];
        segBtn.hidden = YES;
        [backView addSubview:segBtn];
        if (i == 0) {
            segBtn.selected = YES;
        }
    }
    //下划线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 38, screen_width/4, 2)];
    _lineView.backgroundColor = navigationBarColor;
    [backView addSubview:_lineView];
    
}

-(void)OnTapSegBtn:(UIButton *)sender{
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:30+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        _lineView.center = CGPointMake(sender.center.x, 39);
    }];
}

-(void)setTopic:(DisTopicModel *)topic labelsArr:(NSMutableArray *)labels{
    _disTopic = topic;
    _LabelsArray = labels;
    
    NSString *imageStr = [topic.imageurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"300.0"];
    [_topicImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    for (int i = 0; i < labels.count; ++i) {
        int lcount = (int)labels.count;
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:30+i];
        btn.hidden = NO;
        btn.frame = CGRectMake(i*screen_width/lcount, 0, screen_width/lcount, 40);
        DisLabelModel *labelM = labels[i];
        [btn setTitle:labelM.lname forState:UIControlStateNormal];
    }
    
    
    
}

@end
