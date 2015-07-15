//
//  JZKindFilterCell.h
//  meituan
//
//  Created by jinzelu on 15/7/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMerCateGroupModel.h"

@interface JZKindFilterCell : UITableViewCell


@property(nonatomic, strong) JZMerCateGroupModel *groupM;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame;

@end
