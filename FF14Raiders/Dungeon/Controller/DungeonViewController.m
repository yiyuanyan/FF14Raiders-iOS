//
//  DungeonViewController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/14.
//  Copyright © 2017年 何建新. All rights reserved.
//  副本

#import "DungeonViewController.h"
#import "DungeonTableViewCell.h"
#import "DungeonContentController.h"
#import "DungeonModel.h"
@interface DungeonViewController ()<UITableViewDelegate , UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *topImageView;
@property(nonatomic, strong) NSArray *dataSource;
@end

@implementation DungeonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showLoading:self.view];
    [self getJSON];
    
    self.topImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(LineH(138));
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UIAccessibilityTraitNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.mas_equalTo(self.view);
    }];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.tableView.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    
}
-(void)getJSON{
    
    self.tableView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"%@api.php/api/getjson/get_dungeonall",APP_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                DungeonModel *model = [DungeonModel yy_modelWithJSON:dic];
                [mArray addObject:model];
            }
            self.dataSource = mArray;
            NSURL *topImageURL = [NSURL URLWithString:responseObject[@"image"]];
            [self.topImageView sd_setImageWithURL:topImageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力..." toView:self.view];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DungeonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dungeonCell"];
    if(cell == nil){
        cell = [[DungeonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dungeonCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DungeonContentController *vc = [[DungeonContentController alloc] init];
    DungeonModel *model = self.dataSource[indexPath.row];
    vc.id = model.id;
    vc.navTitle = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

@end
