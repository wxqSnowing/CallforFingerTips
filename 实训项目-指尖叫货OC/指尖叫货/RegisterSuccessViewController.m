//
//  RegisterSuccessViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "MineViewController.h"
@interface RegisterSuccessViewController ()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *nowLoginBtn;
@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册成功";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(70, 133, 305, 70)];
    _label.text = @"恭喜你，注册成功！！！";
    [_label setFont:[UIFont fontWithName:@"Verdana" size:20]];
    //    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label];
    
    _nowLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 180+78, 255, 50)];
    _nowLoginBtn.layer.cornerRadius = 5;
    [_nowLoginBtn setBackgroundImage:[UIImage imageNamed:@"马上登录"] forState:UIControlStateNormal];
    [_nowLoginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nowLoginBtn];
    
}

-(void)click:(UIButton *)btn{
    MineViewController *myVC = [[MineViewController alloc]init];
    
    [self.navigationController pushViewController:myVC animated:NO];
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
