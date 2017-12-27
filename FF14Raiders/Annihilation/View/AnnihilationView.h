//
//  AnnihilationView.h
//  FF14Raiders
//
//  Created by 何建新 on 2017/12/18.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnihilationModel.h"
@interface AnnihilationView : UIScrollView
@property(nonatomic, strong) AnnihilationModel *model;
@property(nonatomic, strong) UIView *lineV;
@property(nonatomic, strong) UIButton *videoButton;
@property(nonatomic, strong) RACSubject *delegateSignal;;
@end
