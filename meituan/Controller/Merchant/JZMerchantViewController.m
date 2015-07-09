//
//  JZMerchantViewController.m
//  meituan
//
//  Created by jinzelu on 15/7/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMerchantViewController.h"
#import "NetworkSingleton.h"
#import "AppDelegate.h"
#import "MJExtension.h"
#import "JZMerchantModel.h"
#import "JZMerchantCell.h"
#import "MJRefresh.h"

@interface JZMerchantViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_MerchantArray;
}
@end

@implementation JZMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    
    [self setNav];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _MerchantArray = [[NSMutableArray alloc] init];
}

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:backView];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [backView addSubview:lineView];
    
    //地图
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(10, 30, 23, 23);
    [mapBtn setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:mapBtn];
    //搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(screen_width-42, 30, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
    
    //segment
    UIButton *segBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    segBtn1.frame = CGRectMake(screen_width/2-80, 30, 80, 30);
    segBtn1.tag = 20;
    [segBtn1 setTitle:@"全部商家" forState:UIControlStateNormal];
    [segBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [segBtn1 setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [segBtn1 setBackgroundColor:navigationBarColor];
    segBtn1.selected = YES;
    segBtn1.font = [UIFont systemFontOfSize:15];
    segBtn1.layer.borderWidth = 1;
    segBtn1.layer.borderColor = [navigationBarColor CGColor];
    [segBtn1 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn1];
    
    UIButton *segBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    segBtn2.frame = CGRectMake(screen_width/2, 30, 80, 30);
    segBtn2.tag = 21;
    [segBtn2 setTitle:@"优惠商家" forState:UIControlStateNormal];
    [segBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [segBtn2 setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [segBtn2 setBackgroundColor:[UIColor whiteColor]];
    segBtn2.font = [UIFont systemFontOfSize:15];
    segBtn2.layer.borderWidth = 1;
    segBtn2.layer.borderColor = [navigationBarColor CGColor];
    [segBtn2 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn2];
}

-(void)initViews{
    //
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    filterView.backgroundColor = [UIColor redColor];
    [self.view addSubview:filterView];
    
    
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, screen_width, screen_height-64-40-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setUpTableView];
}

-(void)setUpTableView{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    //设置正在刷新是的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
}


//响应事件

-(void)OnBackBtn:(UIButton *)sender{
    NSLog(@"地图");
}

-(void)OnSearchBtn:(UIButton *)sender{
    NSLog(@"搜索");
}

-(void)OnSegBtn:(UIButton *)sender{
    NSInteger tag = sender.tag;
    UIButton *segBtn1 = (UIButton *)[self.view viewWithTag:20];
    UIButton *segBtn2 = (UIButton *)[self.view viewWithTag:21];
    [segBtn1 setBackgroundColor:[UIColor whiteColor]];
    [segBtn2 setBackgroundColor:[UIColor whiteColor]];
    segBtn1.selected = NO;
    segBtn2.selected = NO;
    sender.selected = YES;
    [sender setBackgroundColor:navigationBarColor];
    if (tag == 20) {
        NSLog(@"20");
    }else{
        NSLog(@"21");
    }
}

-(void)OnRefreshBtn:(UIButton *)sender{
    
}


-(void)refreshData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getMerchantList];
    });
}


//获取商家列表
-(void)getMerchantList{
    NSString *urlStr = @"http://api.meituan.com/group/v1/poi/select/cate/-1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=WOdaAXJTFxIjDdjmt1z%2FJRzB6Y0%3D&__skno=91D0095F-156B-4392-902A-A20975EB9696&__skts=1436408836.151516&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&areaId=-1&ci=1&cityId=1&client=iphone&coupon=all&limit=20&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&mypos=39.982245%2C116.311900&offset=0&sort=smart&userid=104108621&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    [[NetworkSingleton sharedManager] getMerchantListResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"获取商家列表成功");
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        NSLog(@"%ld",dataArray.count);
        [_MerchantArray removeAllObjects];
        
        for (int i = 0; i < dataArray.count; i++) {
            JZMerchantModel *JZMerM = [JZMerchantModel objectWithKeyValues:dataArray[i]];
            [_MerchantArray addObject:JZMerM];
        }
        
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failureBlock:^(NSString *error){
        NSLog(@"获取商家列表失败：%@",error);
        [self.tableView.header endRefreshing];
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MerchantArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 30)];
    headerView.backgroundColor = RGB(240, 239, 237);
    
    //
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_width-10-40, 30)];
    locationLabel.font = [UIFont systemFontOfSize:13];
    locationLabel.text = @"当前：海淀区中关村大街";
    locationLabel.textColor = [UIColor lightGrayColor];
    [headerView addSubview:locationLabel];
    
    //
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(screen_width-30, 5, 20, 20);
    [refreshBtn setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(OnRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:refreshBtn];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"merchantCell";
    JZMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[JZMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    JZMerchantModel *jzMerM = _MerchantArray[indexPath.row];
    cell.jzMerM = jzMerM;
//    [cell setJzMerM:jzMerM];//都行
    
    return cell;
}



#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
