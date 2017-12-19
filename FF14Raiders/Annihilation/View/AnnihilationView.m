//
//  AnnihilationView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/18.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "AnnihilationView.h"
@interface AnnihilationView()
@property(nonatomic, strong) UIImageView *topImageView;
@property(nonatomic, strong) UILabel *nameLabel;  //名称
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UILabel *versionLabel; //版本
@property(nonatomic, strong) UILabel *illustrateLabel; //官方


@end
@implementation AnnihilationView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
        [self initWithView];
    }
    return self;
}
-(void)initWithView
{
    //顶部图片
    self.topImageView = [UIImageView new];
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    //级别
    UIView *levelView = [[UIView alloc] init];
    levelView.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    levelView.layer.masksToBounds = YES;
    levelView.layer.cornerRadius = LineH(30)/2;
    [self.topImageView addSubview:levelView];
    [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_top).with.offset(5);
        make.left.equalTo(self.topImageView.mas_left).with.offset(5);
        make.height.mas_equalTo(LineH(30));
        make.width.mas_equalTo(LineW(30));
    }];
    self.levelLabel = [UILabel new];
    self.levelLabel.font = Font(12);
    self.levelLabel.textColor = UICOLOR_FROM_HEX(0x000000);
    [levelView addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(levelView.mas_centerX);
        make.centerY.equalTo(levelView.mas_centerY);
    }];
    //版本
    UIView *versionView = [[UIView alloc] init];
    versionView.backgroundColor = UICOLOR_FROM_HEX(0xa34754);
    versionView.layer.masksToBounds = YES;
    versionView.layer.cornerRadius = LineH(30)/2;
    [self.topImageView addSubview:versionView];
    [versionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_top).with.offset(5);
        make.right.equalTo(self.topImageView.mas_right).with.offset(-5);
        make.width.height.mas_equalTo(LineW(30));
    }];
    self.versionLabel = [UILabel new];
    self.versionLabel.font = Font(12);
    self.versionLabel.textColor = UICOLOR_FROM_HEX(0xffffff);
    [versionView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(versionView);
    }];
    //简介
    self.illustrateLabel = [UILabel new];
    self.illustrateLabel.numberOfLines = 0;
    self.illustrateLabel.font = Font(12);
    self.illustrateLabel.textColor = UICOLOR_FROM_HEX(0xffffff);
    [self addSubview:self.illustrateLabel];
    [self.illustrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
}
-(void)setModel:(AnnihilationModel *)model
{
    _model = model;
    NSURL *iconURL = [NSURL URLWithString:self.model.icon];
    [self.topImageView sd_setImageWithURL:iconURL];
    self.levelLabel.text = self.model.level;
    self.versionLabel.text = @"4.0版";
    self.illustrateLabel.text = self.model.illustrate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
