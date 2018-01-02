//
//  ProductionCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionCell.h"
@interface ProductionCell()
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) UILabel *titleLabel;
@end
@implementation ProductionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self builCell];
    }
    return self;
}
-(void)builCell{
    self.backgroundColor = UICOLOR_FROM_HEX(0x2b2b2b);
    self.iconImage = [UIImageView new];
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(30));
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImage.mas_centerY);
        make.left.equalTo(self.iconImage.mas_right).with.offset(10);
    }];
}
-(void)setModel:(CollectionCellModel *)model
{
    _model = model;
    NSString *path = [NSString stringWithFormat:@"%@%@",APP_URL,self.model.oc_icon];
    NSURL *url = [NSURL URLWithString:path];
    [self.iconImage sd_setImageWithURL:url];
    self.titleLabel.text = self.model.name;
}
@end
