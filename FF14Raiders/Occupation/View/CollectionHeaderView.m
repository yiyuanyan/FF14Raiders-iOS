//
//  CollectionHeaderView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "CollectionHeaderView.h"
@interface CollectionHeaderView()
@property(nonatomic, strong) UIImageView *iconImage;
@end
@implementation CollectionHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithHeaderView];
    }
    return self;
}
-(void)initWithHeaderView
{
    UIView *headerView = [UIView new];
    [headerView.layer setMasksToBounds:YES];
    [headerView.layer setCornerRadius:6.0f];
    headerView.backgroundColor = UICOLOR_FROM_HEX(0x3a3a3a);
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
    }];
    self.iconImage = [[UIImageView alloc] init];
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.height.mas_equalTo(30);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self.iconImage.mas_right).with.offset(10);
    }];
}
-(void)setIconPath:(NSString *)iconPath
{
    NSString *path = [NSString stringWithFormat:@"%@/%@",API_URL,iconPath];
    NSURL *url = [NSURL URLWithString:path];
    [self.iconImage sd_setImageWithURL:url];
}
@end
