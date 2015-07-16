//
//  AppDelegate.h
//  meituan
//
//  Created by jinzelu on 15/6/12.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property(nonatomic, strong) UIImageView *advImage;
@property(nonatomic, strong) UITabBarController *rootTabbarCtr;

@end


/**
 *  作者：ljz
 *  Q Q：863784757
 *  注明：版权所有，转载请注明出处，不可用于其他商业用途。
 */
