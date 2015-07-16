//
//  CustomAnnotationView.h
//  meituan
//
//  Created by jinzelu on 15/7/15.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"
#import "JZMAAroundAnnotation.h"

@interface CustomAnnotationView : MAAnnotationView

@property(nonatomic, strong) CustomCalloutView *calloutView;

/*!
 @brief 关联的annotation
 */
@property (nonatomic, strong) JZMAAroundAnnotation *jzAnnotation;

@end
