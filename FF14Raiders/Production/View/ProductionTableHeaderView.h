//
//  ProductionTableHeaderView.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/28.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionTableViewModel.h"
@interface ProductionTableHeaderView : UIView
@property(nonatomic, strong) ProductionTableViewModel *model;
@property(nonatomic, strong) UIView *lineView;
@end
