//
//  HeaderView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/25.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
@property(nonatomic, strong) UIImageView *topImage;
@property(nonatomic, strong) UILabel *desLabel;
@property(nonatomic, strong) UILabel *introduceTitleLabel;
@property(nonatomic, strong) UILabel *introduceLabel;
@property(nonatomic, strong) UILabel *demandTitleLabel;
@property(nonatomic, strong) UILabel *demandLabel;
@end
@implementation HeaderView

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
        make.height.mas_equalTo(100);
    }];
    self.demandLabel = [UILabel new];
    self.demandLabel.font = Font(12);
    self.demandLabel.numberOfLines = 0;
    self.demandLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.demandLabel];
    [self.demandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(self.topImage.mas_centerY);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.topImage.mas_left).with.offset(-5);
    }];
    
    
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];

}
-(void)setModel:(ContentModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_URL,model.top_icon]];
    [self.topImage sd_setImageWithURL:url];
    [self.topImage sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.topImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(image.size.width);
            //make.height.mas_equalTo(image.size.height);
        }];
    }];
    
    self.demandLabel.attributedText = [self stringAttributed:self.model.demand];
    [self.demandLabel layoutIfNeeded];
//    NSLog(@"%f",self.demandLabel.frame.size.height);
//    if(self.demandLabel.frame.size.height > 100){
//        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.demandLabel.mas_bottom).with.offset(10);
//        }];
//    }
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.demandLabel.frame.size.height > 100){
            make.top.equalTo(self.topImage.mas_bottom).with.offset(30);
        }else{
            make.top.equalTo(self.topImage.mas_bottom).with.offset(10);
        }
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
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
