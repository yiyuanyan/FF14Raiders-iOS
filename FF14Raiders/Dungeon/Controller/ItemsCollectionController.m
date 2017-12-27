//
//  ItemsCollectionController.m
//  FF14Raiders
//
//  Created by 何建新 on 2017/11/30.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "ItemsCollectionController.h"
#import "ItemsCollectionCell.h"
#import "ItemModel.h"
#import "ItemViewController.h"
@interface ItemsCollectionController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic, strong) NSArray *itemsModels;
@end

@implementation ItemsCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    if(!IsStrEmpty(self.name)){
        [self getJSON];
    }
    [self initCollectionView];
    [MBProgressHUD showLoading:self.view];
}
-(void)getJSON
{
    NSString *url = [NSString stringWithFormat:@"%@api/getbossitems/%@",APP_URL,self.name];
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] integerValue] == 1){
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                ItemModel *model = [ItemModel yy_modelWithJSON:dic];
                [mArray addObject:model];
            }
            self.itemsModels = mArray;
            
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络不给力..." toView:self.view];
    }];
}
-(void)initNav{
    self.title = [NSString stringWithFormat:@"%@掉落物品",self.name];
    //设置导航栏字体和字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:UICOLOR_FROM_HEX(0xbbac94)}];
    //设置导航栏背景颜色
    self.navigationController.navigationBar.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goToBack)];
}
-(void)goToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initCollectionView{
    //创建布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT()) collectionViewLayout:flowLayout];
    //背景颜色
    self.collectionView.backgroundColor = UICOLOR_FROM_HEX(0x1c1c1c);
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //允许滚动
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    //注册自定义cell。或UICollectionViewCell原生CELL
    [self.collectionView registerClass:[ItemsCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
//分为几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每组几个CELL
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsModels.count;
}
//设置CELL
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ItemModel *model = self.itemsModels[indexPath.row];
    cell.model = model;
    // Configure the cell
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6.0f;
    return cell;
}
#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,5,10,5);//（上、左、下、右）
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
//使用UICollectionViewDelegateFlowLayout作为代理，设置每一个CELL的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH()/2 - 10, LineH(40));
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemModel *model = self.itemsModels[indexPath.row];
    ItemViewController *vc = [ItemViewController new];
    vc.id = model.id;
    vc.name = [NSString stringWithFormat:@"%@",model.name];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
