//
//  DiscountViewController.m
//  meituan
//
//  Created by jinzelu on 15/7/2.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DiscountViewController.h"
#import "AppDelegate.h"

@interface DiscountViewController ()<UIWebViewDelegate>
{
    UILabel *_titleLabel;
    
    UIActivityIndicatorView *_activityView;
}

@end

@implementation DiscountViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:backView];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [backView addSubview:lineView];
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 23, 23);
    [backBtn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-80, 30, 160, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    _titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:_titleLabel];
    
}

-(void)initViews{
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
//    NSString *str1 = @"?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-02-16-25124&utm_campaign=AgroupBgroupFab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___a20141120nanning__m1__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_topic2_7921&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=39.98349194824581&lng=116.3179781018858";
    
    NSString *str1 = [NSString stringWithFormat:@"?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-02-16-25124&utm_campaign=AgroupBgroupFab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___a20141120nanning__m1__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_topic2_7921&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=%f&lng=%f",delegate.latitude,delegate.longitude];
    NSString *url = [NSString stringWithFormat:@"%@%@",self.urlStr,str1];
    NSLog(@"webview URL:%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
    
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screen_width/2-15, screen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}

-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载webview");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载webview完成");
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text = theTitle;
    
    [_activityView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载webview失败");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text = theTitle;
    NSLog(@"shouldStartLoadWithRequest:   %@",theTitle);
    
    [_activityView startAnimating];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
