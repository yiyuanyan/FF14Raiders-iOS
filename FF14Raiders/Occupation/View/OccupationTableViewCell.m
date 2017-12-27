//
//  OccupationTableViewCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "OccupationTableViewCell.h"
@interface OccupationTableViewCell()
@property(nonatomic, strong) UIImageView *ocIcon;
@property(nonatomic, strong) UILabel *jinengLabel;
@property(nonatomic, strong) UIImageView *xideImage;
@property(nonatomic, strong) UILabel *xideLabel;
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UILabel *juliLabel;
@property(nonatomic, strong) UILabel *fanweiLabel;
@property(nonatomic, strong) UILabel *xiaohaoLabel;

@end
@implementation OccupationTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = UICOLOR_FROM_HEX(0x343434);
        [self builUI];
    }
    return self;
}
-(void)builUI
{
    self.ocIcon = [UIImageView new];
    self.ocIcon.layer.masksToBounds = YES;
    self.ocIcon.layer.cornerRadius = 6.0f;
    [self.contentView addSubview:self.ocIcon];
    [self.ocIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
    }];
    self.jinengLabel = [UILabel new];
    self.jinengLabel.font = Font(12);
    self.jinengLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.jinengLabel];
    [self.jinengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(70));
        make.left.equalTo(self.ocIcon.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.xideImage = [UIImageView new];
    [self.contentView addSubview:self.xideImage];
    [self.xideImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineW(20));
        make.left.equalTo(self.jinengLabel.mas_right).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.xideLabel = [UILabel new];
    self.xideLabel.font = Font(12);
    self.xideLabel.text = @"99级";
    self.xideLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.xideLabel];
    [self.xideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(30));
        make.left.equalTo(self.xideImage.mas_right).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.typeLabel = [self builLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(25));
        make.left.equalTo(self.xideLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.juliLabel = [self builLabel];
    [self.contentView addSubview:self.juliLabel];
    [self.juliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(25));
        make.left.equalTo(self.typeLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.fanweiLabel = [self builLabel];
    [self.contentView addSubview:self.fanweiLabel];
    [self.fanweiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(25));
        make.left.equalTo(self.juliLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.xiaohaoLabel = [self builLabel];
    [self.contentView addSubview:self.xiaohaoLabel];
    [self.xiaohaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(45));
        make.left.equalTo(self.fanweiLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
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
-(UILabel *)builLabel
{
    UILabel *label = [UILabel new];
    label.font = Font(12);
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = UICOLOR_RANDOM_COLOR();
    label.textColor = [UIColor whiteColor];
    return label;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setInfo:(NSArray *)info
{
    _info = info;
    [self.ocIcon sd_setImageWithURL:self.info[0]];
    self.jinengLabel.text = self.info[1];
    [self.xideImage sd_setImageWithURL:self.info[2]];
    self.xideLabel.text = self.info[3];
    self.typeLabel.text = self.info[4];
    self.juliLabel.text = self.info[5];
    self.fanweiLabel.text = self.info[6];
    self.xiaohaoLabel.text = self.info[7];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
