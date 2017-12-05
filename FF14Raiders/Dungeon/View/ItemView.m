//
//  ItemView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ItemView.h"
@interface ItemView()
@property(nonatomic, strong) UIImageView *itemImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *partsLabel;
@property(nonatomic, strong) UILabel *physicsLabel;
@property(nonatomic, strong) UILabel *magicLabel;
@property(nonatomic, strong) UILabel *gradeLabel;
@property(nonatomic, strong) UILabel *professionLabel;
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UIView *teshuLine;
@property(nonatomic, strong) UILabel *xiuliLevelLabel;
@property(nonatomic, strong) UILabel *wuzhiLabel;
@property(nonatomic, strong) NSMutableArray *teshuArray;
@property(nonatomic, strong) UIView *mojingView;
@property(nonatomic, assign) int mojingcount;
//计数器
@property(nonatomic, assign) int counter;
@end
@implementation ItemView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithContentView];
    }
    return self;
}
-(void)initWithContentView
{
    self.itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item"]];
    [self addSubview:self.itemImageView];
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.height.width.mas_equalTo(LineW(64));
    }];
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = UICOLOR_FROM_HEX(0xc0ffc0);
    self.nameLabel.font = Font(20);
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemImageView.mas_right).with.offset(5);
        make.top.equalTo(self.itemImageView.mas_top).with.offset(5);
        make.height.mas_equalTo(LineH(20));
    }];
    self.partsLabel = [UILabel new];
    self.partsLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.partsLabel.font = Font(14);
    [self addSubview:self.partsLabel];
    [self.partsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).with.offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(LineH(14));
    }];
    //物理
    UILabel *wuliLabel = [UILabel new];
    wuliLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    wuliLabel.font = Font(14);
    wuliLabel.text = @"物理防御";
    [self addSubview:wuliLabel];
    [wuliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LineX(120));
        make.top.equalTo(self.itemImageView.mas_bottom).with.offset(LineH(15));
        make.height.mas_equalTo(LineH(14));
    }];
    UIView *wuliBottomView = [UIView new];
    wuliBottomView.backgroundColor = UICOLOR_FROM_HEX(0x484848);
    wuliBottomView.layer.masksToBounds = YES;
    wuliBottomView.layer.cornerRadius = 2.0f;
    [self addSubview:wuliBottomView];
    [wuliBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wuliLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(LineW(80));
        make.height.mas_equalTo(LineH(4));
        make.top.equalTo(wuliLabel.mas_bottom).with.offset(LineH(15));
    }];
    self.physicsLabel = [UILabel new];
    self.physicsLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.physicsLabel.font = Font(20);
    [self addSubview:self.physicsLabel];
    [self.physicsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wuliLabel.mas_right).with.offset(0);
        make.top.equalTo(wuliLabel.mas_bottom).with.offset(2);
        make.height.mas_equalTo(LineH(20));
    }];
    
    UILabel *mofaLabel = [UILabel new];
    mofaLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
    mofaLabel.font = Font(14);
    mofaLabel.text = @"物理防御";
    [self addSubview:mofaLabel];
    [mofaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wuliLabel.mas_right).with.offset(LineX(50));
        make.top.equalTo(self.itemImageView.mas_bottom).with.offset(LineH(15));
        make.height.mas_equalTo(LineH(14));
    }];
    UIView *mofaBottomView = [UIView new];
    mofaBottomView.backgroundColor = UICOLOR_FROM_HEX(0x484848);
    mofaBottomView.layer.masksToBounds = YES;
    mofaBottomView.layer.cornerRadius = 2.0f;
    [self addSubview:mofaBottomView];
    [mofaBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mofaLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(LineW(80));
        make.height.mas_equalTo(LineH(4));
        make.top.equalTo(mofaLabel.mas_bottom).with.offset(LineH(15));
    }];
    self.magicLabel = [UILabel new];
    self.magicLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.magicLabel.font = Font(20);
    [self addSubview:self.magicLabel];
    [self.magicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mofaLabel.mas_right).with.offset(0);
        make.top.equalTo(mofaLabel.mas_bottom).with.offset(2);
        make.height.mas_equalTo(LineH(20));
    }];
    
    //分割线
    UIView *gradeView = [UIView new];
    gradeView.backgroundColor = UICOLOR_FROM_HEX(0x000000);
    [self addSubview:gradeView];
    [gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.top.equalTo(self.magicLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(26);
    }];
    self.gradeLabel = [UILabel new];
    self.gradeLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
    self.gradeLabel.font = Font(14);
    [gradeView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gradeView.mas_left).with.offset(20);
        make.centerY.equalTo(gradeView.mas_centerY);
    }];
    
    self.professionLabel = [UILabel new];
    self.professionLabel.numberOfLines = 0;
    self.professionLabel.textColor = UICOLOR_FROM_HEX(0xc0ffc0);
    self.professionLabel.font = Font(18);
    [self addSubview:self.professionLabel];
    [self.professionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LineX(30));
        make.right.equalTo(self.mas_right).with.offset(LineX(10));
        make.top.equalTo(gradeView.mas_bottom).with.offset(5);
    }];
    self.levelLabel = [UILabel new];
    self.levelLabel.numberOfLines = 0;
    self.levelLabel.textColor = UICOLOR_FROM_HEX(0xc0ffc0);
    self.levelLabel.font = Font(18);
    [self addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.professionLabel.mas_left).with.offset(0);
        make.top.equalTo(self.professionLabel.mas_bottom).with.offset(0);
    }];
    //特殊分割线
    UIView *teshuView = [UIView new];
    [self addSubview:teshuView];
    [teshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(LineH(20));
    }];
    UILabel *teshuLabel = [UILabel new];
    teshuLabel.text = @"特殊";
    teshuLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    teshuLabel.font = Font(14);
    [teshuView addSubview:teshuLabel];
    [teshuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(teshuView.mas_top).with.offset(0);
        make.left.equalTo(teshuView.mas_left).with.offset(0);
        make.height.mas_equalTo(LineH(14));
    }];
    self.teshuLine = [UIView new];
    self.teshuLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [teshuView addSubview:self.teshuLine];
    [self.teshuLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(teshuView.mas_left).with.offset(0);
        make.right.equalTo(teshuView.mas_right).with.offset(0);
        make.bottom.equalTo(teshuView.mas_bottom).with.offset(0);
    }];
    self.mojingView = [UIView new];
    [self addSubview:self.mojingView];
    [self.mojingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(teshuView.mas_left).with.offset(0);
        make.right.equalTo(teshuView.mas_right).with.offset(0);
        make.height.mas_equalTo(LineH(50));
    }];
    UILabel *mojingTitleLabel = [UILabel new];
    mojingTitleLabel.text = @"魔晶石";
    mojingTitleLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    mojingTitleLabel.font = Font(14);
    [self.mojingView addSubview:mojingTitleLabel];
    [mojingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mojingView.mas_top).with.offset(0);
        make.left.equalTo(self.mojingView.mas_left).with.offset(0);
        make.height.mas_equalTo(LineH(14));
    }];
    UIView *mojingLine = [UIView new];
    mojingLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self.mojingView addSubview:mojingLine];
    [mojingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(self.mojingView.mas_left).with.offset(0);
        make.right.equalTo(self.mojingView.mas_right).with.offset(0);
        make.top.equalTo(mojingTitleLabel.mas_bottom).with.offset(4);
    }];
    //修理
    UILabel *xiuliTitle = [UILabel new];
    xiuliTitle.textColor = UICOLOR_FROM_HEX(0x666666);
    xiuliTitle.font = Font(14);
    xiuliTitle.text = @"制作&修理";
    [self addSubview:xiuliTitle];
    [xiuliTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teshuLine.mas_left).with.offset(0);
        make.top.equalTo(self.mojingView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(LineH(14));
    }];
    UIView *xiuliLine = [UIView new];
    xiuliLine.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:xiuliLine];
    [xiuliLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teshuLine.mas_left).with.offset(0);
        make.right.equalTo(self.teshuLine.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(xiuliTitle.mas_bottom).with.offset(5);
    }];
    UILabel *xiuliLevelTitle = [UILabel new];

    xiuliLevelTitle.font = Font(14);
    xiuliLevelTitle.text = @"修理等级";
    xiuliLevelTitle.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:xiuliLevelTitle];
    [xiuliLevelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xiuliTitle.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-(SCREEN_WIDTH()/2-40));
        make.height.mas_equalTo(LineH(14));
        make.top.equalTo(xiuliLine.mas_bottom).with.offset(10);
    }];
    self.xiuliLevelLabel = [UILabel new];
    self.xiuliLevelLabel.font = Font(14);
    self.xiuliLevelLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:self.xiuliLevelLabel];
    [self.xiuliLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xiuliLevelTitle.mas_right).with.offset(0);
        make.height.mas_equalTo(LineH(14));
        make.centerY.equalTo(xiuliLevelTitle.mas_centerY);
    }];
    UILabel *wuzhiTitle = [UILabel new];
    wuzhiTitle.font = Font(14);
    wuzhiTitle.text = @"修理材料";
    wuzhiTitle.textColor = UICOLOR_FROM_HEX(0xbbac94);
    [self addSubview:wuzhiTitle];
    [wuzhiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xiuliLevelTitle.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-(SCREEN_WIDTH()/2-40));
        make.height.mas_equalTo(LineH(14));
        make.top.equalTo(xiuliLevelTitle.mas_bottom).with.offset(10);
    }];
    self.wuzhiLabel = [UILabel new];
    self.wuzhiLabel.font = Font(14);
    self.wuzhiLabel.textColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:self.wuzhiLabel];
    [self.wuzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wuzhiTitle.mas_right).with.offset(0);
        make.height.mas_equalTo(LineH(14));
        make.centerY.equalTo(wuzhiTitle.mas_centerY);
    }];
    
    
    
    self.lineView = [UIView new];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
        //make.bottom.equalTo(self.wuzhiLabel.mas_bottom).with.offset(0);
        make.top.mas_equalTo(SCREEN_HEIGHT()-LineH(120));
    }];
}
-(void)setModel:(ItemModel *)model
{
    self.teshuArray = [NSMutableArray array];
    if(_model == nil){
        _model = model;
    }
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    self.nameLabel.text = self.model.name;
    self.partsLabel.text = self.model.parts;
    self.physicsLabel.text = self.model.physics;
    self.magicLabel.text = self.model.magic;
    self.gradeLabel.text = [NSString stringWithFormat:@"品级 %@",self.model.grade];
    self.professionLabel.text = self.model.profession;
    self.levelLabel.text = [NSString stringWithFormat:@"%@级以上",self.model.level];
    if([self.model.power integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"力量： +%@",self.model.power]];
    }
    if([self.model.endurance integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"耐力： +%@",self.model.endurance]];
    }
    if([self.model.crit integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"暴击： +%@",self.model.crit]];
    }
    if([self.model.belief integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"信念： +%@",self.model.belief]];
    }
    if([self.model.watch integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"直击： +%@",self.model.watch]];
    }
    if([self.model.spirit integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"精神： +%@",self.model.spirit]];
    }
    if([self.model.faith integerValue] != 0){
        self.counter += 1;
        [self.teshuArray addObject:[NSString stringWithFormat:@"信仰： +%@",self.model.faith]];
    }
    for(int i=1;i<=self.counter;i++){
        UILabel *label = [UILabel new];
        label.text = self.teshuArray[i-1];
        label.textColor = UICOLOR_FROM_HEX(0xdddddd);
        label.font = Font(14);
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH()/2 - 20);
            if(i == 1 || (i%3 == 0)){
                make.left.equalTo(self.mas_left).with.offset(10);
            }else{
                make.left.equalTo(self.mas_left).with.offset(SCREEN_WIDTH()/2);
            }
            
            if(i == 1 || i == 2){
                make.top.equalTo(self.teshuLine.mas_bottom).with.offset(5);
            }else if(i == 3 || i == 4){
                make.top.equalTo(self.teshuLine.mas_bottom).with.offset(LineH(30));
            }
            make.height.mas_equalTo(LineH(20));
        }];
    }
    
    if(self.counter > 2){
        [self.mojingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teshuLine.mas_bottom).with.offset(LineH(60));
        }];
    }else{
        [self.mojingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.teshuLine.mas_bottom).with.offset(LineH(30));
        }];
    }
    self.mojingcount = [self.model.dimensity intValue];
    for(int i=1;i<=self.mojingcount;i++){
        UIImageView *mojingIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mojing"]];
        [self.mojingView addSubview:mojingIcon];
        [mojingIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mojingView.mas_left).with.offset(LineX(i*25));
            make.centerY.equalTo(self.mojingView.mas_centerY).with.offset(10);
        }];
    }
    self.xiuliLevelLabel.text = self.model.repair_grade;
    self.wuzhiLabel.text = self.model.repair_material;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
