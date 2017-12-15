//
//  AnnihilationCell.m
//  FF14Raiders
//
//  Created by Talk GoGo on 2017/12/15.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "AnnihilationCell.h"
@interface AnnihilationCell()
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *iconImage;
@end
@implementation AnnihilationCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initWithCellView];
    }
    return self;
}
-(void)initWithCellView {
    self.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    self.nameLabel = [UILabel new];
    self.nameLabel.font = Font(16);
    self.nameLabel.textColor = UICOLOR_FROM_HEX(0x77d1ff);
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    self.iconImage = [UIImageView new];
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.mas_equalTo(LineW(125));
        make.height.mas_equalTo(LineH(40));
    }];
    
}
-(void)setModel:(AnnihilationCellModel *)model
{
    _model = model;
    self.nameLabel.text = self.model.name;
    NSURL *url = [NSURL URLWithString:self.model.icon];
    [self.iconImage sd_setImageWithURL:url];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
