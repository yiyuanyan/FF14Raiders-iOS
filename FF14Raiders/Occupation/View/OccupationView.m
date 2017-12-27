//
//  OccupationView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/22.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "OccupationView.h"
@interface OccupationView()
@property(nonatomic, strong) UIImageView *topImage;
@property(nonatomic, strong) UILabel *desLabel;
@property(nonatomic, strong) UILabel *introduceTitleLabel;
@property(nonatomic, strong) UILabel *introduceLabel;
@property(nonatomic, strong) UILabel *demandTitleLabel;
@property(nonatomic, strong) UILabel *demandLabel;
@end
@implementation OccupationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self builUI];
    }
    return self;
}
-(void)builUI
{
    self.topImage = [[UIImageView alloc] init];
    [self addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(200);
    }];
    self.desLabel = [UILabel new];
    self.desLabel.numberOfLines = 0;
    self.desLabel.font = Font(12);
    self.desLabel.textColor = [UIColor whiteColor];
    self.desLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.topImage.mas_left).with.offset(-5);
        make.top.equalTo(self.mas_top).with.offset(5);
    }];
    //基本
    self.introduceTitleLabel = [UILabel new];
    self.introduceTitleLabel.text = @"基本介绍";
    self.introduceTitleLabel.font = Font(24);
    self.introduceTitleLabel.textColor = UICOLOR_FROM_HEX(0xbda45b);
    [self.introduceTitleLabel sizeToFit];
    [self addSubview:self.introduceTitleLabel];
    [self.introduceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(5);
    }];
    self.introduceLabel = [UILabel new];
    self.introduceLabel.textColor = [UIColor whiteColor];
    self.introduceLabel.numberOfLines = 0;
    self.introduceLabel.font = Font(12);
    [self.introduceLabel sizeToFit];
    [self addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.introduceTitleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.top.equalTo(self.introduceTitleLabel.mas_bottom).with.offset(5);
    }];
    //要求
    self.demandTitleLabel = [UILabel new];
    self.demandTitleLabel.text = @"特职要求";
    self.demandTitleLabel.textColor = UICOLOR_FROM_HEX(0xbda45b);
    self.demandTitleLabel.font = Font(24);
    [self.demandTitleLabel sizeToFit];
    [self addSubview:self.demandTitleLabel];
    [self.demandTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.introduceTitleLabel.mas_left).with.offset(0);
        make.top.equalTo(self.introduceLabel.mas_bottom).with.offset(20);
    }];
    self.demandLabel = [UILabel new];
    self.demandLabel.textColor = [UIColor whiteColor];
    self.demandLabel.font = Font(12);
    self.demandLabel.numberOfLines = 0;
    [self.demandLabel sizeToFit];
    [self addSubview:self.demandLabel];
    [self.demandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.demandTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
    }];
    
    
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.demandLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
    }];
}
-(void)setModel:(ContentModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_URL,model.top_icon]];
    [self.topImage sd_setImageWithURL:url];
    [self.topImage sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.topImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }];
    self.desLabel.text = self.model.des;
    
    self.desLabel.attributedText = [self stringAttributed:self.model.des];
    [self.desLabel sizeToFit];
    self.introduceLabel.text = self.model.introduce;
    self.introduceLabel.attributedText = [self stringAttributed:self.model.introduce];
    
    self.demandLabel.attributedText = [self stringAttributed:self.model.demand];
}
-(NSAttributedString *)stringAttributed:(NSString *)str
{
    //设置UILabel的分段缩进
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    //设置缩进间隔
    style.firstLineHeadIndent = LineW(25);
    NSAttributedString *attrText = nil;
    if(!IsStrEmpty(str)){
        attrText = [[NSAttributedString alloc] initWithString:str attributes:@{ NSParagraphStyleAttributeName : style}];
    }
    return attrText;
}
@end
