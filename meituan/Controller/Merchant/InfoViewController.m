//
//  InfoViewController.m
//  meituan
//
//  Created by jinzelu on 15/6/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "InfoViewController.h"
#import "JZMenuCell.h"

@interface InfoViewController ()<UITableViewDataSource,UITableViewDelegate,JZMenuCellDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"JZMenuCell";
    JZMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[JZMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];        
    }
    
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - JZMenuCellDelegate
-(BOOL)JZMenuCell:(JZMenuCell *)menuCell didPullCell:(NSInteger)index{
    NSLog(@"index:%ld",index);
    
    [menuCell closeCellWithTableView:self.tableView index:index animation:YES];
    return NO;
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
