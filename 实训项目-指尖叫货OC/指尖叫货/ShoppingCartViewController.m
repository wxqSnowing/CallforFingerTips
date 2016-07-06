//
//  ShoppingCartViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartSingle.h"
#import "DetailProductViewController.h"
#import "ConfirmOrderViewController.h"

@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *shoppingArray;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UILabel *sumPriceLabel;
@property(nonatomic,strong)UIButton *orderBtn;
@property (nonatomic, strong) NSArray *info;
@property(nonatomic,strong)NSDictionary *defaultAddress;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    {
    self.orderBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [self.orderBtn addTarget:self action:@selector(oderPushBarButtonHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn setImage:[UIImage imageNamed:@"下单@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *bitm = [[UIBarButtonItem alloc]initWithCustomView:self.orderBtn];
        self.navigationItem.rightBarButtonItem = bitm;
    }
    
    
    self.shoppingArray=[ShoppingCartSingle getShoppingArray];
    NSLog(@"shoppingArray:%@",self.shoppingArray);
    if (self.shoppingArray.count==0) {
        self.orderBtn.alpha = 0;
    }
    
    self.navigationItem.title=@"购物车";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor colorWithRed:74/255.0 green:195/255.0 blue:252/255.0 alpha:1]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键


    [self addviews];
    [self addLabels];

    [self.view addSubview:self.tableView];
    
  

}

-(void)viewWillAppear:(BOOL)animated{
    self.shoppingArray=[ShoppingCartSingle getShoppingArray];
    NSLog(@"shoppingArray:%@",self.shoppingArray);
    
    if (self.shoppingArray.count!=0) {
        self.orderBtn.alpha = 1;
    }
    
    [self.tableView reloadData];
}

-(NSMutableArray *)shoppingArray{
    if (!_shoppingArray) {
        _shoppingArray=[NSMutableArray array];
    }
    return _shoppingArray;
}

-(void)addLabels{
    _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,8+64, 100, 25)];
    [self.view addSubview:_numberLabel];
    
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(60,40+11+64,150,25)];
    [self.view addSubview:_priceLabel];
    
    
    _sumPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(240+60,40+11+64, 150, 25)];
    [self.view addSubview:_sumPriceLabel];
}

-(void)oderPushBarButtonHandle{
    //判断是否登录
    if ([User sigleUser].loginStatus) {
        NSLog(@"已经登录");
        NSLog(@"下单");
        //判断是否设置默认地址
        [self getDefaultAddress];
    }
    else{
        NSLog(@"请登录");
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        

    }
}

-(void)getDefaultAddress{
    User *user;
    user = [User sigleUser];
    //生成请求类
    NSLog(@"客户编码%@",user.customerId);
    NSString *urlString = [BaseUrl stringByAppendingString:Customer_GetAddress];//请求地址
    NSLog(@"地址：%@",urlString);
    //配置请求参数
    NSDictionary *params = @{@"customerId":user.customerId,
                             @"onlyDefault":@"1"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"1111111111");
        NSLog(@"%@",responseObject);
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            NSLog(@"%@",responseObject);
            self.info = responseObject[@"data"];
            NSLog(@"QQQQQ%@",self.info);
            NSLog(@"获取到的地址%lu",(unsigned long)self.info.count);
            if (self.info.count>0) {
                self.defaultAddress = self.info[0];
                if (self.defaultAddress!=nil) {
                    ConfirmOrderViewController *cvc = [[ConfirmOrderViewController alloc]init];
                    cvc.defaultDic = self.defaultAddress;
                    cvc.shoppingArray = self.shoppingArray;
                    [self.navigationController pushViewController:cvc animated:NO];
                }
            }else{
                NSLog(@"请设置默认地址");
                NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请设置默认地址" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                

            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];
    
}


-(void)addText{
    NSString *number=[NSString  stringWithFormat:@"%ld",_shoppingArray.count];
    _numberLabel.text=[@"数量：" stringByAppendingString:number];
    
    CGFloat sum=0;
    for (Product *pro in _shoppingArray) {
        sum=sum+[pro.clickNumber integerValue]*[pro.discountPrice floatValue];
    }
    _priceLabel.text=[@"€" stringByAppendingString:[NSString stringWithFormat:@"%.2lf",sum]];
    _sumPriceLabel.text=[@"€" stringByAppendingString:[NSString stringWithFormat:@"%.2lf",sum]];
}

