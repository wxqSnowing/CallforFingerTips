//
//  ClassifyViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ClassifyViewController.h"
#import "AllPeoductsViewController.h"
#import "MonthNewViewController.h"
#import "DiscountViewController.h"
#import "ClassifyTableViewCell.h"
#import "ProductCatogory.h"
#import "ClassifyTableViewCell.h"
#import "ProductCatogoryChild.h"
#import "CatogoryDetailViewController.h"


@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *productCatogoryList;
@property(nonatomic,strong)UITableView *mainTable;
@property(nonatomic,strong)NSMutableArray *productChildrenInfo;
@property(nonatomic,assign)NSInteger selectCatogory;
@property(nonatomic,strong)NSMutableArray *selectCatogoryTitles;
@end

@implementation ClassifyViewController

- (NSMutableArray *)productCatogoryList
{
    if (!_productCatogoryList) {
        _productCatogoryList = [NSMutableArray array];
    }
    return _productCatogoryList;
}

-(NSMutableArray *)productChildrenInfo{
    if (!_productChildrenInfo) {
        _productChildrenInfo = [NSMutableArray array];
    }
    return _productChildrenInfo;
}

-(NSMutableArray *)selectCatogoryTitles{
    if (!_selectCatogoryTitles) {
        _selectCatogoryTitles = [NSMutableArray array];
    }
    return _selectCatogoryTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor greenColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"分类";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    
    [self addFourTopButton];
    
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:ByCategory_GetList];//请求地址
    NSLog(@"地址：%@",urlString);
    //配置请求参数
    NSDictionary *params = @{@"goodsStatusCode":@"0",
                             @"pageIndex":@"1",
                             @"pageSize":@"20"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            NSLog(@"%@",self.info);
            for (int i = 0; i<self.info.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:self.info[i][@"Title"] forKey:@"Title"];
                [dic setObject:self.info[i][@"Children"] forKey:@"Children"];
                
                ProductCatogory *pc = [ProductCatogory productCatogoryWithDictionary:[dic mutableCopy]];
                [self.productCatogoryList addObject:pc];
            }
            //加载数据视图
            [self addLeftClassifyButton];
            ProductCatogory *p = self.productCatogoryList[0];
            self.selectCatogory = 0;
            for (ProductCatogoryChild *one in p.children) {
                [self.productChildrenInfo addObject:one];
            }
            
            
            [self.view addSubview:self.mainTable];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];

}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(UISCREE_WIDTH/4+20, 64+83-20, UISCREE_WIDTH-375/4+2, UISCREE_HEIGHT-64) style:UITableViewStylePlain];
        _mainTable.separatorColor = [UIColor clearColor];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
    }
    return _mainTable;
    
}


- (void)addFourTopButton
{
    for (int i=0; i<4; i++) {
        //162*144
        //375*667
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%4*(375/4), 64, 375/4, 375/4*144/162-20)];
        //设置tag值
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
        [self.view addSubview:btn];
    }
}

- (void)click:(UIButton *)btn{

    
    if (btn.tag == 300) {
        //全部商品
        AllPeoductsViewController * allVC = [[AllPeoductsViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:YES];
    }
    /*
    else if (btn.tag == 301) {
        //分类
        ClassifyViewController * allVC = [[ClassifyViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:YES];
    }
     */
    else if (btn.tag == 302) {
        //本月新品
        MonthNewViewController * allVC = [[MonthNewViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:YES];
        
    }
    else if (btn.tag == 303){
        //折扣促销
        DiscountViewController * allVC = [[DiscountViewController alloc]init];
        [self.navigationController pushViewController:allVC animated:YES];
    }
    
}

- (void)addLeftClassifyButton
{
    //网络获取分类总数
    for (int i=0; i<self.productCatogoryList.count; i++) {
        //162*144
        //375*667  375/4*144/162-20
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+83+i*62-20, 375/4+20, 62)];
        //375/4*144/162=83
        //设置tag值
        leftBtn.tag = 100+i;
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftBtn.backgroundColor = [[UIColor alloc]initWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        
        //网络获取
        ProductCatogory *pc = self.productCatogoryList[i];
    
        [leftBtn setTitle:pc.title forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftBtn];
    }
}

- (void)clickLeftBtn:(UIButton *)leftBtn
{
    for (int i=0; i<self.productCatogoryList.count; i++) {
        if (leftBtn.tag==100+i) {
            self.selectCatogory = i;
            //移除productChildrenInfo
            [self.productChildrenInfo removeAllObjects];
            //更新productChildrenInfo
            ProductCatogory *p = self.productCatogoryList[i];
            for (ProductCatogoryChild *one in p.children) {
                [self.productChildrenInfo addObject:one];
            }
            [self.mainTable reloadData];
        }
    }
}

//添加右侧tableview

//分区
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView
{
    return 1;
}
//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"孩子的个数:%lu",(unsigned long)self.productChildrenInfo.count);
    return self.productChildrenInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdentifier";
    ClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[ClassifyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    ProductCatogoryChild *pc = self.productChildrenInfo[indexPath.row];
    cell.child = pc;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130/1.6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
     NSLog(@"选中行");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转到相应的界面self.selectCatogory
    CatogoryDetailViewController *cdVC = [[CatogoryDetailViewController alloc]init];
    ProductCatogory *pc = self.productCatogoryList[self.selectCatogory];
    cdVC.pc = pc;
    [self.navigationController pushViewController:cdVC animated:NO];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //NSInteger row = [indexPath row];
    return indexPath;
}


@end