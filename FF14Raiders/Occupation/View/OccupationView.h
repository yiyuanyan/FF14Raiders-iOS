//
//  OccupationView.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/22.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
@interface OccupationView : UIView
@property(nonatomic, strong) ContentModel *model;
@property(nonatomic, strong) UIView *bottomView;
@end