-(void)addviews{
    for (int i=0; i<10; i++) {
        UILabel *label=[[UILabel alloc]init];
        if (i>=0&&i<=3) {
            label.frame=CGRectMake(i%2*220+10, i/2*40+8+64, 100, 25);
        }else if (i>=4&&i<=8){
            label.textColor=[UIColor redColor];
            if (i<7) {
                label.frame=CGRectMake((i+1)%2*240+60, (i-3)/2*40+11+64, 150, 25);
            }else if(i==7) {
                label.frame=CGRectMake(100, (i-3)/2*40+8+64, 100, 25);
            }else if(i==8) {
                label.frame=CGRectMake(10, (i-4)/2*40+8+64, 100, 25);
            }
        }
        switch (i) {
            case 1:
                label.text=@"运费:";
                break;
            case 2:
                label.text=@"金额：";
                break;
            case 3:
                label.text=@"总金额：";
                break;
            case 4:
                label.text=@"€0.00";//运费
                break;
            case 7:
                label.text=@"€500";
                label.alpha=0;
                break;
            case 8:
                label.text=@"提示：";
                break;
            case 9:
            {
                label.frame=CGRectMake(60, (i-5)/2*40+8+64, 60, 25);
                label.text=@"免运费";
                break;
            }
            default:
                break;
        }
        [self.view addSubview:label];
    }
    UIImageView *imaView1= [[UIImageView alloc]initWithFrame:CGRectMake(0,180,375, 5)];
    imaView1.image=[UIImage imageNamed:@"分割线.png"];
    [self.view addSubview:imaView1];
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,190, 375,667-190) style:UITableViewStylePlain];
        _tableView.separatorColor=[UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //每次加载都要读取文件
    self.shoppingArray=[ShoppingCartSingle getShoppingArray];
    NSLog(@"%@",self.shoppingArray);
    [self addText];//重新加载text
    
    static NSString * cellReuseIndentifier = @"cellOrderIndentifier";
    ShoppingCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellReuseIndentifier];
    if (!cell) {
        cell=[[ShoppingCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIndentifier];
    }
    
    Product *product = [self.shoppingArray objectAtIndex:indexPath.row];
    NSLog(@"%@",self.shoppingArray[indexPath.row]);
//    NSLog(@"%@",product);
    cell.product = product;
//    cell.product.imageUrl
    NSLog(@"图片地址%@",cell.product.imageUrl);

    cell.delegate=self;
    
    if (_shoppingArray.count!=0) {
        cell.product=_shoppingArray[indexPath.row];//将数据传过去
    }else{
        return nil;
    }
    
    return cell;
}

//删除cell
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        NSLog(@"当前选中：%ld",indexPath.row);
        
        Product *pro = [[Product alloc]init];
        pro=_shoppingArray[indexPath.row];
        pro.clickNumber = @"0";
        [ShoppingCartSingle reduceProductArray:pro];//删除当前选中数据
        
        _shoppingArray=[ShoppingCartSingle getShoppingArray];//获取新的数据
        NSLog(@"shooping:%@",_shoppingArray);
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self addText];//重新加载text
        
        [self.tableView reloadData];
        
        if (_shoppingArray.count ==0) {
            _orderBtn.alpha = 0;
        }
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shoppingArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     DetailProductViewController*gdVC=[[DetailProductViewController alloc]init];
    gdVC.product=_shoppingArray[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选中结果
    [self.navigationController pushViewController:gdVC animated:NO];
}

//能够左滑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - cell回调方法
- (void)addPackage:(ShoppingCartTableViewCell *)cell{
    
    NSLog(@"回调");
    NSIndexPath *path = [self.self.tableView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.shoppingArray objectAtIndex:path.row];
    NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] + [product.package integerValue]];
    product.clickNumber = str;
    
    [self.tableView reloadData];
    
    [ShoppingCartSingle addProductArray:product];
}

- (void)reducePackage:(ShoppingCartTableViewCell *)cell{
    NSLog(@"回调");
    NSIndexPath *path = [self.self.tableView indexPathForCell:cell];//获得cell对应的索引;
    Product *product = [self.shoppingArray objectAtIndex:path.row];
    NSInteger num = [product.clickNumber integerValue] - [product.package integerValue];
    if (num>=0) {
        NSString *str = [NSString stringWithFormat:@"%ld",[product.clickNumber integerValue] - [product.package integerValue]];
        product.clickNumber = str;
    }else{
        product.clickNumber = @"0";
    }
    [ShoppingCartSingle reduceProductArray:product];
    [self.tableView reloadData];
    
    if (_shoppingArray.count==0) {
        _orderBtn.alpha = 0;
    }
    [self addText];//重新加载text
    
}


@end
