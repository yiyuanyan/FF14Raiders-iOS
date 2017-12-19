//
//  AnnihilationContentController.m
//  FF14Raiders
//
//  Created by Talk GoGo on 2017/12/15.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "AnnihilationContentController.h"
#import "AnnihilationModel.h"
#import "AnnihilationView.h"
@interface AnnihilationContentController ()
@property(nonatomic, strong) NSArray *modelArray;
@end

@implementation AnnihilationContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    [self getJSON];
}
-(void)getJSON{
    [MBProgressHUD showLoading:self.view];
    NSString *url = [NSString stringWithFormat:@"%@api/getcrusadeon/%d",APP_URL,self.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *mArray = [NSMutableArray array];
        if([responseObject[@"status"] integerValue] == 1){
            AnnihilationModel *model = [AnnihilationModel yy_modelWithJSON:responseObject[@"data"]];
            [mArray addObject:model];
        }
        self.modelArray = mArray;
        [MBProgressHUD hideHUDForView:self.view];
        [self initView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力...." toView:self.view];
    }];
}
-(void)initView{
    AnnihilationView *AnView = [[AnnihilationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT())];
    AnnihilationModel *m = self.modelArray[0];
    AnView.model = m;
    [self.view addSubview:AnView];
    [AnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64);
    }];
    
}
-(void)setNavigation{
    self.title = self.name;
    //设置导航栏文字样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:UICOLOR_FROM_HEX(0xbbac94)}];
    self.navigationController.navigationBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goToBack)];
    //状态栏背景色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
}
-(void)goToBack{
    self.navigationController.navigationBar.hidden = YES;
    //返回上一级会显示状态栏高，这里将本级的状态栏也设置为透明。
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];
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
