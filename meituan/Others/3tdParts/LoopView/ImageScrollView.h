//
//  ImageScrollView.h
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageScrollViewDelegate <NSObject>

//@required
-(void)didSelectImageAtIndex:(NSInteger)index;

@end

@interface ImageScrollView : UIView

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSArray *imgArray;
@property(nonatomic, assign) id<ImageScrollViewDelegate> delegate;

//-(ImageScrollView *)initWithFrame:(CGRect)frame;
-(void)setImageArray:(NSArray *)imageArray;
-(ImageScrollView *)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr;


@end
/**
 *  轮播View
 */