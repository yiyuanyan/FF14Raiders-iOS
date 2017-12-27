//
//  OccupationController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/14.
//  Copyright © 2017年 何建新. All rights reserved.
//  职业

#import "OccupationController.h"
#import "OccupationModel.h"
#import "OccupationCell.h"
#import "CollectionHeaderView.h"
#import "OccupationContentController.h"
@interface OccupationController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSArray *modelArray;
@property(nonatomic, strong) UIImageView *topImageView;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation OccupationController
static NSString *const identifierCollectionHeader = @"CollectionHeaderView";
static NSString *const identifierCollectionFooter = @"CollectionFooterView";
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0x0e1821);
    [MBProgressHUD showLoading:self.view title:@"正在获取网络..."];
    [self setTopImage];
    [self getJSON];
    [self initWithCollectionView];
}
-(void)initWithCollectionView
{
    //创建布局
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //滚动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setFooterReferenceSize:CGSizeMake(SCREEN_WIDTH(), 0.01)];
    [flowLayout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH(), LineH(40))];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UICOLOR_FROM_HEX(0x0e1821);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //允许滚动
    self.collectionView.scrollEnabled = YES;
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).with.offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(bgView);
    }];
    //注册自定义cell
    [self.collectionView registerClass:[OccupationCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter];
    
    
}
-(void)getJSON{
    NSString *url = [NSString stringWithFormat:@"%@api/get_occupation_all",APP_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] intValue] == 1){
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                OccupationModel *model = [OccupationModel yy_modelWithJSON:dic];
                [mArray addObject:model];
            }
            self.modelArray = mArray;
            NSString *path = [NSString stringWithFormat:@"%@public/uploads/%@",APP_URL,responseObject[@"category"][@"image"]];
            
            NSURL *topimageURL = [NSURL URLWithString:path];
            [self.topImageView sd_setImageWithURL:topimageURL];
            [self.topImageView layoutIfNeeded];
            [self.collectionView reloadData];
            [MBProgressHUD hideHUDForView:self.view];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"获取信息失败...." toView:self.view];
    }];
}
-(void)setTopImage{
    self.topImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(LineH(138));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 添加一个补充视图(页眉或页脚)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    OccupationModel *model = self.modelArray[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader forIndexPath:indexPath];
        header.iconPath = model.occ_icon;
        header.titleLabel.text = model.title;
        reusableView = header;
    }
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        CollectionHeaderView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter forIndexPath:indexPath];
        //footerview.backgroundColor = [UIColor purpleColor];
        reusableView = footerview;
    }
    return reusableView;
}
#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.modelArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    OccupationModel *model = self.modelArray[section];
    
    return model.res.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OccupationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //cell.resArray = self.modelArray[indexPath.section][@"res"][indexPath.row];
    OccupationModel *m = self.modelArray[indexPath.section];
    cell.dic = m.res[indexPath.row];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:6.0f];
    return cell;
        
    
}
#pragma mark 定义整个CollectionViewCell与整个View的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}
#pragma mark 设置没有cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH()/2 - 10, LineH(40));
}
#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark header的宽和高
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH(), 40);
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH(), 0.01);
//}
#pragma mark 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OccupationModel *model = self.modelArray[indexPath.section];
    OccupationContentController *vc = [OccupationContentController new];
    vc.name = model.res[indexPath.row][@"name"];
    vc.id = [model.res[indexPath.row][@"id"] intValue];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
