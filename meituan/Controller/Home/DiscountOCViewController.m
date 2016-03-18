//
//  DiscountOCViewController.m
//  meituan
//
//  Created by jinzelu on 15/7/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DiscountOCViewController.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"

#import "DisTopicModel.h"
#import "DisLabelModel.h"
#import "DisDealModel.h"


#import "DisTopicCell.h"
#import "RecommendCell.h"

@interface DiscountOCViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_titleLabel;
    
    //
    UIImageView *_topicImage;
    
    
    //tableview数据源
    DisTopicModel *_topicData;
    NSMutableArray *_labelArray;
    NSMutableArray *_dealArray;
}
@end

@implementation DiscountOCViewController

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
    
    [self initData];
    
    [self setNav];
    [self initViews];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        [self getOCDiscountData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _topicData = [[DisTopicModel alloc] init];
    _labelArray = [[NSMutableArray alloc] init];
    _dealArray = [[NSMutableArray alloc] init];
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
    _titleLabel.text = self.title;
    //    _titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:_titleLabel];
    
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getOCDiscountData{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/group/v1/deal/topic/discount/city/1/detail/%@?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=74R1QjiyuJg%2BOzAqIUfOXDpTA2M%3D&__skno=A3C85DF9-B5C1-4623-8AB4-8D978B0A50E6&__skts=1435891962.015266&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&limit=40&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-03-09-14430&offset=0&userid=10086&utm_campaign=AgroupBgroupD100Fab_i_group_5_3_poidetaildeallist__a__b___ab_gxhceshi0202__b__a___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_topic3_8012&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",self.ID];
    NSLog(@"折扣详情url:%@",urlStr);
    __weak __typeof(self) weakself = self;
    [[NetworkSingleton sharedManager] getOCDiscountResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求折扣详情成功");
        NSDictionary *dataDic = [responseBody objectForKey:@"data"];
        
        NSDictionary *topicDic = [dataDic objectForKey:@"topic"];
        NSArray *labelsArray = [dataDic objectForKey:@"labels"];
        NSArray *dealsArray = [dataDic objectForKey:@"deals"];
        
        //
        _topicData = [DisTopicModel objectWithKeyValues:topicDic];
        
        //
        [_labelArray removeAllObjects];
        for (int i = 0; i < labelsArray.count; i++) {
            DisLabelModel *labelM = [DisLabelModel objectWithKeyValues:labelsArray[i]];
            [_labelArray addObject:labelM];
        }
        
        //
        [_dealArray removeAllObjects];
        for (int i = 0; i < dealsArray.count; i++) {
            DisDealModel *dealM = [DisDealModel objectWithKeyValues:dealsArray[i]];
            [_dealArray addObject:dealM];
        }
        
        
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error){
        NSLog(@"请求折扣详情失败：%@",error);
    }];
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        if (_dealArray.count == 0) {
            return 0;
        }
        return 1+_dealArray.count;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_labelArray.count == 0) {
            return 0.0;
        }else{
            return 160+40;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 30.0;
        }else{
            return 100;
        }
    }else{
        if (indexPath.row == 0) {
            return 30.0;
        }else{
            return 100;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 10)];
    headerView.backgroundColor = RGB(239, 239, 244);
    //    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0)];
    footerView.backgroundColor = RGB(239, 239, 244);
    //    footerView.backgroundColor = [UIColor yellowColor];
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_labelArray.count != 0) {
            static NSString *cellIndentifier = @"topicCell";
            DisTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[DisTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            
            if (_labelArray.count!=0) {
                [cell setTopic:_topicData labelsArr:_labelArray];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellIndentifier = @"nomoreCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"Cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            
            cell.textLabel.text = ((DisLabelModel *)_labelArray[0]).lname;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellIndentifier = @"dealCell1";
            RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            
            if (_dealArray.count != 0) {
                DisDealModel *dealM = _dealArray[indexPath.row-1];
//                cell.shopNameLabel.text = dealM.mname;
                [cell setDealData:dealM];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else{
        static NSString *cellIndentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}



#pragma mark - UITableViewDelegate



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
