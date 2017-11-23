//
//  DungeonContentModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DungeonContentModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *descr;
@property(nonatomic, strong) NSString *video_url;
@property(nonatomic, assign) int version_type;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *start_level;
@property(nonatomic, strong) NSString *place;
@property(nonatomic, strong) NSString *time_limit;
@property(nonatomic, assign) int *user_number;
@property(nonatomic, strong) NSString *protect;
@property(nonatomic, strong) NSString *auxiliary;
@property(nonatomic, strong) NSString *attack;
@property(nonatomic, strong) NSString *boss_num;
@property(nonatomic, strong) NSArray *reward;
@property(nonatomic, strong) NSString *grade;
@property(nonatomic, assign) int add_user;
@property(nonatomic, assign) int number_restriction;
@property(nonatomic, strong) NSArray *boss;
@end
