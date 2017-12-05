//
//  ItemView.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
@interface ItemView : UIView
@property(nonatomic, strong) ItemModel *model;
@property(nonatomic, strong) UIView *lineView;
@end
