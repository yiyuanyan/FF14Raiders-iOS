//
//  DungeonContentController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/17.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "DungeonContentController.h"
#import "DungeonContentModel.h"
#import "DungeonContentView.h"
#import "DungeonBossModel.h"
#import "DungeonBossView.h"
#import "ItemsCollectionController.h"
@interface DungeonContentController ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) DungeonContentView *contentView;
@property(nonatomic, strong) DungeonContentModel *contentModel;
@property(nonatomic, strong) DungeonBossModel *bossModel;
@property(nonatomic, strong) NSArray *bossModels;
@property(nonatomic, strong) NSString *bossName;
@property(nonatomic, strong) DungeonBossView *bossView;
@property(nonatomic, strong) void(^itemsButtonBlock)(NSInteger index);
@end

@implementation DungeonContentController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.title = self.navTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:UICOLOR_FROM_HEX(0xbbac94)}];
    //设置导航栏背景色
    self.navigationController.navigationBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goToBack)];
    //设置状态栏背景色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    
    self.scrollView.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view).offset(0);
    }];
    [self getJSON];
    
}

-(void)getJSON{
    [MBProgressHUD showLoading:self.view];
    NSString *url = [NSString stringWithFormat:@"%@/api/getdungeon/%d",APP_URL,self.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            DungeonContentModel *model = [DungeonContentModel yy_modelWithJSON:responseObject[@"data"]];
            self.contentModel = model;
            [self getDungeonBoss:model.name];
            
            [self initWithContentView];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力..." toView:self.view];
    }];
}

-(void)getDungeonBoss:(NSString *)dungeon{
    
    NSString *url = [NSString stringWithFormat:@"%@api/getdungeonboss/%@",APP_URL,dungeon];
    
    //URL编码
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                DungeonBossModel *model = [DungeonBossModel yy_modelWithJSON:dic];
                [mArray addObject:model];
            }
            self.bossModels = mArray;
            [self initWithBossView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void) goToBack{
    self.navigationController.navigationBar.hidden = YES;
    //返回上一级会显示状态栏高，这里将本级的状态栏也设置为透明。
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) initWithContentView{
    
    self.contentView = [[DungeonContentView alloc] init];
    self.contentView.model = self.contentModel;
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.numberRestrictionLabel.mas_bottom).with.offset(10);
    }];
    [self.contentView layoutIfNeeded];
   
    
}
-(void)initWithBossView{
    self.bossView = [[DungeonBossView alloc] init];
    self.bossView.modelArray = self.bossModels;
    [self.scrollView addSubview:self.bossView];
    [self.bossView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    
    [self.bossView layoutIfNeeded];
    [self.scrollView layoutIfNeeded];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(self.bossView.mas_bottom);
    }];
    __weak typeof (self) weakself = self;
    self.bossView.buttonAction = ^(UIButton *sender) {
        [weakself pushToNewPage:sender];
    };
    [MBProgressHUD hideHUDForView:self.view];
    //self.scrollView.contentSize = CGSizeMake(0, self.bossView.frame.origin.y+self.bossView.frame.size.height);
}
-(void)pushToNewPage:(UIButton *)sender
{
    DungeonBossModel *model = self.bossModels[sender.tag];
    NSLog(@"%@",model.name);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    ItemsCollectionController *vc = [[ItemsCollectionController alloc] initWithCollectionViewLayout:flowLayout];
    vc.name = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
