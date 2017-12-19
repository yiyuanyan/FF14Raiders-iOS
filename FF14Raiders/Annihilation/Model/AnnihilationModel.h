//
//  AnnihilationModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/18.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnihilationModel : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *level;
@property(nonatomic, strong) NSString *personnel;
@property(nonatomic, strong) NSString *boss_name;
@property(nonatomic, strong) NSString *illustrate;
@property(nonatomic, strong) NSString *video_path;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *place;
@property(nonatomic, strong) NSString *time_limit;
@property(nonatomic, strong) NSArray *structure;
@property(nonatomic, strong) NSArray *prize_types;
@property(nonatomic, strong) NSString *rank;
@property(nonatomic, assign) int putin;
@property(nonatomic, assign) int number_restriction;
@end
