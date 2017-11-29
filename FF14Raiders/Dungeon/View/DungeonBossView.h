//
//  DungeonBossView.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DungeonBossModel.h"
typedef void (^itemsButtonClick)(UIButton *sender);
@interface DungeonBossView : UIView
@property(nonatomic, copy) itemsButtonClick buttonAction;
@property(nonatomic, strong) NSArray *modelArray;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) DungeonBossModel *model;
@property(nonatomic, strong) UICollectionView *itemsView;
@end
