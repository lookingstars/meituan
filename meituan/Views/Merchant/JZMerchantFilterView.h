//
//  JZMerchantFilterView.h
//  meituan
//
//  Created by jinzelu on 15/7/10.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZMerchantFilterDelegate <NSObject>

@optional
/**
 *  点击tableview，过滤id
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withId:(NSNumber *)ID withName:(NSString *)name;

@end


@interface JZMerchantFilterView : UIView

@property(nonatomic, strong) UITableView *tableViewOfGroup;
@property(nonatomic, strong) UITableView *tableViewOfDetail;

@property(nonatomic, assign) id<JZMerchantFilterDelegate> delegate;



@end
