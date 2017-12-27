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
@property(nonatomic, strong) UILabel *placeLabel;  //地点
@property(nonatomic, strong) UILabel *timeLimitLabel; //限制时间
@property(nonatomic, strong) UILabel *protectLabel; //防护
@property(nonatomic, strong) UILabel *auxiliaryLabel; //辅助
@property(nonatomic, strong) UILabel *attackLabel;  //DPS
@property(nonatomic, strong) UILabel *jinbiLabel; //金币
@property(nonatomic, strong) UILabel *jingyanLabel;  //经验
@property(nonatomic, strong) UILabel *gradeLabel;
@property(nonatomic, strong) UILabel *addUserLabel;
@property(nonatomic, strong) UILabel *numberRestrictionLabel;
@property(nonatomic, strong) UIWebView *webView;
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
    self.illustrateLabel.font = Font(14);
    //文字多时Label的宽度要设置一个预估最大值才可自动换行
    self.illustrateLabel.preferredMaxLayoutWidth = SCREEN_WIDTH()-10;
    self.illustrateLabel.textColor = UICOLOR_FROM_HEX(0xffffff);
    [self addSubview:self.illustrateLabel];
    [self.illustrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
    }];
    /* ------------------基本信息start------------------- */
    UILabel *jibenLabel = [[UILabel alloc] init];
    jibenLabel.font = Font(16);
    jibenLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    jibenLabel.text = @"基本信息";
    [self addSubview:jibenLabel];
    [jibenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.illustrateLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    UIView *jibenLine = [[UIView alloc] init];
    jibenLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:jibenLine];
    [jibenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jibenLabel.mas_bottom).offset(2);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(1);
    }];
    //任务地点
    UILabel *placeTitleLabel = [UILabel new];
    placeTitleLabel.text = @"任务地点：";
    placeTitleLabel.font = Font(14);
    placeTitleLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:placeTitleLabel];
    [placeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(jibenLine.mas_bottom).offset(5);
    }];
    self.placeLabel = [UILabel new];
    self.placeLabel.font = Font(14);
    self.placeLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    [self addSubview:self.placeLabel];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeTitleLabel.mas_centerY);
        make.left.equalTo(placeTitleLabel.mas_right).offset(0);
    }];
    //任务时限
    UILabel *timeLimitTitleLabel = [UILabel new];
    timeLimitTitleLabel.text = @"任务时限：";
    timeLimitTitleLabel.font = Font(14);
    timeLimitTitleLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:timeLimitTitleLabel];
    [timeLimitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(placeTitleLabel.mas_bottom).offset(5);
    }];
    self.timeLimitLabel = [UILabel new];
    self.timeLimitLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.timeLimitLabel.font = Font(14);
    [self addSubview:self.timeLimitLabel];
    [self.timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLimitTitleLabel.mas_centerY);
        make.left.equalTo(timeLimitTitleLabel.mas_right).offset(0);
    }];
    //队伍构成
    UILabel *ranksTitleLabel = [UILabel new];
    ranksTitleLabel.text = @"队伍构成：";
    ranksTitleLabel.font = Font(14);
    ranksTitleLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:ranksTitleLabel];
    [ranksTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(timeLimitTitleLabel.mas_bottom).offset(5);
    }];
    UIImageView *tIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t"]];
    [self addSubview:tIcon];
    [tIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(LineH(20));
        make.centerY.equalTo(ranksTitleLabel.mas_centerY);
        make.left.equalTo(ranksTitleLabel.mas_right).offset(0);
    }];
    //防护
    self.protectLabel = [UILabel new];
    self.protectLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.protectLabel.font = Font(14);
    [self addSubview:self.protectLabel];
    [self.protectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tIcon.mas_right).offset(3);
        make.centerY.equalTo(tIcon.mas_centerY);
    }];
    UIImageView *naiIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nai"]];
    [self addSubview:naiIcon];
    [naiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(LineH(20));
        make.centerY.equalTo(ranksTitleLabel.mas_centerY);
        make.left.equalTo(self.protectLabel.mas_right).offset(8);
    }];
    self.auxiliaryLabel = [UILabel new];
    self.auxiliaryLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.auxiliaryLabel.font = Font(14);
    [self addSubview: self.auxiliaryLabel];
    [self.auxiliaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naiIcon.mas_centerY);
        make.left.equalTo(naiIcon.mas_right).offset(3);
    }];
    UIImageView *dpsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dps"]];
    [self addSubview:dpsIcon];
    [dpsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naiIcon.mas_centerY);
        make.left.equalTo(self.auxiliaryLabel.mas_right).offset(8);
    }];
    self.attackLabel = [UILabel new];
    self.attackLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.attackLabel.font = Font(14);
    [self addSubview: self.attackLabel];
    [self.attackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dpsIcon.mas_centerY);
        make.left.equalTo(dpsIcon.mas_right).offset(3);
    }];
   
    /* ------------------基本信息end------------------- */
    
    /* ------------------战利品start------------------- */
    UILabel *spoilsLabel = [UILabel new];
    spoilsLabel.text = @"战利品";
    spoilsLabel.font = Font(16);
    spoilsLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:spoilsLabel];
    [spoilsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ranksTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    UIView *spoilsLine = [UIView new];
    spoilsLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:spoilsLine];
    [spoilsLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spoilsLabel.mas_bottom).offset(3);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(1);
    }];
    //奖励品
    UILabel *rewardLabel = [UILabel new];
    rewardLabel.text = @"奖励：";
    rewardLabel.font = Font(14);
    rewardLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:rewardLabel];
    [rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spoilsLine.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    self.jinbiLabel = [UILabel new];
    self.jinbiLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.jinbiLabel.font = Font(14);
    [self addSubview:self.jinbiLabel];
    [self.jinbiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rewardLabel.mas_right).offset(5);
        make.centerY.equalTo(rewardLabel.mas_centerY);
    }];
    UIImageView *jinbiIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jinbi"]];
    [self addSubview:jinbiIcon];
    [jinbiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinbiLabel.mas_right).offset(3);
        make.centerY.equalTo(self.jinbiLabel.mas_centerY);
        make.height.width.mas_equalTo(LineH(18));
    }];
    self.jingyanLabel = [UILabel new];
    self.jingyanLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.jingyanLabel.font = Font(14);
    [self addSubview:self.jingyanLabel];
    [self.jingyanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jinbiIcon.mas_right).offset(10);
        make.centerY.equalTo(self.jinbiLabel.mas_centerY);
    }];
    UIImageView *jingyanIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jingyan"]];
    [self addSubview:jingyanIcon];
    [jingyanIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jingyanLabel.mas_right).offset(3);
        make.centerY.equalTo(jinbiIcon.mas_centerY);
        make.height.width.mas_equalTo(LineH(18));
    }];
    /* ------------------战利品end------------------- */
    /* ------------------限制start------------------- */
    UILabel *limitLabel = [UILabel new];
    limitLabel.text = @"限制";
    limitLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    limitLabel.font = Font(14);
    [self addSubview:limitLabel];
    [limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rewardLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    UIView *limitLine = [UIView new];
    limitLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:limitLine];
    [limitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
        make.top.equalTo(limitLabel.mas_bottom).offset(3);
    }];
    UILabel *gradeTitleLabel = [self createLabel:@"等级要求：" textColor:UICOLOR_FROM_HEX(0xbbac94)];
    [self addSubview:gradeTitleLabel];
    [gradeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(limitLine.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    self.gradeLabel = [self createLabel:@"" textColor:UICOLOR_FROM_HEX(0xdddddd)];
    [self addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gradeTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(gradeTitleLabel.mas_centerY);
    }];
    UILabel *addUserTitleLabel = [self createLabel:@"允许中途加入：" textColor:UICOLOR_FROM_HEX(0xbbac94)];
    [self addSubview:addUserTitleLabel];
    [addUserTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(gradeTitleLabel.mas_left).offset(0);
    }];
    self.addUserLabel = [self createLabel:@"" textColor:UICOLOR_FROM_HEX(0xdddddd)];
    [self addSubview:self.addUserLabel];
    [self.addUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addUserTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(addUserTitleLabel.mas_centerY);
    }];
    UILabel *numberRestrictionTitleLabel = [self createLabel:@"允许解除人数限制：" textColor:UICOLOR_FROM_HEX(0xbbac94)];
    [self addSubview:numberRestrictionTitleLabel];
    [numberRestrictionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addUserTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(addUserTitleLabel.mas_left);
    }];
    self.numberRestrictionLabel = [self createLabel:@"" textColor:UICOLOR_FROM_HEX(0xdddddd)];
    [self addSubview:self.numberRestrictionLabel];
    [self.numberRestrictionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberRestrictionTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(numberRestrictionTitleLabel.mas_centerY);
    }];
    
    /* ------------------限制end------------------- */
}
-(void)setModel:(AnnihilationModel *)model
{
    _model = model;
    NSURL *iconURL = [NSURL URLWithString:self.model.icon];
    [self.topImageView sd_setImageWithURL:iconURL];
    self.levelLabel.text = self.model.level;
    self.versionLabel.text = @"4.0版";
    self.illustrateLabel.text = self.model.illustrate;
    //设置UILabel的分段缩进
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    //设置缩进间隔
    style.firstLineHeadIndent = LineX(30);
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.model.illustrate attributes:@{ NSParagraphStyleAttributeName : style}];
    self.illustrateLabel.attributedText = attrText;
    self.placeLabel.text = self.model.place;
    self.timeLimitLabel.text = self.model.time_limit;
    self.protectLabel.text = [NSString stringWithFormat:@"%@",self.model.structure[@"fanghu"]];
    self.auxiliaryLabel.text = [NSString stringWithFormat:@"%@",self.model.structure[@"nai"]];
    self.attackLabel.text = [NSString stringWithFormat:@"%@",self.model.structure[@"dps"]];
    self.jinbiLabel.text = [NSString stringWithFormat:@"%@",self.model.prize_types[0]];
    self.jingyanLabel.text = [NSString stringWithFormat:@"%@",self.model.prize_types[1]];
    self.gradeLabel.text = self.model.rank;
    if(self.model.putin == 1){
        self.addUserLabel.text = @"是";
    }else{
        self.addUserLabel.text = @"否";
    }
    if(self.model.number_restriction == 1){
        self.numberRestrictionLabel.text = @"是";
    }else{
        self.numberRestrictionLabel.text = @"否";
    }
    NSLog(@"%@",self.model.video_path);
    if(!IsStrEmpty(self.model.video_path)){
        [self initButton];
        //[self initWebView:self.model.video_path];
    }
}
-(void)initButton{
    self.videoButton = [[UIButton alloc] init];
    [self.videoButton setTitleColor:UICOLOR_FROM_HEX(0xbbac94) forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"items_btn"] forState:UIControlStateNormal];
    [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.videoButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(160));
        make.height.mas_equalTo(LineH(30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.numberRestrictionLabel.mas_bottom).with.offset(10);
    }];
    self.lineV = [[UIView alloc] init];
    
    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.videoButton.mas_bottom).with.offset(0);
    }];
}
-(void)initWebView:(NSString *)url
{
    self.webView = [[UIWebView alloc] init];
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberRestrictionLabel.mas_bottom).with.offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(LineH(300));
    }];
    NSURL *path = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:path];
    [self.webView loadRequest:request];
    self.lineV = [[UIView alloc] init];
    
    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.webView.mas_bottom).with.offset(0);
    }];
}
-(UILabel *)createLabel:(NSString *)labelText textColor:(UIColor *)color{
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.text = labelText;
    label.font = Font(14);
    return label;
}
-(void)videoButtonClick
{
    if(self.delegateSignal){
        [self.delegateSignal sendNext:nil];
    }
}
@end
