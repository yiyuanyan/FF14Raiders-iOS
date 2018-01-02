//
//  ProductionHeaderView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionHeaderView.h"
@interface ProductionHeaderView()

@end
@implementation ProductionHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self builHeaderView];
    }
    return self;
}
-(void)builHeaderView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = UICOLOR_FROM_HEX(0x3a3a3a);
    [headerView.layer setMasksToBounds:YES];
    [headerView.layer setCornerRadius:6.0f];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.top.bottom.equalTo(self);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView.mas_left).with.offset(10);
    }];
    
}

@end
