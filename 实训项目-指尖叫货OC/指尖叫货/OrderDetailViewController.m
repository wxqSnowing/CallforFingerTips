//
//  OrderDetailViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/28.
//  Copyright © 2016年 team. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

@interface OrderDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *orderIdLabel;
@property(nonatomic,strong)UILabel *freightPriceLabel;
@property(nonatomic,strong)UILabel *amountLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UITableView *mainTable;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    
    [self addOrderDetailView];
    [self.view addSubview:self.mainTable];
}


-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, UISCREE_WIDTH, UISCREE_HEIGHT-160) style:UITableViewStylePlain];
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
    NSArray *arr = self.orderInfo[@"GoodsList"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdentifier";
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    NSLog(@"%@",self.orderInfo[@"GoodsList"]);
    cell.goodDict = self.orderInfo[@"GoodsList"][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"选中行");
//    NSLog(@"该行的订单的信息%@",self.orderList[indexPath.row]);
    
//    OrderDetailViewController *odvc = [[OrderDetailViewController alloc]init];
//    odvc.orderInfo = self.orderList[indexPath.row];
//    [self.navigationController pushViewController:odvc animated:NO];
//    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //NSInteger row = [indexPath row];
    return indexPath;
}




-(void)addOrderDetailView{
    self.orderIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+10, 260, 30)];
//    self.orderIdLabel.backgroundColor = [UIColor redColor];
    NSString  *orderId = [NSString stringWithFormat:@"订单号：%@",self.orderInfo[@"OrderId"]];
    self.orderIdLabel.text = orderId;
    [self.view addSubview:self.orderIdLabel];
    
    self.freightPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(280, 64+10, 80+50, 30)];
//    self.freightPriceLabel.backgroundColor = [UIColor blueColor];
    NSString  *freightPrice = [NSString stringWithFormat:@"运费：%@",self.orderInfo[@"FreightPrice"]];
    self.freightPriceLabel.text = freightPrice;
    [self.view addSubview:self.freightPriceLabel];
    
    self.amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+50+10, 220, 30)];
//    self.amountLabel.backgroundColor = [UIColor greenColor];
//    NSString  *amount = @"数量：X20";
    NSInteger sum = 0;
    NSArray *arr = self.orderInfo[@"GoodsList"];
    for (int i = 0; i<arr.count; i++) {
        NSDictionary *one = arr[i];
        NSInteger num = [one[@"Quantity"] integerValue];
        sum = sum + num;
    }
    self.amountLabel.text = [NSString stringWithFormat:@"X%ld",(long)sum];
    [self.view addSubview:self.amountLabel];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(315-50-50, 64+50+10, 80+50, 30)];
//    self.moneyLabel.backgroundColor = [UIColor yellowColor];
    
    NSString  *money = [NSString stringWithFormat:@"合计：%.2f",[self.orderInfo[@"Amount"] floatValue]+[self.orderInfo[@"FreightPrice"] floatValue]];
    
    self.moneyLabel.text = money;
    [self.view addSubview:self.moneyLabel];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64+50+10+40, 375, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
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
