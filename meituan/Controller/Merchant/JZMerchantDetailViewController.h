//
//  JZMerchantDetailViewController.h
//  meituan
//
//  Created by jinzelu on 15/7/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMerchantDetailViewController : UIViewController

//商店ID
@property(nonatomic, strong) NSString *poiid;

@property(nonatomic, strong) UITableView *tableView;

@end
