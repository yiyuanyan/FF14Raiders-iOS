//
//  OccupationModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OccupationModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *occ_icon;
@property(nonatomic, strong) NSString *types;
@property(nonatomic, strong) NSArray *res;
@end
