//
//  OccupationCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "OccupationCell.h"
@interface OccupationCell()
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UILabel *titleLabel;
@end
@implementation OccupationCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self builUI];
    }
    return self;
}
-(void)builUI{
    self.backgroundColor = UICOLOR_FROM_HEX(0x2b2b2b);
    self.icon = [UIImageView new];
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(30));
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icon.mas_centerY);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
    }];
    
}
-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_URL,self.dic[@"oc_icon"]]];
    [self.icon sd_setImageWithURL:url];
    self.titleLabel.text = self.dic[@"name"];
}
@end
