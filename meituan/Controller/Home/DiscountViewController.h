//
//  DiscountViewController.h
//  meituan
//
//  Created by jinzelu on 15/7/2.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountViewController : UIViewController


/**
 *  webview加载的url
 */
@property(nonatomic, strong) NSString *urlStr;

@property(nonatomic, strong) UIWebView *webView;

@end
