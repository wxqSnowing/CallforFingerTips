//
//  RootViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "RootViewController.h"

#import "SearchViewController.h"
#import "MineViewController.h"
#import "AllPeoductsViewController.h"
#import "MonthNewViewController.h"
#import "ClassifyViewController.h"
#import "DiscountViewController.h"
#import "SliderPic.h"
#import "Notice.h"

#import "RecommendCollectionViewCell.h"
#import "DetailProductViewController.h"
#import "MLInfiniteScrollView.h"
#import "MLInfiniteScrollViewCell.h"
#import "ShoppingCartViewController.h"
#import "CDPImageCollectionView.h"

#import "NewAnnounceViewController.h"

@interface RootViewController ()<CDPImageCollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MLInfiniteScrollViewDataSource, MLInfiniteScrollViewDelegate>
{
    UIPageControl *_pageControl;//分页控制器
}
@property(strong,nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) MLInfiniteScrollView *infinScrollView;
@property (nonatomic, strong) NSMutableArray *sliderPics;
@property(nonatomic,strong)NSArray *announceInfo;
@end

@implementation RootViewController

//
/*初始化products*/
- (NSMutableArray *)products{
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}

-(NSMutableArray *)sliderPics{
    if (!_sliderPics) {
        _sliderPics = [NSMutableArray array];
    }
    return _sliderPics;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /*TabBarItem*/
    {
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 42, 62)];
        [leftBtn setImage:[UIImage imageNamed:@"搜索@2x.png"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(searchPushBarButtonHandle) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = searchBarButtonItem;
        
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 42, 62)];
        [rightBtn setImage:[UIImage imageNamed:@"我的@2x.png"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(minePushBarButtonHandle) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mineBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = mineBarButtonItem;
        
        self.navigationItem.title = @"万达百货";//标题
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:20],
           NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
   
    }
    
    
    [self addCollectionView];/*调用Collection方法生产数据*/
    /*获取滑动视图数据*/
    {
            //生成请求类
            NSString *urlSliderString = [BaseUrl stringByAppendingString:Get_SliderList];//请求地址
            NSLog(@"获取滑动视图数据%@",urlSliderString);
            //block发送请求
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
            [manager POST:urlSliderString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                    self.info = responseObject[@"data"];
                    for (NSDictionary *aSliderPic in responseObject[@"data"]) {
                        SliderPic *sliderPic = [SliderPic sliderWithDictionary:aSliderPic];
                        [self.sliderPics addObject:sliderPic];
                    }
                    [self addRootView];/*加载视图*/
                    [self.infinScrollView reloadData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"err = %@",error);
            }];
        }
    
    /*获取推荐商品的数据*/
    {
        //生成请求类
        NSString *urlString = [BaseUrl stringByAppendingString:Get_ProductList];//请求地址
        NSLog(@"推荐地址%@",urlString);
        //配置请求参数
        NSDictionary *params = @{@"goodsStatusCode":@"1",
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
          
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"err = %@",error);
        }];
    }
    
    
}

