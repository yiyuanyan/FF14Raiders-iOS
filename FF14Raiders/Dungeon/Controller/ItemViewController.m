//
//  ItemViewController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemModel.h"
#import "ItemView.h"
@interface ItemViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) ItemModel *model;
@property(nonatomic, strong) ItemView *contentView;
@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x262626);
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    
    self.scrollView.frame = self.view.frame;
    self.scrollView.backgroundColor = UICOLOR_FROM_HEX(0x262626);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(69, 5, 5, 5));
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    self.contentView = [[ItemView alloc] init];
    self.contentView.model = self.model;
    [self getJSON];
    [self initNav];
    [MBProgressHUD showLoading:self.view];
}
-(void)getJSON{
    
    NSString *url = [NSString stringWithFormat:@"%@api/getgooditems/%d",APP_URL,self.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            ItemModel *m = [ItemModel yy_modelWithJSON:responseObject[@"data"]];
            self.model = m;
            [self initWithView];
            [MBProgressHUD hideHUDForView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:error.userInfo[@"msg"] toView:self.view];
    }];
}
-(void)initNav{
    //标题
    self.title = self.name;
    //设置标题文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:UICOLOR_FROM_HEX(0xbbac94)}];
    //设置导航栏背景色
    self.navigationController.navigationBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    //设置返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goToBack)];
    
}
-(void)initWithView
{
    self.contentView = [ItemView new];
    self.contentView.model = self.model;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6.0f;

    self.contentView.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.bottom.equalTo(self.scrollView.mas_bottom).with.offset(0);
    }];
    [self.contentView layoutIfNeeded];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.lineView.mas_bottom).with.offset(0);
    }];
}
-(void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
