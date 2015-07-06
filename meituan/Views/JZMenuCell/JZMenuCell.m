//
//  JZMenuCell.m
//  meituan
//
//  Created by jinzelu on 15/6/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMenuCell.h"
#define KWHC_MENUCELL_ANMATION_PADING (10.0)
@interface JZMenuCell ()<UIGestureRecognizerDelegate>
{
    BOOL                  _isOpen;
    BOOL                  _isScrollClose;
    CGFloat               _startX;
    UIView                *_menuView;
    UIPanGestureRecognizer  *_panGesture;
}

@end

@implementation JZMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        [self initConfig];
        [self initUI];
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

-(void)initViews{
    _ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    _ContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_ContentView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 200, 20)];
    msgLabel.text = @"测试测试测试测试测试测试";
    [_ContentView addSubview:msgLabel];
}

-(void)initConfig{
    _menuViewWidth = 100;
    _menuViewWidth = 100;
    _menuItemTitles = @[@"分享",@"删除"];
    _menuItemBackColors = @[[UIColor grayColor],[UIColor redColor]];
}

-(void)initUI{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.delegate = self;
    [self.contentView addGestureRecognizer:_panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    tapGesture.delegate = self;
    [self.contentView addGestureRecognizer:tapGesture];
    
    if (_menuItemTitles == nil) {
        _menuItemTitles = @[];
    }
    if (_menuItemBackImages == nil) {
        _menuItemBackImages = @[];
    }
    if (_menuItemBackColors == nil) {
        _menuItemBackColors = @[[UIColor redColor]];
    }
    if (_menuItemTitleColors == nil) {
        _menuItemTitleColors = @[[UIColor blackColor]];
    }
    if (_menuItemWidths == nil) {
        _menuItemWidths = @[];
    }
    if (_menuItemNormalImages == nil) {
        _menuItemNormalImages = @[];
    }
    if (_menuItemSelectedImages == nil) {
        _menuItemSelectedImages = @[];
    }
    
//   菜单项
    CGFloat _menuViewX = CGRectGetWidth(_ContentView.frame)-_menuViewWidth;
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(_menuViewX + CGRectGetMinX(_ContentView.frame), 0, _menuViewWidth, CGRectGetHeight(_ContentView.frame))];
    _menuView.backgroundColor = [UIColor redColor];
    
    [self.contentView insertSubview:_menuView belowSubview:_ContentView];

    
    NSInteger menuItemCount = _menuItemTitles.count;
    NSInteger menuBackImageCount = _menuItemBackImages.count;
    NSInteger menuBackColorCount = _menuItemBackColors.count;
    NSInteger menuTitleColorCount = _menuItemTitleColors.count;
    NSInteger menuItemWidthCount = _menuItemWidths.count;
    NSInteger menuItemNormalImageCount = _menuItemNormalImages.count;
    NSInteger menuItemSelectedImageCount = _menuItemSelectedImages.count;
    CGFloat btnWidth = _menuViewWidth/(CGFloat)menuItemCount;
    
    //
    CGFloat (^currentWidth)(NSInteger i) = ^(NSInteger i){
        CGFloat width = 0.0;
        for (NSInteger j = 0; j < i; j++) {
            width += [_menuItemWidths[j] floatValue];
        }
        return width;
    };
    
    //创建菜单按钮
    for (NSInteger i = 0; i < menuItemCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+10;
        CGRect btnRec = CGRectMake(i*btnWidth, 0.0, btnWidth, CGRectGetHeight(_ContentView.frame));
        btn.frame = btnRec;
        if (menuItemWidthCount == menuItemCount) {
            btnRec.origin.x = currentWidth(i-1);
            btnRec.size.width = [_menuItemWidths[i] floatValue];
            btn.frame = btnRec;
        }
        
        [btn setTitle:_menuItemTitles[i] forState:UIControlStateNormal];
        
        NSInteger titleColorIndex = i;
        if (titleColorIndex >= menuTitleColorCount) {
            titleColorIndex = menuTitleColorCount - 1;
            if (titleColorIndex<0) {
                titleColorIndex = 0;
            }
        }
        if (titleColorIndex < menuTitleColorCount) {
            [btn setTitleColor:_menuItemTitleColors[titleColorIndex] forState:UIControlStateNormal];
        }
        
        //
        NSInteger imageIndex = i;
        if ((imageIndex >= menuBackImageCount)) {
            imageIndex = menuBackImageCount - 1;
            if (imageIndex < 0) {
                imageIndex = 0;
            }
        }
        if (imageIndex < menuBackImageCount) {
            [btn setBackgroundImage:[UIImage imageNamed:_menuItemBackImages[imageIndex]] forState:UIControlStateNormal];
        }
        
        //
        NSInteger colorIndex = i;
        if (colorIndex >= menuBackColorCount) {
            colorIndex = menuBackColorCount - 1;
            if (colorIndex < 0) {
                colorIndex = 0;
            }
        }
        if (colorIndex < menuBackColorCount) {
            btn.backgroundColor = _menuItemBackColors[colorIndex];
        }
        
        //
        if (i < menuItemNormalImageCount) {
            NSString *imageName = _menuItemNormalImages[i];
            if (imageName != nil && imageName.length) {
                [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            }
            if (i < menuItemSelectedImageCount) {
                NSString *selectedImageName = _menuItemSelectedImages[i];
                if (selectedImageName != nil && selectedImageName.length) {
                    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
                }
            }
        }
        btn.titleLabel.minimumScaleFactor = 0.1;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (_fontSize == 0.0) {
            _fontSize = 18.0;
        }
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:_fontSize];
        [btn addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:btn];
    }
}

