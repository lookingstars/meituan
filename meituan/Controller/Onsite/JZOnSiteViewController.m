//
//  JZOnSiteViewController.m
//  meituan
//
//  Created by jinzelu on 15/7/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZOnSiteViewController.h"
#import "NetworkSingleton.h"
#import "ImageScrollCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ServiceAdvModel.h"
#import "HomeServiceModel.h"
#import "HomeServiceCell.h"
#import "AppDelegate.h"

#import "HotQueueViewController.h"

@interface JZOnSiteViewController ()<UITableViewDataSource,UITableViewDelegate,HomeServiceDelegate>
{
    NSMutableArray *_advArray;//广告数据源
    NSMutableArray *_advImageUrlArray;//广告图片数组
    
    NSMutableArray *_homeServiceArray;//上门服务数据源
    
}

@end

@implementation JZOnSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _advArray = [[NSMutableArray alloc] init];
    _advImageUrlArray = [[NSMutableArray alloc] init];
    _homeServiceArray = [[NSMutableArray alloc] init];
    
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setUpTableView];
}

-(void)setUpTableView{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; ++i) {
        //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        //        [idleImages addObject:image];
        UIImage *image = [UIImage imageNamed:@"icon_listheader_animation_1"];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"icon_listheader_animation_1"];
    [refreshingImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"icon_listheader_animation_2"];
    [refreshingImages addObject:image2];
    //    for (NSInteger i = 1; i<=3; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
    //        [refreshingImages addObject:image];
    //    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    //设置正在刷新是的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
}

-(void)loadNewData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        [self getServiceAdvData];
        [self getHomeServiewData];
    });
}



-(void)getHomeServiewData{
    NSString *urlStr = @"http://api.meituan.com/apollo/index?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=fZgLxmKv3t4SJLEnmK%2FpVquwJfs%3D&__skno=E9781389-B5C0-47E7-9C45-678C0CE3A25D&__skts=1436146268.971232&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&ci=1&clientType=ios&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-06-09-25492&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_i_group_5_3_poidetaildeallist__a__b___ab_pindaoquxincelue0630__b__b1___a20141120nanning__m1__leftflow___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGonsite&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    __weak __typeof(self) weakself = self;
    [[NetworkSingleton sharedManager] getHomeServiceResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"上门服务请求成功");
        [_homeServiceArray removeAllObjects];
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        for (int i = 0; i < dataArray.count; ++i) {
            HomeServiceModel *homeM = [HomeServiceModel objectWithKeyValues:dataArray[i]];
            [_homeServiceArray addObject:homeM];
        }
        
        [weakself.tableView reloadData];
        
        
        [weakself.tableView.header endRefreshing];
    } failureBlock:^(NSString *error){
        NSLog(@"上门服务请求失败：%@",error);
        [weakself.tableView.header endRefreshing];
    }];
}

-(void)getServiceAdvData{
    NSString *urlStr = @"http://api.meituan.com/api/v3/adverts?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=QQ2QWVSoLi6cGQD%2FLj1WzZlK8a0%3D&__skno=0C297102-BDB7-41E2-A3F3-4F93DA767CC2&__skts=1436147276.789350&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&app=group&category=20002&ci=1&cityid=1&clienttp=iphone&devid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-06-09-25492&uid=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_waimaizhanshi__b__b1___ab_chunceshishuju__a__a___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_i_group_5_3_poidetaildeallist__a__b___a20141120nanning__m1__leftflow___ab_pindaoquxincelue0630__b__b1___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGonsite&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version=5.7&version_name=5.7";
    __weak __typeof(self) weakself = self;
    [[NetworkSingleton sharedManager] getServiceAdvResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"上门服务广告请求成功");
        [_advImageUrlArray removeAllObjects];
        [_advArray removeAllObjects];
        
        
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        for (int i = 0; i < dataArray.count; ++i) {
            ServiceAdvModel *serviceAdvM = [ServiceAdvModel objectWithKeyValues:dataArray[i]];
            [_advArray addObject:serviceAdvM];
            [_advImageUrlArray addObject:serviceAdvM.imgUrl];
        }
        
        
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error){
        NSLog(@"上门服务广告请求失败：%@",error);
    }];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 155.0;
    }else{
        if (_homeServiceArray.count!=0) {
            int y = (_homeServiceArray.count +2-1)/2;
            return 125*y+5;
        }else{
            return 125*5+5;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"advCell";
        ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[ImageScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 155)];
        }
        
        if (_advImageUrlArray.count !=0) {
            [cell setImageArray:_advImageUrlArray];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *cellIndentifier = @"serviceCell";
        HomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        if (_homeServiceArray.count!=0) {
            [cell setHomeServiceArray:_homeServiceArray];
        }
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}




#pragma mark - UITableViewDelegate



#pragma mark - HomeServiceDelegate
-(void)didSelectAtIndex:(NSInteger)index{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"index:%ld",index);
    HomeServiceModel *homeM = _homeServiceArray[index];
    NSString *url = homeM.jumpUrl;
    if ([url rangeOfString:@"url=http"].location != NSNotFound) {
        //跳转到web页
        NSRange rang = [url rangeOfString:@"http"];
        url = [url substringFromIndex:rang.location];
        //将  http%3a%2f%2fi.meituan.com%2fapollo%2fcarInsurance%2fdetail  转码成  http://i.meituan.com/apollo/carInsurance/detail
        url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"url:%@",url);
        
        NSString *flagStr = @"";
        if([url rangeOfString:@"?"].location == NSNotFound){//有?
            flagStr = @"?";
        }else{
            flagStr = @"&";
        }
        
        NSString *str1 = [NSString stringWithFormat:@"%@ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-06-14-32112&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_3_poidetaildeallist__a__b___a20141120nanning__m1__leftflow___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGonsite&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=%f&lng=%f",flagStr ,delegate.latitude,delegate.longitude];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",url,str1];
        //        NSLog(@"urlstr:%@",urlStr);
        
        HotQueueViewController *webView = [[HotQueueViewController alloc] init];
        webView.urlStr = urlStr;
        [self.navigationController pushViewController:webView animated:YES];
        
        
    }else{
        
    }
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
