//
//  CustomerServiceViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "CustomerServiceTableViewCell.h"


@interface CustomerServiceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *info;
@property(nonatomic,strong)UITableView *mainTable;

@property (nonatomic, strong) NSMutableArray *customerServiceList;
@end

@implementation CustomerServiceViewController

- (NSMutableArray *)customerServiceList{
    if (!_customerServiceList) {
        _customerServiceList = [NSMutableArray array];
    }
    return _customerServiceList;
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
        _mainTable.separatorColor = [UIColor clearColor];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
    }
    return _mainTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.navigationItem.title = @"客服电话";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    // Do any additional setup after loading the view.
    
     [self.view addSubview:self.mainTable];
    
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Phone_GetList];//请求地址
    NSLog(@"地址：%@",urlString);
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            for (int i = 0; i<self.info.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:self.info[i][@"Id"] forKey:@"Id"];
                [dic setObject:self.info[i][@"PhoneNumber"] forKey:@"PhoneNumber"];
                NSLog(@"%@",dic);
                [self.customerServiceList addObject:dic];
            }
            [self.mainTable reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];

    
    
    
    
}


//分区
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView
{
    return 1;
}
//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.customerServiceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdentifier";
    CustomerServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[CustomerServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    NSDictionary *dic = self.customerServiceList[indexPath.row];
    cell.mainInfo = dic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130/1.6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"选中行");
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
