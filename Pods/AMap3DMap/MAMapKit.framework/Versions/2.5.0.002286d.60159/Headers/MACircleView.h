//
//  MACircleView.h
//  MAMapKit
//
//  Created by yin cai on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MACircle.h"
#import "MAOverlayPathView.h"

/*!
 @brief 该类是MACircle的显示圆view,可以通过MAOverlayPathView修改其fill和stroke attributes
 */
@interface MACircleView : MAOverlayPathView

/*!
 @brief 根据指定圆生成对应的View
 @param circle 指定的MACircle model
 @return 生成的View
 */
- (id)initWithCircle:(MACircle *)circle;

/*!
 @brief 关联的MAcirlce model
 */
@property (nonatomic, readonly) MACircle *circle;

@end