/*加载视图*/
-(void)addRootView{
    UIScrollView *mySCV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, UISCREE_WIDTH, 667-64)];/*最大外层滑动*/
    mySCV.delegate = self;
    mySCV.scrollEnabled = YES;
    mySCV.contentSize = CGSizeMake(375, 667*1.5);
    
    /*横向的滑动视图*/
    self.infinScrollView = [MLInfiniteScrollView infiniteScrollViewWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170) delegate:self dataSource:self timeInterval:1.0 inView: self.view];
    [mySCV addSubview:self.infinScrollView ];
    
    //分页控制器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(330, 130, 20, 20)];
    _pageControl.numberOfPages=self.sliderPics.count;
    _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [mySCV addSubview:_pageControl];
    
    //最新公告
    UIButton *anBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,self.infinScrollView.frame.origin.y+self.infinScrollView.frame.size.height+5, 90*0.7, 30*0.7)];
    [anBtn setBackgroundImage:[UIImage imageNamed:@"最新公告：@2x.png"] forState:UIControlStateNormal];
    [mySCV addSubview:anBtn];
    
    
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:TZ_GetList];//请求地址
    NSLog(@"地址：%@",urlString);
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.announceInfo = responseObject[@"data"];
            NSLog(@"%@",self.announceInfo);
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *one in self.announceInfo) {
                [arr addObject:one[@"Title"]];
            }
            NSArray *imageArr= [[NSArray alloc]initWithArray:arr];
            CDPImageCollectionView *imageCollectionView=[[CDPImageCollectionView alloc] initWithFrame:CGRectMake(90,self.infinScrollView.frame.origin.y+self.infinScrollView.frame.size.height+3, 375, 30) andImageUrlArr:imageArr scrollDirection:UICollectionViewScrollDirectionVertical];
            imageCollectionView.delegate=self;
            [imageCollectionView openTheTimerAndSetTheDuration:3];
            [mySCV addSubview:imageCollectionView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];
    
    
    /*全部商品，分类，本月新品，折扣促销的按钮*/
    {
    for (int i=0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%4*(375/4), anBtn.frame.origin.y+anBtn.frame.size.height+20, 375/4, 375/4*144/162)];
        btn.tag = 300+i;
        if (i == 0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"全部商品@2x.png"] forState:UIControlStateNormal];
        }
        else  if (i == 1) {
            [btn setBackgroundImage:[UIImage imageNamed:@"首页_分类@2x.png"] forState:UIControlStateNormal];
        }
        else  if (i == 2) {
            [btn setBackgroundImage:[UIImage imageNamed:@"本月新品@2x.png"] forState:UIControlStateNormal];
        }
        else  if (i == 3) {
            [btn setBackgroundImage:[UIImage imageNamed:@"折扣促销@2x.png"] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [mySCV addSubview:btn];
    }
    }

    /*分割线推荐商品*/
    {
    UIView * leftLine = [[UIView alloc]initWithFrame:CGRectMake(15, anBtn.frame.origin.y+anBtn.frame.size.height+25+375/4*144/162+22+5, 120, 1)];
    leftLine.backgroundColor = [UIColor lightGrayColor];
    [mySCV addSubview:leftLine];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(155, anBtn.frame.origin.y+anBtn.frame.size.height+25+375/4*144/162+5-10+5, 122, 50)];
    label.text = @"推荐商品";
    [label setTextColor:[UIColor blackColor]];
    [mySCV addSubview:label];
     UIView * rightLine = [[UIView alloc]initWithFrame:CGRectMake(375-120-10, anBtn.frame.origin.y+anBtn.frame.size.height+25+375/4*144/162+22+5, 120, 1)];
    rightLine.backgroundColor = [UIColor lightGrayColor];
    [mySCV addSubview:rightLine];
    }
    
    [mySCV addSubview:_collectionView];/*添加推荐商品的CollectionView*/
    [self.view addSubview:mySCV];
    
    [self.view addSubview:[ShoppingCartSingle sharedShoppingCart]];
}

//最新公告跳转
-(void)didSelectImageWithNumber:(NSInteger)number{
    NSLog(@"点击%@",self.announceInfo[number]);
    NewAnnounceViewController *naVc = [[NewAnnounceViewController alloc]init];
    naVc.content = self.announceInfo[number][@"Content"];
    [self.navigationController pushViewController:naVc animated:nil];
}

-(void)click:(UIButton *)btn{
    if (btn.tag == 300) {
        //全部商品
        AllPeoductsViewController * allVC = [[AllPeoductsViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:NO];
    }
    else if (btn.tag == 301) {
        //分类
        ClassifyViewController * allVC = [[ClassifyViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:NO];
    }
    else if (btn.tag == 302) {
        //本月新品
        MonthNewViewController * allVC = [[MonthNewViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:NO];
    }
    else if (btn.tag == 303){
        //折扣促销
        DiscountViewController * allVC = [[DiscountViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:YES];
    }
    
}


-(void)gotoShoppingcart{
    NSLog(@"购物车被点击");
    //进入详细界面
    ShoppingCartViewController *scc = [[ShoppingCartViewController alloc]init];
    [self.navigationController pushViewController:scc animated:NO];
}

//停止减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view addSubview:[ShoppingCartSingle sharedShoppingCart]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.infinScrollView startAutoScroll];
    
    [[ShoppingCartSingle sharedShoppingCart].priceBtn addTarget:self action:@selector(gotoShoppingcart) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView reloadData];
}

/*------------------初始化collectionView------------------*/
-(void)addCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 290, 375, 667*5) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"AllProCollectionViewCell"];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //自适应大小
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.collectionView];
}
/*------------------------------------------------------------------------------------------------------------------------------*/

