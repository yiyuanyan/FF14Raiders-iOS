//
//  ProductionTableViewCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/28.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionTableViewCell.h"
@interface ProductionTableViewCell()
@property(nonatomic, strong)UIImageView *iconImage;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *jinengImage;
@property(nonatomic, strong) UILabel *jinengLabel;
@property(nonatomic, strong) UILabel *typesLabel;
@property(nonatomic, strong) UILabel *xiaohaoLabel;
@end
@implementation ProductionTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self builCell];
    }
    return self;
}
-(void)builCell
{
    self.backgroundColor = UICOLOR_FROM_HEX(0x2b2b2b);
    self.iconImage = [UIImageView new];
    [self.iconImage.layer setMasksToBounds:YES];
    [self.iconImage.layer setCornerRadius:6.0f];
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(LineH(30));
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
    }];
    self.nameLabel = [UILabel new];
    self.nameLabel.font = Font(12);
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineH(90));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconImage.mas_right).with.offset(10);
    }];
    self.jinengImage = [UIImageView new];
    [self.contentView addSubview:self.jinengImage];
    [self.jinengImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(15));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).with.offset(5);
    }];
    self.jinengLabel = [UILabel new];
    self.jinengLabel.font = Font(12);
    self.jinengLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.jinengLabel];
    [self.jinengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.jinengImage.mas_right).with.offset(2);
    }];
    self.typesLabel = [UILabel new];
    self.typesLabel.font = Font(12);
    self.typesLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.typesLabel];
    [self.typesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(55));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.jinengLabel.mas_right).with.offset(10);
    }];
    self.xiaohaoLabel = [UILabel new];
    self.xiaohaoLabel.font = Font(12);
    self.xiaohaoLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.xiaohaoLabel];
    [self.xiaohaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(60));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.typesLabel.mas_right).with.offset(5);
    }];
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UICOLOR_FROM_HEX(0x3c3c3c);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
    }];
}
-(void)setInfo:(NSArray *)info
{
    _info = info;

    NSString *path = [NSString stringWithFormat:@"%@",self.info[0]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:path]];
    self.nameLabel.text = self.info[1];
    [self.jinengImage sd_setImageWithURL:[NSURL URLWithString:self.info[2]]];
    self.jinengLabel.text = self.info[3];
    self.typesLabel.text = self.info[4];
    self.xiaohaoLabel.text = [NSString stringWithFormat:@"消耗:%@",self.info[6]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
