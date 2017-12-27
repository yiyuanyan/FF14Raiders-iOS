//
//  AnnihilationController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/14.
//  Copyright © 2017年 何建新. All rights reserved.
//  歼灭

#import "AnnihilationController.h"
#import "AnnihilationCellModel.h"
#import "AnnihilationCell.h"
#import "AnnihilationContentController.h"
@interface AnnihilationController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *topImageView;
@property(nonatomic, strong) NSArray *modelArray;
@end

@implementation AnnihilationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getJSON];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.topImageView = [[UIView alloc] init];
//    NSURL *url = [NSURL URLWithString:@"http://ff14.hejianxin.com/uploads/20171116/ca0fd4fa90092d6e925d32ae01ba840c.jpg"];
//    [self.topImageView sd_setImageWithURL:url];
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(LineH(138));
    }];
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).with.offset(0);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}
-(void)getJSON {
    [MBProgressHUD showLoading:self.view];
    NSString *url = [NSString stringWithFormat:@"%@api/getcrusadeall",APP_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if([responseObject[@"status"] intValue] == 1){
            [self initWithTopImage:responseObject[@"category"]];
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                AnnihilationCellModel *model = [AnnihilationCellModel yy_modelWithJSON:dic];
                [mArray addObject:model];
            }
            self.modelArray = mArray;
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力...." toView:self.view];
    }];
}
-(void)initWithTopImage:(NSString *)imagePath
{
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_URL,imagePath]]];
    [self.topImageView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.topImageView);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnihilationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnCell"];
    if(cell == nil){
        cell = [[AnnihilationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnnCell"];
    }
    AnnihilationCellModel *model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnihilationContentController *vc = [AnnihilationContentController new];
    AnnihilationCellModel *model = self.modelArray[indexPath.row];
    vc.id = (int)model.id;
    vc.name = model.name;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(65);
}
@end
