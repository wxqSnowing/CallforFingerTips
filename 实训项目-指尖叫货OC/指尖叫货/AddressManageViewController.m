//
//  AddressManageViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "AddressManageViewController.h"
#import "DeliveryAddressViewController.h"
#import "AddressTableViewCell.h"
#import "UpdateAddressViewController.h"

@interface AddressManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTable;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableArray *addressList;
@end

@implementation AddressManageViewController

-(NSMutableArray *)addressList{
    
    if (!_addressList) {
        _addressList = [NSMutableArray array];
    }
    return _addressList;

}

-(void)updateAddress:(AddressTableViewCell *)cell{
    NSLog(@"回调");
    
    UpdateAddressViewController *uavc = [[UpdateAddressViewController alloc]init];
    uavc.addressId = cell.addressDict[@"Id"];
    [self.navigationController pushViewController:uavc animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"地址管理";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];

    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addBarButtonItem, nil];
    
    [self.view addSubview:self.mainTable];
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
//    [self.mainTable reloadData];
    
}

-(void)getData{
    self.user = [User sigleUser];
    //生成请求类
    NSLog(@"客户编码%@",self.user.customerId);
    NSString *urlString = [BaseUrl stringByAppendingString:Customer_GetAddress];//请求地址
    NSLog(@"地址：%@",urlString);
    //配置请求参数
    NSDictionary *params = @{@"customerId":self.user.customerId,
                             @"onlyDefault":@"0"};
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"1111111111");
        NSLog(@"%@",responseObject);
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            NSLog(@"%@",responseObject);
            self.info = responseObject[@"data"];
            NSLog(@"获取到的地址%lu",(unsigned long)self.info.count);
            for (NSDictionary *one in self.info) {
                [self.addressList addObject:one];
            }
//            [self.view addSubview:self.mainTable];
            [self.mainTable reloadData];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];

}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREE_WIDTH, UISCREE_HEIGHT) style:UITableViewStylePlain];
        _mainTable.separatorColor = [UIColor clearColor];
        _mainTable.backgroundColor = [UIColor whiteColor];
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
    
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdentifier";
     AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    cell.addressDict = self.addressList[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"选中行");
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //NSInteger row = [indexPath row];
    return indexPath;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)addClick{
    DeliveryAddressViewController *dvc = [[DeliveryAddressViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:NO];
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
