//
//  ProductionContentController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/28.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionContentController.h"
#import "ProductionTableHeaderView.h"
#import "ProductionTableViewCell.h"
#import "ProductionTableViewModel.h"
@interface ProductionContentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ProductionTableViewModel *model;
@end

@implementation ProductionContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;

    
    [self builTableView];
    
}
-(void)getJSON{
    [MBProgressHUD showLoading:self.view];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@api/get_occupation_one/%d",APP_URL,self.id] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] intValue] == 1){
            ProductionTableViewModel *model = [ProductionTableViewModel yy_modelWithJSON:responseObject[@"data"]];
            self.model = model;
        }
        NSLog(@"%@",self.model);
        [self builTableHeaderView];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力" toView:self.view];
    }];
}
-(void)builTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
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
-(void)builTableHeaderView
{
    ProductionTableHeaderView *headerView = [[ProductionTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), 210)];
    headerView.model = self.model;
    [headerView layoutIfNeeded];
    self.tableView.tableHeaderView = headerView;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProductionTableViewModel *model = self.model;
    return model.skill.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[ProductionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    ProductionTableViewModel *model = self.model;
    cell.info = model.skill[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(50);
}
@end
