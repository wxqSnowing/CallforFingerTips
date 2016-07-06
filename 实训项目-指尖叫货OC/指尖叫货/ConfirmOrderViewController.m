//
//  ConfirmOrderViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/27.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "OrderViewController.h"

@interface ConfirmOrderViewController ()

@property(nonatomic,strong)UILabel *message;
@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation ConfirmOrderViewController

-(NSMutableArray *)shoppingArray{
    if (!_shoppingArray) {
        _shoppingArray=[NSMutableArray array];
    }
    return _shoppingArray;
}
-(NSMutableArray *)goodsList{
    if (!_goodsList) {
        _goodsList=[NSMutableArray array];
    }
    return _goodsList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addConfirmOrderView];
    self.navigationItem.title=@"确认订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor colorWithRed:74/255.0 green:195/255.0 blue:252/255.0 alpha:1]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
//    Product *pro = self.shoppingArray[0];
    for (Product *pro in self.shoppingArray) {
        NSLog(@"购物数组%@",pro);
        NSDictionary *dic = @{@"GoodsCode":pro.goodsCode,@"Quantity":pro.clickNumber};
        [self.goodsList addObject:dic];
    }
}

-(void)addConfirmOrderView{
    CGFloat sum=0;
    for (Product *pro in _shoppingArray) {
        sum=sum+[pro.clickNumber integerValue]*[pro.discountPrice floatValue];
    }
    
    UILabel *contacterlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64, 375, 30)];
    NSMutableString *contacterStr = [NSMutableString string];
    [contacterStr appendString:@"联系人:"];
    [contacterStr appendString:self.defaultDic[@"Name"]];
    contacterlabel.text = contacterStr;
    [self.view addSubview:contacterlabel];
    
    UILabel *phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, contacterlabel.frame.origin.y+contacterlabel.frame.size.height, 375,contacterlabel.frame.size.height)];
    NSMutableString *phoneStr = [NSMutableString string];
    [phoneStr appendString:@"电话:"];
    [phoneStr appendString:self.defaultDic[@"Mobile"]];
    phonelabel.text = phoneStr;
    [self.view addSubview:phonelabel];
    
    UILabel *addresslabel = [[UILabel alloc]initWithFrame:CGRectMake(10, phonelabel.frame.origin.y+phonelabel.frame.size.height+10, 375, contacterlabel.frame.size.height)];
    NSMutableString *addressStr = [NSMutableString string];
    [addressStr appendString:@"地址:"];
    [addressStr appendString:[NSString stringWithFormat:@"%@-%@",self.defaultDic[@"ProvinceName"],self.defaultDic[@"AddressDetail"]]];
    addresslabel.text = addressStr;
    [self.view addSubview:addresslabel];
    
    UIButton *updateAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(280, addresslabel.frame.origin.y+addresslabel.frame.size.height+10, 132*0.7, 20*0.7)];
    [updateAddressBtn setBackgroundImage:[UIImage imageNamed:@"xiu-拷贝@2x.png"] forState:UIControlStateNormal];
    //修改地址
    [self.view addSubview:updateAddressBtn];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, updateAddressBtn.frame.origin.y+updateAddressBtn.frame.size.height+10, 375, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, updateAddressBtn.frame.origin.y+updateAddressBtn.frame.size.height+10+10, 50, contacterlabel.frame.size.height)];
    label.text = @"小计:";
    [self.view addSubview:label];
    UILabel *totalMoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(60, updateAddressBtn.frame.origin.y+updateAddressBtn.frame.size.height+10+10, 60, contacterlabel.frame.size.height)];
    NSMutableString *totalmonyStr = [NSMutableString string];
    [totalmonyStr appendString:[NSString stringWithFormat:@"%.2f",sum]];
    totalMoneylabel.text = totalmonyStr;
    [totalMoneylabel setTextColor:[UIColor redColor]];
    [self.view addSubview:totalMoneylabel];
    
    
    UILabel *dlabel = [[UILabel alloc]initWithFrame:CGRectMake(250, updateAddressBtn.frame.origin.y+updateAddressBtn.frame.size.height+10+10, 50, contacterlabel.frame.size.height)];
    dlabel.text = @"折扣:";
    [self.view addSubview:dlabel];
    UILabel *discountMoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(300, updateAddressBtn.frame.origin.y+updateAddressBtn.frame.size.height+10+10, 60, contacterlabel.frame.size.height)];
    NSMutableString *discountmonyStr = [NSMutableString string];
    [discountmonyStr appendString:@"0.00"];
    discountMoneylabel.text = discountmonyStr;
    [discountMoneylabel setTextColor:[UIColor redColor]];
    [self.view addSubview:discountMoneylabel];
