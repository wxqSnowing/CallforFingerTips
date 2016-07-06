//
//  NewAnnounceViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/29.
//  Copyright © 2016年 team. All rights reserved.
//

#import "NewAnnounceViewController.h"

@interface NewAnnounceViewController ()

@end

@implementation NewAnnounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"最新公告";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    tv.text = self.content;
    [tv setFont:[UIFont systemFontOfSize:20]];
    [tv setTextColor:[UIColor blackColor]];
    [self.view addSubview:tv];
}

-(void)viewDidAppear:(BOOL)animated{
   
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
