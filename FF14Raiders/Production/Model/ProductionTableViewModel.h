//
//  ProductionTableViewModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/28.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionTableViewModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *occ_icon;
@property(nonatomic, strong) NSString *types;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *oc_icon;
@property(nonatomic, strong) NSString *top_icon;
@property(nonatomic, assign) int top_type;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *des;
@property(nonatomic, strong) NSString *introduce;
@property(nonatomic, strong) NSString *demand;
@property(nonatomic, strong) NSArray *skill;
@end
