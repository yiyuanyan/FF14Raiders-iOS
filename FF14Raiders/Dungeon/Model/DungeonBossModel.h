//
//  DungeonBossModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/22.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DungeonBossModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *affiliation;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSArray *drop_items;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSArray *items;
@end