/*------------------CollecetionView需要的代理方法----------------*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (2*(section+1)>self.products.count) {
        return 1;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return (self.products.count+1)/2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllProCollectionViewCell" forIndexPath:indexPath];
    
    //数据解析
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
    
    if (arr.count==0) {
        cell.product.clickNumber = @"0";
    }

    cell.delegate = self;
    return cell;
}


//点击CELL
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailProductViewController *dpVC = [[DetailProductViewController alloc]init];
    Product *product = [self.products objectAtIndex:2*indexPath.section+indexPath.row];
    dpVC.product = product;
    [self.navigationController pushViewController:dpVC animated:NO];
    //进入商品详情
    
}

- (void)addPackage:(RecommendCollectionViewCell *)cell{
    NSLog(@"回调");
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.products objectAtIndex:2*path.section+path.row];
    NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] + [product.package integerValue]];
    product.clickNumber = str;
    [ShoppingCartSingle addProductArray:product];
    
    [self.collectionView reloadData];
    
}

- (void)subPackage:(RecommendCollectionViewCell *)cell{
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


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((375 - 80) / 2, (375 - 80) / 2 + 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}
/*------------------------------END---------------------------------------------------------------------*/

/*------------------------------搜索，我的------------------------------*/
//搜索
-(void)searchPushBarButtonHandle{
    SearchViewController *sVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:sVC animated:NO];
}

//我的
-(void)minePushBarButtonHandle{
    
    MineViewController *dvc = [[MineViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:NO];
    
}

/*-------------------------------END------------------------------*/

/*停止滚动：PageControl 的 currentPage 属性*/
- (void) infiniteScrollView:(MLInfiniteScrollView *)scrollView stopScrollAnimationAtIndex:(NSInteger)index {
    _pageControl.currentPage=index;

}

/*将要滚动*/
- (void) infiniteScrollView:(MLInfiniteScrollView *)scrollView willBeginScroll:(NSInteger)index {
}

/*点击*/
- (void) infiniteScrollView:(MLInfiniteScrollView *)scrollView didSelectedItemAtIndex:(NSInteger)index {
    SliderPic *sliderPic = self.sliderPics[index];
    
    if ([sliderPic.linkUrl isKindOfClass:[NSNull class]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    }else{
        NSURL *url = [[NSURL alloc]initWithString:sliderPic.linkUrl];
        [[UIApplication sharedApplication]openURL:url];
        
    }
}

/*视图个数*/
- (NSInteger) numberOfItemsInInfiniteScrollView:(MLInfiniteScrollView *)scrollView {
    return self.sliderPics.count;
}

/*返回需要显示的视图*/
- (MLInfiniteScrollViewCell *) infiniteScrollView:(MLInfiniteScrollView *)scrollView viewAtIndex:(NSInteger)index {
    MLInfiniteScrollViewCell *cell = [scrollView dequeueReusableCellWithIdentifier: @"CellIdentifier"];
    if (!cell) {
        cell = [MLInfiniteScrollViewCell infiniteScrollViewCellWithStyle: MLInfiniteScrollViewStyleSubTitle reusableIdentifier: @"CellIdentifier" bounds: scrollView.bounds];
    }
    SliderPic *sliderPic = self.sliderPics[index];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 170)];
    NSURL *sliderUrl = [[NSURL alloc]initWithString:sliderPic.imageUrl];
     NSLog(@"图片地址%@",sliderPic.imageUrl);
    [imageView setImageWithURL:sliderUrl placeholderImage:[UIImage imageNamed:@"defaultIcon.png"]];
    cell.imageView.image = imageView.image;
    return cell;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    [self.infinScrollView stopAutoScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
