//
//  AnnihilationController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/14.
//  Copyright © 2017年 何建新. All rights reserved.
//  歼灭

#import "AnnihilationController.h"

@interface AnnihilationController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *topImageView;
@end

@implementation AnnihilationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    // Do any additional setup after loading the view.
    [MBProgressHUD showLoading:self.view];
    self.topImageView = [[UIImageView alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://ff14.hejianxin.com/uploads/20171116/ca0fd4fa90092d6e925d32ae01ba840c.jpg"];
    [self.topImageView sd_setImageWithURL:url];
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(LineH(138));
    }];
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
