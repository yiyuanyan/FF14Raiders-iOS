//
//  OccupationTableViewCell.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
@interface OccupationTableViewCell : UITableViewCell
@property(nonatomic, strong) ContentModel *model;
@property(nonatomic, strong) NSArray *info;
@end
