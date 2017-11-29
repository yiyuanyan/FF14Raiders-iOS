//
//  DungeonContentView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "DungeonContentView.h"
@interface DungeonContentView()
@property(nonatomic, strong) UIImageView *topImage;
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UILabel *versionTypeLabel;
//任务地点
@property(nonatomic, strong) UILabel *placeLabel;
//任务时限
@property(nonatomic, strong) UILabel *timeLimitLabel;
//T
@property(nonatomic, strong) UILabel *protectLabel;
//辅助
@property(nonatomic, strong) UILabel *auxiliaryLabel;
//DPS
@property(nonatomic, strong) UILabel *attackLabel;
//首领数量
@property(nonatomic, strong) UILabel *bossNumLabel;
//金币
@property(nonatomic, strong) UILabel *jinbiLabel;
//经验
@property(nonatomic, strong) UILabel *jingyanLabel;
//等级要求
@property(nonatomic, strong) UILabel *gradeLabel;
//允许中途加入
@property(nonatomic, strong) UILabel *addUserLabel;

@end
@implementation DungeonContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initWithView];
    }
    return self;
}
-(void)initWithView{
    self.topImage = [[UIImageView alloc] init];
    [self addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    //级别限制
    UIView *levelView = [[UIView alloc] init];
    levelView.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    [self.topImage addSubview:levelView];
    [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.height.width.mas_equalTo(LineW(30));
    }];
    levelView.layer.cornerRadius = LineH(30)/2;
    levelView.layer.masksToBounds = YES;
    self.levelLabel = [[UILabel alloc] init];
    self.levelLabel.font = Font(12);
    [levelView addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(levelView.mas_centerX);
        make.centerY.mas_equalTo(levelView.mas_centerY);
    }];
    //版本限制
    UIView *versionTypeView = [[UIView alloc] init];
    versionTypeView.backgroundColor = UICOLOR_FROM_HEX(0xac4153);
    [self.topImage addSubview:versionTypeView];
    [versionTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.width.mas_equalTo(LineW(30));
    }];
    versionTypeView.layer.cornerRadius = LineH(30)/2;
    versionTypeView.layer.masksToBounds = YES;
    self.versionTypeLabel = [[UILabel alloc] init];
    self.versionTypeLabel.font = Font(12);
    self.versionTypeLabel.textColor = UICOLOR_FROM_HEX(0xffffff);
    [versionTypeView addSubview:self.versionTypeLabel];
    [self.versionTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(versionTypeView.mas_centerX);
        make.centerY.mas_equalTo(versionTypeView.mas_centerY);
    }];
    /* ------------------基本信息start------------------- */
    UILabel *jibenLabel = [[UILabel alloc] init];
    jibenLabel.font = Font(16);
    jibenLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    jibenLabel.text = @"基本信息";
    [self addSubview:jibenLabel];
    [jibenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).offset(10);
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
    UILabel *bossNumTitleLabel = [UILabel new];
    bossNumTitleLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    bossNumTitleLabel.text = @"首领数量：";
    bossNumTitleLabel.font = Font(14);
    [self addSubview:bossNumTitleLabel];
    [bossNumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ranksTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    self.bossNumLabel = [UILabel new];
    self.bossNumLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.bossNumLabel.font = Font(14);
    [self addSubview:self.bossNumLabel];
    [self.bossNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bossNumTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(bossNumTitleLabel.mas_centerY);
    }];
    /* ------------------基本信息end------------------- */
    
    /* ------------------战利品start------------------- */
    UILabel *spoilsLabel = [UILabel new];
    spoilsLabel.text = @"战利品";
    spoilsLabel.font = Font(16);
    spoilsLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:spoilsLabel];
    [spoilsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bossNumTitleLabel.mas_bottom).offset(10);
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
    UILabel *gradeTitleLabel = [self createLabel:@"等级限制：" textColor:UICOLOR_FROM_HEX(0xbbac94)];
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

-(UILabel *)createLabel:(NSString *)labelText textColor:(UIColor *)color{
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.text = labelText;
    label.font = Font(14);
    return label;
}
-(void)setModel:(DungeonContentModel *)model
{
    NSURL *url = [NSURL URLWithString:model.image];
    [self.topImage sd_setImageWithURL:url];
    self.levelLabel.text = model.start_level;
    if(model.version_type == 4){
        self.versionTypeLabel.text = @"4.0版";
    }
    self.placeLabel.text = model.place;
    self.timeLimitLabel.text = model.time_limit;
    self.protectLabel.text = model.protect;
    self.auxiliaryLabel.text = model.auxiliary;
    self.attackLabel.text = model.attack;
    self.bossNumLabel.text = model.boss_num;
    self.jinbiLabel.text = model.reward[0];
    self.jingyanLabel.text = model.reward[1];
    self.gradeLabel.text = model.grade;
    if(model.add_user == 1){
        self.addUserLabel.text = @"是";
    }else{
        self.addUserLabel.text = @"否";
    }
    if(model.number_restriction == 1){
        self.numberRestrictionLabel.text = @"是";
    }else{
        self.numberRestrictionLabel.text = @"否";
    }
    
    
    
}
@end
