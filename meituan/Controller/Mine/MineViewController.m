//
//  MineViewController.m
//  meituan
//
//  Created by jinzelu on 15/7/6.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
}
@end

@implementation MineViewController

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
    _dataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"团购订单" forKey:@"title"];
    [dic1 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"预定订单" forKey:@"title"];
    [dic2 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"上门订单" forKey:@"title"];
    [dic3 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"我的评价" forKey:@"title"];
    [dic4 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:@"每日推荐" forKey:@"title"];
    [dic5 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic5];
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc] init];
    [dic6 setObject:@"会员俱乐部" forKey:@"title"];
    [dic6 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic6];
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc] init];
    [dic7 setObject:@"我的抽奖" forKey:@"title"];
    [dic7 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic7];
    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc] init];
    [dic8 setObject:@"我的抵用券" forKey:@"title"];
    [dic8 setObject:@"icon_mine_onsite" forKey:@"image"];
    [_dataSourceArray addObject:dic8];
    
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 8;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 75;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 40;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
//        headerView.backgroundColor = [UIColor greenColor];
        headerView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_login"]];
        //头像
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
        userImage.layer.masksToBounds = YES;
        userImage.layer.cornerRadius = 27;
        [userImage setImage:[UIImage imageNamed:@"icon_mine_default_portrait"]];
        [headerView addSubview:userImage];
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 15, 200, 30)];
        userNameLabel.font = [UIFont systemFontOfSize:13];
        userNameLabel.text = @"波雅.汉库克";
        [headerView addSubview:userNameLabel];
        //账户余额
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 40, 200, 30)];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.text = @"账户余额：0.00元";
        [headerView addSubview:moneyLabel];
        
        //
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-10-24, 30, 12, 24)];
        [arrowImg setImage:[UIImage imageNamed:@"icon_mine_accountViewRightArrow"]];
        [headerView addSubview: arrowImg];
        
        return headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
        headerView.backgroundColor = RGB(239, 239, 244);
        return headerView;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [_dataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_dataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else{
        cell.textLabel.text = @"我的标题";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
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