//设置滚动列表时菜单关闭状态
-(void)setIsScrollClose{
    _isScrollClose = NO;
}

//
-(void)startScrollviewCell:(BOOL)state x:(CGFloat)moveX{
    
}
-(void)didEndScrollViewCell:(BOOL)state{
    
}

//单击菜单项
-(void)clickMenuItem:(UIButton *)sender{
    NSInteger tag = sender.tag;
    NSLog(@"单击按钮:%ld",tag);
    [self closeCellWithAnimation:YES];
}

//批量关闭菜单项
-(BOOL)closeCellWithTableView:(UITableView *)tableView index:(NSInteger)index animation:(BOOL)b{
    NSArray *indexPatnArr = [tableView indexPathsForVisibleRows];
    BOOL handleResult = NO;
    for (NSIndexPath * indexPath in indexPatnArr) {
        if (_index != indexPath.row && index > -1) {
            JZMenuCell *cell = (JZMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell setIsScrollClose];
            if ([cell closeCellWithAnimation:b]) {
                handleResult = YES;
            }
        }else if (index <= -1){
            JZMenuCell *cell = (JZMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (_index !=indexPath.row) {
                [cell setIsScrollClose];
            }
            if ([cell closeCellWithAnimation:b]) {
                handleResult = YES;
            }
        }
    }
    
    return handleResult;
}
//
-(BOOL)closeCellWithAnimation:(BOOL)b{
    BOOL isClose = NO;
    if (_isOpen) {
        isClose = YES;
        if (b) {
            [UIView animateWithDuration:0.2 animations:^{
                _ContentView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
            } completion:^(BOOL finished){
                _isOpen = NO;
                [self didEndScrollViewCell:_isOpen];
            }];
        }else{
            _ContentView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
            _isOpen = NO;
            [self didEndScrollViewCell:_isOpen];
        }
    }
    return isClose;
}

//手势处理
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesure{    
    switch (panGesure.state) {
        case UIGestureRecognizerStateBegan:
            {
                _startX = _ContentView.transform.tx;
                _isScrollClose = [_delegate JZMenuCell:self didPullCell:_index];
            }
            break;
        case UIGestureRecognizerStateChanged:{
            if (_isScrollClose && _isOpen == NO) {
                return;
            }
            CGFloat currentX = _ContentView.transform.tx;
            CGFloat moveDistanceX = [panGesure translationInView:panGesure.view].x;
            CGFloat velocityX = [panGesure velocityInView:panGesure.view].x;
            CGFloat moveX = _startX +moveDistanceX;
            
            if (velocityX > 0) {//右移动
                if (currentX >= KWHC_MENUCELL_ANMATION_PADING) {
                    [panGesure setTranslation:CGPointMake(KWHC_MENUCELL_ANMATION_PADING, 0.0) inView:panGesure.view];
                    break;
                }
            }else{
                if (currentX < -_menuViewWidth) {
                    moveX = currentX -0.4;
                    [panGesure setTranslation:CGPointMake(moveX, 0.0) inView:panGesure.view];
                }
            }
            _ContentView.transform = CGAffineTransformMakeTranslation(moveX, 0.0);
            [self startScrollviewCell:_isOpen x:moveDistanceX];
        }
            break;
        case UIGestureRecognizerStateCancelled:{
            
        }
            break;
        case UIGestureRecognizerStateEnded:{
            _isScrollClose = NO;
            if (_ContentView.transform.tx > 0.0) {
                [UIView animateWithDuration:0.2 animations:^{
                    _ContentView.transform = CGAffineTransformMakeTranslation(-KWHC_MENUCELL_ANMATION_PADING, 0.0);
                } completion:^(BOOL finished){
                    _isOpen = NO;
                    [self didEndScrollViewCell:_isOpen];
                    [UIView animateWithDuration:0.2 animations:^{
                        _ContentView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                    }];
                }];
            }else if (_ContentView.transform.tx <0){
                CGFloat tx = fabsf(_ContentView.transform.tx);
                if (tx < _menuViewWidth /2.0 || (tx < _menuViewWidth && _isOpen)) {
                    [UIView animateWithDuration:0.2 animations:^{
                        _ContentView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                    } completion:^(BOOL finished){
                        _isOpen = NO;
                        [self didEndScrollViewCell:_isOpen];
                    }];
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        _ContentView.transform = CGAffineTransformMakeTranslation(-_menuViewWidth, 0.0);
                    } completion:^(BOOL finished){
                        _isOpen = YES;
                        [self didEndScrollViewCell:_isOpen];
                    }];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)handleTapGestrue:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"tap");
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return [_delegate JZMenuCell:self didPullCell:-1];
    }else if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocityPoint = [panGesture velocityInView:panGesture.view];
        if (fabsf(velocityPoint.x) > fabsf(velocityPoint.y)) {
            return YES;
        }else{
            _isScrollClose = [_delegate JZMenuCell:self didPullCell:-1];
            return _isScrollClose;
        }
    }
    return NO;
}

























@end
