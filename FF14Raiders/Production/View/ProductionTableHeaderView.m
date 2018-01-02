//
//  ProductionTableHeaderView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/28.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionTableHeaderView.h"
@interface ProductionTableHeaderView()
@property(nonatomic, strong) UIImageView *topImage;
@property(nonatomic, strong) UILabel *introduceLabel;
@end
@implementation ProductionTableHeaderView
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
    self.topImage = [UIImageView new];
    [self addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(LineW(70));
    }];
    self.introduceLabel = [UILabel new];
    self.introduceLabel.textColor = [UIColor whiteColor];
    self.introduceLabel.font = Font(10);
    self.introduceLabel.numberOfLines = 0;
    [self addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.topImage.mas_left).with.offset(-5);
    }];
    
}
-(void)setModel:(ProductionTableViewModel *)model
{
    _model = model;
    NSString *path = [NSString stringWithFormat:@"%@%@",APP_URL,self.model.top_icon];

    NSURL *url = [NSURL URLWithString:path];
    
    [self.topImage sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.topImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(image.size.width);
        }];
    }];
    [self.topImage layoutIfNeeded];
    self.introduceLabel.attributedText = [self stringAttributed:self.model.introduce];
    
    [self.introduceLabel layoutIfNeeded];
    self.lineView = [UIView new];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.introduceLabel.frame.size.height > 200){
            make.top.equalTo(self.introduceLabel.mas_bottom).with.offset(0);
        }else{
            make.top.equalTo(self.topImage.mas_bottom).with.offset(0);
        }
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
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
