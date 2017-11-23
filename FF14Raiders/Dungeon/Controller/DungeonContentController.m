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
@interface DungeonContentController ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) DungeonContentView *contentView;
@property(nonatomic, strong) DungeonContentModel *contentModel;
@end

@implementation DungeonContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.title = self.navTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:UICOLOR_FROM_HEX(0xbbac94)}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goToBack)];
    //self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT())];
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
    NSString *url = [NSString stringWithFormat:@"%@api.php/api/getjson/get_dungeon/id/%d",APP_URL,self.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            DungeonContentModel *model = [DungeonContentModel yy_modelWithJSON:responseObject[@"data"]];
            self.contentModel = model;
            [self initWithContentView];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void) goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) initWithContentView{
    
    self.contentView = [[DungeonContentView alloc] init];
    self.contentView.model = self.contentModel;
    self.contentView.frame = self.scrollView.frame;
    [self.scrollView addSubview:self.contentView];
    [self.contentView layoutIfNeeded];
    //
    
    NSLog(@"%lf",self.contentView.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(0, self.contentView.frame.size.height);
    
    
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