//
//    
    UILabel *ylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, discountMoneylabel.frame.origin.y+discountMoneylabel.frame.size.height+10, 60, contacterlabel.frame.size.height)];
    ylabel.text = @"运费:";
    [self.view addSubview:ylabel];
    UILabel *freightMoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(60, discountMoneylabel.frame.origin.y+discountMoneylabel.frame.size.height+10, 60, contacterlabel.frame.size.height)];
    NSMutableString *freightmoneyStr = [NSMutableString string];
    [freightmoneyStr appendString:@"0.00"];
    freightMoneylabel.text = discountmonyStr;
    [freightMoneylabel setTextColor:[UIColor redColor]];
    [self.view addSubview:freightMoneylabel];
//
    UILabel *flabel = [[UILabel alloc]initWithFrame:CGRectMake(250, discountMoneylabel.frame.origin.y+discountMoneylabel.frame.size.height+10, 60, contacterlabel.frame.size.height)];
    flabel.text = @"合计:";
    [self.view addSubview:flabel];
    UILabel *finalMoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(300, discountMoneylabel.frame.origin.y+discountMoneylabel.frame.size.height+10, 70, contacterlabel.frame.size.height)];
    NSMutableString *finalmoneyStr = [NSMutableString string];
    [finalmoneyStr appendString:[NSString stringWithFormat:@"%.2f",sum]];
    finalMoneylabel.text = finalmoneyStr;
    [finalMoneylabel setTextColor:[UIColor redColor]];
    [self.view addSubview:finalMoneylabel];
    
    _message = [[UILabel alloc]initWithFrame:CGRectMake(10, finalMoneylabel.frame.origin.y+finalMoneylabel.frame.size.height+10, 50, 30)];
    _message.text = @"留言:";
    [self.view addSubview:_message];
//
    UITextView *messageTv = [[UITextView alloc]initWithFrame:CGRectMake(60,finalMoneylabel.frame.origin.y+finalMoneylabel.frame.size.height+15+15,270,220)];
    messageTv.layer.cornerRadius = 5;
    messageTv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    messageTv.layer.borderWidth =1;
    [self.view addSubview:messageTv];
//400*70
    UIButton *confimBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, messageTv.frame.origin.y+messageTv.frame.size.height+40, 250, 250*70/400)];
    [confimBtn setBackgroundImage:[UIImage imageNamed:@"确认发送@2x.png"] forState:UIControlStateNormal];
    //上传订单
    [confimBtn addTarget:self action:@selector(uploadOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confimBtn];

}

- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)uploadOrder{
    User *user = [User sigleUser];
    
    NSDictionary *updataDic = @{@"CustomerId":user.customerId,
                                @"CustomerName":user.userName,
                                @"CNEE":self.defaultDic[@"Name"],
                                @"ShopName":self.defaultDic[@"ShopName"],
                                @"Mobile":self.defaultDic[@"Mobile"],
                                @"Weixin":self.defaultDic[@"Weixin"],
                                @"Zip":self.defaultDic[@"Zip"],
                                @"ProvinceName":self.defaultDic[@"ProvinceName"],
                                @"CityName":self.defaultDic[@"City"],
                                @"AddressDetail":self.defaultDic[@"AddressDetail"],
                                @"Rest":self.defaultDic[@"Rest"],
                                @"StartTime":self.defaultDic[@"StartTime"],
                                @"EndTime":self.defaultDic[@"EndTime"],
                                @"SalemanId":user.SalemenId,
                                @"IsSalemanOrder":@"false",
                                @"Remark":self.message.text,
                                @"GoodsList":self.goodsList};
    NSLog(@"%@",[self dictionaryToJson:updataDic]);
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Order_AddOrder];//请求地址
    NSLog(@"地址：%@",urlString);
    //配置请求参数
    NSDictionary *params = @{@"orderData":[self dictionaryToJson:updataDic]};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"1111111111");
        NSLog(@"%@",responseObject);
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            NSLog(@"上传成功");
            NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"下单成功" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                OrderViewController *ovc = [[OrderViewController alloc]init];
                [self.navigationController pushViewController:ovc animated:NO];
                
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            

          
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
