//
//  StoreBrifeViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "StoreBrifeViewController.h"

@interface StoreBrifeViewController ()
@property (nonatomic, strong) NSArray *info;
@end

@implementation StoreBrifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"商家简介";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    
    
    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:Remark_GetContent];//请求地址
    NSLog(@"地址：%@",urlString);
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64)];
            tv.text = self.info[0][@"Content"];
            [tv setTextColor:[UIColor blackColor]];
            [tv setFont:[UIFont systemFontOfSize:18]];
            [self.view addSubview:tv];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];

    
    // Do any additional setup after loading the view.
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
