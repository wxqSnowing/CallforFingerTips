//
//  CatogoryDetailViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import "CatogoryDetailViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "Product.h"
#import "ClassifyCollectionViewCell.h"
#import "ProductCatogory.h"
#import "ProductCatogoryChild.h"
#import "DetailProductViewController.h"

#define Get_ListByCategory @"/Goods/GetListByCategory"

@interface CatogoryDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray *titleNames;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *products;
@property(nonatomic,strong)UIScrollView *scv;

@end

@implementation CatogoryDetailViewController

- (NSMutableArray *)products{
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}

- (NSMutableArray *)titleNames{
    if (!_titleNames) {
        _titleNames = [NSMutableArray array];
    }
    return _titleNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*---------------------初始化title------------------------------------------*/
    [self.titleNames addObject:self.pc.title];
    NSMutableArray *arr = [NSMutableArray array];
    arr = self.pc.children;
    for (int i = 0; i<arr.count; i++) {
        ProductCatogoryChild *pcC = [[ProductCatogoryChild alloc]init];
        pcC = arr[i];
        [self.titleNames addObject:pcC.title];
    }
    /*-----------------------------------------------------------------------*/

    

    
    [self addCollectionView];
    [self addALLButton];
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Get_ListByCategory];//请求地址
    NSLog(@"地址：%@",urlString);
    
    NSLog(@"%@",self.pc.title);
    NSLog(@"%@",self.pc.children);
    //配置请求参数
    NSDictionary *params = @{@"categoryTitle":self.pc.title,
                             @"pageIndex":@"1",
                             @"pageSize":@"20"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            NSLog(@"详细列表的信息%@",self.info);
            NSLog(@"种类%@",self.pc.title);
            
            for (NSDictionary *aPro in responseObject[@"data"][0][@"List"]) {
                NSMutableDictionary *newPro = [aPro mutableCopy];
                [newPro setObject:@"0" forKey:@"ClickNumber"];
                Product *pro = [Product productWithDictionary:newPro];
                [self.products addObject:pro];
            }
    
            [self.collectionView reloadData];
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];
    [self.view addSubview:[ShoppingCartSingle sharedShoppingCart]];
}

-(void)addALLButton{
    self.scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 375, 60)];
    _scv.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<self.titleNames.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 90, 40)];
        btn.layer.cornerRadius = 10;
        if (i == 0) {
            [btn setTitle:@"全部" forState:UIControlStateNormal];
            btn.backgroundColor = [[UIColor alloc]initWithRed:155/255.0 green:202/255.0 blue:252/255.0 alpha:1];
        }else{
            [btn setTitle:self.titleNames[i] forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scv addSubview:btn];
    }
    _scv.contentSize = CGSizeMake(10+self.titleNames.count*70, 200);
    _scv.delegate = self;
    _scv.pagingEnabled = YES;
    _scv.showsHorizontalScrollIndicator = NO;
    _scv.showsVerticalScrollIndicator = NO;
    _scv.bounces = YES;
    _scv.scrollEnabled = YES;
    [self.view addSubview:_scv];
}

-(void)click:(UIButton *)btn{
    
    [self.products removeAllObjects];
    
    for (int i = 0; i<self.titleNames.count; i++) {
        if (btn.tag==i+10) {
            if (btn.tag>2+10) {
                //设置偏移量
                [self.scv setContentOffset:CGPointMake(120, 0) animated:YES];
            }
            
            btn.backgroundColor = [[UIColor alloc]initWithRed:155/255.0 green:202/255.0 blue:252/255.0 alpha:1];
            
            NSString *urlString = [BaseUrl stringByAppendingString:Get_ListByCategory];//请求地址
            //配置请求参数
            NSDictionary *params = @{@"categoryTitle":self.titleNames[i],
                                     @"pageIndex":@"1",
                                     @"pageSize":@"20"};
            //block发送请求
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                    self.info = responseObject[@"data"];
                    NSLog(@"详细列表的信息%@",self.info);
                    NSLog(@"种类%@",self.pc.title);
                    for (NSDictionary *aPro in responseObject[@"data"][0][@"List"]) {
                        NSMutableDictionary *newPro = [aPro mutableCopy];
                        [newPro setObject:@"0" forKey:@"ClickNumber"];
                        Product *pro = [Product productWithDictionary:newPro];
                        [self.products addObject:pro];
                    }
                    [self.collectionView reloadData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"err = %@",error);
            }];
        }else{
            //
            UIButton *btn = [self.view viewWithTag:i+10];
            btn.backgroundColor = [UIColor clearColor];
        
        }
    }
}

-(void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25+5+5, 375, 667-25) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[ClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"AllProCollectionViewCell"];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)addPackage:(ClassifyCollectionViewCell *)cell{
    NSLog(@"回调");
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.products objectAtIndex:2*path.section+path.row];
    NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] + [product.package integerValue]];
    product.clickNumber = str;
    [self.collectionView reloadData];
    [ShoppingCartSingle addProductArray:product];
}

- (void)subPackage:(ClassifyCollectionViewCell *)cell{
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllProCollectionViewCell" forIndexPath:indexPath];
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
    cell.delegate = self;
    NSLog(@"产品%@",product);
    cell.subBtn.tag = 100 + 2*indexPath.section+indexPath.row;
    cell.addBtn.tag = 1000 + 2*indexPath.section+indexPath.row;
    
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

//点击CELL
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailProductViewController *dpVC = [[DetailProductViewController alloc]init];
    Product *product = [self.products objectAtIndex:2*indexPath.section+indexPath.row];
    dpVC.product = product;
    [self.navigationController pushViewController:dpVC animated:NO];
    //进入商品详情
    NSLog(@"详细");
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((375 - 80) / 2, (375 - 80) / 2 + 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 10, 20);
}

-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
