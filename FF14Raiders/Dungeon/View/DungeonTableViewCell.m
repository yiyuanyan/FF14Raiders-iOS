//
//  DungeonTableViewCell.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/15.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "DungeonTableViewCell.h"
@interface DungeonTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconView;
@end
@implementation DungeonTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initWithCell];
    }
    return self;
}
-(void)initWithCell
{
    self.backgroundColor = UICOLOR_FROM_HEX(0x313131);
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"漂流海域妖歌海";
    self.titleLabel.textColor = UICOLOR_FROM_HEX(0x77d1ff);
    self.titleLabel.font = Font(16);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    self.iconView = imageView;
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(LineH(40));
        make.width.mas_equalTo(LineW(125));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UICOLOR_FROM_HEX(0x666666);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}
-(void)setModel:(DungeonModel *)model
{
    self.titleLabel.text = model.name;
    NSURL *url = [NSURL URLWithString:model.image];
    [self.iconView sd_setImageWithURL:url];
    
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
