//
//  ProductionHeaderView.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ProductionHeaderView.h"

@implementation ProductionHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = UICOLOR_RANDOM_COLOR();
    }
    return self;
}
@end
