//
//  DiscountViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "DiscountViewController.h"
#import "DiscountCollectionViewCell.h"
#import "DetailDiscountViewController.h"



@interface DiscountViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *products;
@end

@implementation DiscountViewController

- (NSMutableArray *)products{
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"折扣促销";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    
    
    [self addCollectionView];
    self.view.backgroundColor = [UIColor purpleColor];
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Get_ProductList];//请求地址
    //配置请求参数
    NSDictionary *params = @{@"goodsStatusCode":@"3",
                             @"pageIndex":@"1",
                             @"pageSize":@"20"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            NSLog(@"^^^^^%@",self.info);
            for (NSDictionary *aPro in responseObject[@"data"][0][@"List"]) {
                Product *pro = [Product productWithDictionary:aPro];
                [self.products addObject:pro];
            }
            [self.collectionView reloadData];
            //油画漆1
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];
    [self.view addSubview:[ShoppingCartSingle sharedShoppingCart]];
}

-(void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[DiscountCollectionViewCell class] forCellWithReuseIdentifier:@"AllProCollectionViewCell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscountCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllProCollectionViewCell" forIndexPath:indexPath];
    
    //数据解析
    //     NSLog(@"%@",[self.products objectAtIndex:indexPath.row]);
    Product *product = [self.products objectAtIndex:2*indexPath.section+indexPath.row];
    
    NSMutableArray *arr = [NSMutableArray array];
    arr = [ShoppingCartSingle getShoppingArray];
    
    for (int i=0; i<arr.count; i++) {
        Product *one = arr[i];
        if ([one.goodsCode isEqualToString:product.goodsCode]) {
            product.clickNumber = one.clickNumber;
        }
    }
    cell.product = product;
    NSLog(@"产品%@",product);
    cell.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (2*(section+1)>self.products.count) {
        return 1;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return (self.products.count+1)/2;
}

#pragma mark - cell回调方法
- (void)addPackage:(DiscountCollectionViewCell *)cell
{
    NSLog(@"回调");
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.products objectAtIndex:2*path.section+path.row];
    NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] + [product.package integerValue]];
    product.clickNumber = str;
    [self.collectionView reloadData];
    [ShoppingCartSingle addProductArray:product];
}

- (void)subPackage:(DiscountCollectionViewCell *)cell
{
    NSLog(@"回调");
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.products objectAtIndex:2*path.section+path.row];
    NSInteger num = [product.clickNumber integerValue] - [product.package integerValue];
    if (num>=0) {
        NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] - [product.package integerValue]];
        product.clickNumber = str;
    }else{
        product.clickNumber = @"0";
    }
    [self.collectionView reloadData];
    [ShoppingCartSingle reduceProductArray:product];
}


//点击CELL
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailDiscountViewController *dpVC = [[DetailDiscountViewController alloc]init];
    Product *product = [self.products objectAtIndex:2*indexPath.section+indexPath.row];
    dpVC.product = product;
    [self.navigationController pushViewController:dpVC animated:NO];
    //进入商品详情
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((375 - 80) / 2, (375 - 80) / 2 + 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 10, 20);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
