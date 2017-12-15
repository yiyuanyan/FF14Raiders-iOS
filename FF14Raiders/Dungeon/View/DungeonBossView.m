//
//  DungeonBossView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "DungeonBossView.h"
#import "DungeonModel.h"
@interface DungeonBossView()
@property(nonatomic, strong) UILabel *titlNumLabel;
@end
@implementation DungeonBossView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){

    }
    return self;
}
-(void)initWithView:(int)viewCount models:(NSArray *)modelArray
{
    self.backView = [[UIView alloc] init];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        //make.height.mas_equalTo(100);
    }];
    UIView *lastView = nil;
    for(int i=0;i<viewCount;i++){
        DungeonBossModel *m = modelArray[i];
        //title
        UIView *titleView = [UIView new];
        titleView.backgroundColor = UICOLOR_FROM_HEX(0x313131);
        [self.backView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView == nil){
                make.top.equalTo(self.backView.mas_top).with.offset(0);
            }else{
                make.top.equalTo(lastView.mas_bottom).with.offset(0);
            }
            
            make.left.equalTo(self.backView.mas_left).with.offset(0);
            make.right.equalTo(self.backView.mas_right).with.offset(0);
            make.height.mas_equalTo(LineH(30));
        }];
        UIView *numView = [UIView new];
        numView.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
        [numView.layer setMasksToBounds:YES];
        [numView.layer setCornerRadius:LineH(24)/2];
        [titleView addSubview:numView];
        [numView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView.mas_centerY);
            make.left.equalTo(titleView.mas_left).with.offset(10);
            make.height.width.mas_equalTo(LineH(24));
        }];
        self.titlNumLabel = [UILabel new];
        self.titlNumLabel.text = [NSString stringWithFormat:@"%d",i+1];
        self.titlNumLabel.textColor = [UIColor whiteColor];
        self.titlNumLabel.font = Font(22);
        [numView addSubview:self.titlNumLabel];
        [self.titlNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(numView.mas_centerY);
            make.centerX.equalTo(numView.mas_centerX);
        }];
        UILabel *nameLabel = [UILabel new];
        nameLabel.textColor = UICOLOR_FROM_HEX(0xbbac94);
        nameLabel.text = m.name;
        nameLabel.font = Font(24);
        [titleView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numView.mas_right).with.offset(10);
            make.centerY.equalTo(titleView.mas_centerY);
        }];
        
        //图片
        NSURL *imgPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@public%@",APP_URL,m.image]];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:imgPath];
        [self.backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numView.mas_left).with.offset(0);
            make.top.equalTo(titleView.mas_bottom).with.offset(10);
            make.width.lessThanOrEqualTo(@150);
            make.height.lessThanOrEqualTo(@300);
        }];
        //contentLabel
        UILabel *conLabel = [UILabel new];
        if(!IsStrEmpty(m.content)){
            conLabel.numberOfLines = 0;
            conLabel.text = m.content;
            conLabel.textColor = UICOLOR_FROM_HEX(0xdddddd);
            conLabel.preferredMaxLayoutWidth = SCREEN_WIDTH() - 20;
            [conLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            conLabel.font = Font(14);
            [self.backView addSubview:conLabel];
            [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).with.offset(10);
                make.left.equalTo(titleView.mas_left).with.offset(10);
                make.right.equalTo(titleView.mas_right).with.offset(-10);
                
            }];
        }
        
        UIButton *itemsBtn = [[UIButton alloc] init];
        itemsBtn.tag = i;
        
        [itemsBtn addTarget:self action:@selector(itemsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [itemsBtn setTitleColor:UICOLOR_FROM_HEX(0xbbac94) forState:UIControlStateNormal];
        [itemsBtn setImage:[UIImage imageNamed:@"items_btn"] forState:UIControlStateNormal];
        [self.backView addSubview:itemsBtn];
        [itemsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backView.mas_centerX);
            make.width.mas_equalTo(LineW(160));
            make.height.mas_equalTo(LineH(30));
            if(!IsStrEmpty(m.content)){
                make.top.equalTo(conLabel.mas_bottom).with.offset(10);
            }else{
                make.top.equalTo(imageView.mas_bottom).with.offset(10);
            }
        }];
        
        UIView *lineView = [UIView new];
        [self.backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).with.offset(0);
            make.right.equalTo(self.backView.mas_right).with.offset(0);
            make.height.mas_equalTo(1);
            make.top.equalTo(itemsBtn.mas_bottom).with.offset(10);
        }];
        lastView = lineView;
    }
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(lastView.mas_bottom).with.offset(0);
    }];
    
    
}
-(void)setModelArray:(NSArray *)modelArray
{
    NSLog(@"%lu",(unsigned long)modelArray.count);
    if(_modelArray == nil){
        _modelArray = modelArray;
    }
    [self initWithView:(int)modelArray.count models:modelArray];
}
-(void)itemsBtnClick:(UIButton *)sender
{
    if(self.buttonAction){
        self.buttonAction(sender);
    }
    
}
@end
