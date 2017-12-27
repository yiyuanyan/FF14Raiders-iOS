//
//  CollectionCellModel.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionCellModel : NSObject
@property(nonatomic, assign) int id;
@property(nonatomic, assign) int cid;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *oc_icon;
@end
