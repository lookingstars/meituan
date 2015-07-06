//
//  DisTopicCell.h
//  meituan
//
//  Created by jinzelu on 15/7/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisTopicModel.h"
#import "DisLabelModel.h"


@interface DisTopicCell : UITableViewCell

@property(nonatomic, strong) DisTopicModel *disTopic;
@property(nonatomic, strong) NSMutableArray *LabelsArray;

-(void)setTopic:(DisTopicModel *)topic labelsArr:(NSMutableArray *)labels;

@end
