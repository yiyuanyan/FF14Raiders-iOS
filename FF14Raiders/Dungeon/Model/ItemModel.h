//
//  ItemModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/30.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *grade;
@property(nonatomic, strong) NSString *level;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *parts;
@property(nonatomic, strong) NSString *physics;
@property(nonatomic, strong) NSString *magic;
@property(nonatomic, strong) NSString *profession;
@property(nonatomic, strong) NSString *power;
@property(nonatomic, strong) NSString *endurance;
@property(nonatomic, strong) NSString *crit;
@property(nonatomic, strong) NSString *belief;
@property(nonatomic, strong) NSString *watch;
@property(nonatomic, strong) NSString *spirit;
@property(nonatomic, strong) NSString *faith;
@property(nonatomic, strong) NSString *dimensity;
@property(nonatomic, strong) NSString *repair_grade;
@property(nonatomic, strong) NSString *repair_material;
@property(nonatomic, strong) NSString *origin;
@property(nonatomic, strong) NSString *origin_fuben;
@end
