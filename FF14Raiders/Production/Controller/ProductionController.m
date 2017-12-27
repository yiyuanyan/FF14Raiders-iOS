//
//  ProductionController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/14.
//  Copyright © 2017年 何建新. All rights reserved.
//  采集

#import "ProductionController.h"
#import "CollectionCellModel.h"
#import "ProductionHeaderView.h"
#import "ProductionCell.h"
@interface ProductionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSArray *modelArray;
@property(nonatomic, strong) UIImageView *topImage;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ProductionController
static NSString *const identifierCollectionHeader = @"CollectionHeaderView";
static NSString *const identifierCollectionFooter = @"CollectionFooterView";
static NSString * const reuseIdentifier = @"myCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x0e1821);
    [self builTopImage];
    [self builCollectionView];
    [self getJSON];
}
-(void)builCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setFooterReferenceSize:CGSizeMake(SCREEN_WIDTH(), 0.01)];
    [flowLayout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH(), LineH(40))];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UICOLOR_FROM_HEX(0x0e1821);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).with.offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
    [bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(bgView);
    }];
    [self.collectionView registerClass:[ProductionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[ProductionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader];
    [self.collectionView registerClass:[ProductionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter];
}
-(void)builTopImage
{
    self.topImage = [UIImageView new];
    [self.view addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(LineH(138));
    }];
}
-(void)getJSON
{
    [MBProgressHUD showLoading:self.view];
    NSString *url = [NSString stringWithFormat:@"%@api/get_production_all",APP_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] intValue] == 1){
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_URL,responseObject[@"category"]]];
            [self.topImage sd_setImageWithURL:url];
            [self.topImage layoutIfNeeded];
            NSMutableArray *mArr = [NSMutableArray array];
            NSMutableArray *mArray = [NSMutableArray array];
            NSMutableArray *mArray2 = [NSMutableArray array];
            for (NSDictionary *dic1 in responseObject[@"data"][@"zhizuo"]) {
                CollectionCellModel *model = [CollectionCellModel yy_modelWithJSON:dic1];
                [mArray addObject:model];
            }
            for (NSDictionary *dic2 in responseObject[@"data"][@"caiji"]) {
                CollectionCellModel *model = [CollectionCellModel yy_modelWithJSON:dic2];
                [mArray2 addObject:model];
            }
            [mArr addObject:mArray];
            [mArr addObject:mArray2];
            self.modelArray = mArr;
            [self.collectionView reloadData];

        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }

        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力...." toView:self.view];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if(kind == UICollectionElementKindSectionHeader){
        ProductionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader forIndexPath:indexPath];
        
        reusableView = header;
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        ProductionHeaderView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter forIndexPath:indexPath];
        //footerview.backgroundColor = [UIColor purpleColor];
        reusableView = footerview;
    }
    return reusableView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [self.modelArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UICollectionViewCell alloc] init];
    }
    return cell;
}
@end
