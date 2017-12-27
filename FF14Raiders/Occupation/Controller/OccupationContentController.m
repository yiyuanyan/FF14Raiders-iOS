//
//  OccupationContentController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/25.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "OccupationContentController.h"
#import "OccupationView.h"
#import "ContentModel.h"
#import "HeaderView.h"

#import "OccupationTableViewCell.h"
@interface OccupationContentController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ContentModel *model;
@end

@implementation OccupationContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = UICOLOR_RANDOM_COLOR();
    
    self.title = self.name;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UICOLOR_FROM_HEX(0x2b2b2b);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    [self getJSON];
}
-(void)getJSON{
    [MBProgressHUD showLoading:self.view];
    NSString *url = [NSString stringWithFormat:@"%@api/get_occupation_one/%d",APP_URL,self.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject[@"status"] intValue] == 1){
            ContentModel *m = [ContentModel yy_modelWithJSON:responseObject[@"data"]];
            self.model = m;
            [self setHeaderView];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力..." toView:self.view];
    }];
}
-(void)setHeaderView
{
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), 100)];
    headerView.model = self.model;
    [headerView layoutIfNeeded];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH(), LineH(headerView.bottomView.frame.origin.y + headerView.bottomView.frame.size.height));
    self.tableView.tableHeaderView = headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)self.model.skill.count);
    return self.model.skill.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OccupationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"occCell"];
    if(cell == nil){
        cell = [[OccupationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"occCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = self.model.skill[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(50);
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
