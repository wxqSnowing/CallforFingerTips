//
//  OrderViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "OrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "OrderDetailViewController.h"

@interface OrderViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scv;
@property(nonatomic,strong)UITableView *mainTable;
@property(strong,nonatomic)NSMutableArray *titleNames;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *orderList;
@end

@implementation OrderViewController

-(NSMutableArray *)orderList{
    if (!_orderList) {
        _orderList = [NSMutableArray array];
    }
    return _orderList;
}

- (NSMutableArray *)titleNames{
    if (!_titleNames) {
        _titleNames = [NSMutableArray array];
    }
    return _titleNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"我的订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    
    [self addMyOrderView];
    
    [self.view addSubview:self.mainTable];
    
    [self getData:@"0"];
   
}

-(void)getData:(NSString *)choose{
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Order_GetList];//请求地址
    NSLog(@"地址：%@",urlString);
    //配置请求参数
    NSDictionary *params = @{@"status":choose,
                             @"customerId":@"",
                             @"salemanId":@"",
                             @"pageIndex":@"1",
                             @"pageSize":@"20"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            NSLog(@"%@",responseObject);
            self.info = responseObject[@"data"][0][@"List"];
            NSLog(@"获取到的数据%@",self.info);
            //加载数据视图
            for (NSDictionary *one in self.info) {
                [self.orderList addObject:one];
            }
            [self.mainTable reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];


}

-(void)addMyOrderView{
    //已下单，已完成，已取消
    [self.titleNames addObject:@"已下单"];
    [self.titleNames addObject:@"已完成"];
    [self.titleNames addObject:@"已取消"];
    
    self.scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 375, 50)];
    _scv.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<self.titleNames.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30+100*i, -54, 90, 40)];
        btn.layer.cornerRadius = 10;
        if (i == 0) {
            btn.backgroundColor = [[UIColor alloc]initWithRed:155/255.0 green:202/255.0 blue:252/255.0 alpha:1];
        }
        else{
            btn.backgroundColor = [UIColor whiteColor];
        }
        [btn setTitle:self.titleNames[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scv addSubview:btn];
    }
    _scv.contentSize = CGSizeMake(10+self.titleNames.count*70, 200);
    _scv.delegate = self;
    _scv.pagingEnabled = NO;
    _scv.showsHorizontalScrollIndicator = NO;
    _scv.showsVerticalScrollIndicator = NO;
    _scv.bounces = YES;
    _scv.scrollEnabled = NO;
    [self.view addSubview:_scv];
    
    
}

-(void)click:(UIButton *)btn{
    for (int i = 0; i<self.titleNames.count; i++) {
        if (btn.tag==i+10) {
            btn.backgroundColor = [[UIColor alloc]initWithRed:155/255.0 green:202/255.0 blue:252/255.0 alpha:1];
            [self.orderList removeAllObjects];
            if (i==2) {
                [self getData:@"-1"];
            }else{
                [self getData:[NSString stringWithFormat:@"%d",i]];
            }
            NSLog(@"重新获取的长度%lu",(unsigned long)self.orderList.count);
            [self.mainTable reloadData];
        }else{
            UIButton *btn = [self.view viewWithTag:i+10];
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+50+10, UISCREE_WIDTH, UISCREE_HEIGHT-64-50-10) style:UITableViewStylePlain];
        _mainTable.separatorColor = [UIColor clearColor];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
    }
    return _mainTable;
    
}

//分区
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView
{
    return 1;
}
//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdentifier";
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    if (self.orderList.count!=0) {
        NSLog(@"数组的长度为:%ld",self.orderList.count);
        NSLog(@"%@",self.orderList[indexPath.row]);
        cell.orderDict = self.orderList[indexPath.row];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"选中行");
    NSLog(@"该行的订单的信息%@",self.orderList[indexPath.row]);
    
    OrderDetailViewController *odvc = [[OrderDetailViewController alloc]init];
    odvc.orderInfo = self.orderList[indexPath.row];
    
    [self.navigationController pushViewController:odvc animated:NO];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //NSInteger row = [indexPath row];
    return indexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
