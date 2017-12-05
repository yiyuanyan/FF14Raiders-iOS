//
//  ItemsCollectionCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/30.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ItemsCollectionCell.h"
@interface ItemsCollectionCell()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *infoLabel;
@property(nonatomic, strong) UILabel *subLabel;
@end
@implementation ItemsCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithCell];
    }
    return self;
}
-(void)initWithCell
{
    self.backgroundColor = UICOLOR_FROM_HEX(0x333333);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item"]];
    self.imageView = imageView;
    [self addSubview:self.imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(4);
        make.height.mas_equalTo(LineH(32));
        make.width.mas_equalTo(LineW(32));
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"鬼船御敌腰带";
    titleLabel.textColor = UICOLOR_FROM_HEX(0xc0ffc0);
    titleLabel.font = Font(12);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).with.offset(5);
        make.top.equalTo(self.imageView.mas_top).with.offset(0);
        make.height.mas_equalTo(LineH(12));
    }];
    UILabel *infoLabel = [UILabel new];
    infoLabel.textColor = UICOLOR_FROM_HEX(0xefefef);
    infoLabel.text = @"剑术师 斧术师 骑士 战士 暗黑骑士";
    infoLabel.font = Font(7);
    [self addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(3);
        make.right.equalTo(self.mas_right).with.offset(LineX(3));
        make.height.mas_equalTo(LineH(7));
    }];
    self.infoLabel = infoLabel;
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.textColor = UICOLOR_FROM_HEX(0xefefef);
    subLabel.text = @"Lv61 腰部防具（品级 260）";
    subLabel.font = Font(8);
    [self addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.bottom.equalTo(self.imageView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(LineH(8));
    }];
    self.subLabel = subLabel;
}
-(void)setModel:(ItemModel *)model
{
    if(_model == nil){
        _model = model;
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    self.infoLabel.text = self.model.profession;
    self.titleLabel.text = self.model.name;
    self.subLabel.text = [NSString stringWithFormat:@"Lv61 %@(品级 %@)",self.model.parts,self.model.grade];
}
@end
