//
//  MineViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "MineViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "AddressManageViewController.h"
#import "StoreBrifeViewController.h"
#import "CustomerServiceViewController.h"
#import "OrderViewController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTable;

@property(nonatomic,strong) UIView *firstView;
@property(nonatomic,strong) UIView *userView;
@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.user = [User sigleUser];
    
    [self addMineView];
    
    [self.view addSubview:self.mainTable];
 
}

-(void)addMineView{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 285*375/553)];
    myView.backgroundColor = [[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 28, 35, 35)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回@2x"] forState:UIControlStateNormal];
    backBtn.tag = 101;
    [backBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:backBtn];
    //124
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(backBtn.center.x+132+10, 20, 600, 55)];
    label.text = @"我的";
    [label setFont:[UIFont systemFontOfSize:20]];
    label.textColor = [UIColor whiteColor];
    [myView addSubview:label];
    
    self.firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 375, 110)];
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(120, 26, 60, 30)];
    registerBtn.tag = 102;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview:registerBtn];
    
    UIView *smllView = [[UIView alloc]initWithFrame:CGRectMake(registerBtn.center.x+33, 16, 2, 53)];
    smllView.backgroundColor = [UIColor whiteColor];
    [self.firstView addSubview:smllView];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(smllView.center.x+5, 26, 60, 30)];
    loginBtn.tag = 103;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview:loginBtn];
    
    [myView addSubview:self.firstView];
    
    
    self.userView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 375, 110)];
    self.userView.backgroundColor = [[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1];
    //显示用户名和退出
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
    self.nameLabel.text = @"123";
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.userView addSubview:self.nameLabel];
    
    UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(375/2-50+10+2, 50+5, 80, 40)];
    [exitBtn setTitle:@"退出" forState:UIControlStateNormal];
    exitBtn.layer.borderWidth = 1.0;
    exitBtn.layer.cornerRadius = 10;
    exitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    exitBtn.tag = 104;
    [exitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.userView addSubview:exitBtn];
    
    [myView addSubview:self.userView];
    
    self.firstView.hidden = NO;
    self.userView.hidden = YES;
    
    [self.view addSubview:myView];
    
}

-(void)click:(UIButton *)btn{
    self.navigationController.navigationBarHidden = NO;//隐藏navigationBar
    if (btn.tag == 101) {
        //返回主界面
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    else if (btn.tag == 102) {
        //注册
        RegisterViewController *rvc = [[RegisterViewController alloc]init];
        [self.navigationController pushViewController:rvc animated:YES];
    }
    else if (btn.tag == 103){
        //登录
        LoginViewController *lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    else if (btn.tag == 104){
        self.firstView.hidden = NO;
        self.userView.hidden = YES;
        User *user = [User sigleUser];
        user.loginStatus = false;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults removeObjectForKey:@"user"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults removeObjectForKey:@"addDate"];
        [userDefaults removeObjectForKey:@"SalemenId"];
        [userDefaults removeObjectForKey:@"customerId"];

        self.navigationController.navigationBarHidden = YES;//隐藏navigationBar
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.user.loginStatus) {
        self.firstView.hidden = YES;
        self.userView.hidden = NO;
        NSLog(@"登录的用户名是:%@",self.user.userName);
        self.nameLabel.text = self.user.userName;
    }
    self.navigationController.navigationBarHidden = YES;//隐藏navigationBar
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 285*375/553, 375, 667-64) style:UITableViewStylePlain];
        _mainTable.separatorColor = [UIColor clearColor];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.scrollEnabled = NO;
    }
    return _mainTable;
    
}
//每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
//实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.accessoryType = YES;
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-dingdan-(1)"];
        cell.textLabel.text = @"订单";
    }
    else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-dizhi@2x.png"];
        cell.textLabel.text = @"收货地址";
    }
    else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-dianhua@2x.png"];
        cell.textLabel.text = @"客服电话";
    }
    else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-shangjiajieshao@2x.png"];
        cell.textLabel.text = @"商家简介";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //订单
        if (self.user.loginStatus){
            OrderViewController *oVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:oVC animated:NO];
        }else{
            NSLog(@"请登录");
            NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];

        }
    }
    else if (indexPath.row==1) {
        //收货地址
        if (self.user.loginStatus){
            AddressManageViewController *amVC = [[AddressManageViewController alloc]init];
            [self.navigationController pushViewController:amVC animated:NO];
        }else{
            NSLog(@"请登录");
            NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
    else if (indexPath.row==2) {
        //客服电话
        CustomerServiceViewController *oVC = [[CustomerServiceViewController alloc]init];
        [self.navigationController pushViewController:oVC animated:NO];
        
    }
    else if (indexPath.row==3) {
        //商家简介
        StoreBrifeViewController *oVC = [[StoreBrifeViewController alloc]init];
        [self.navigationController pushViewController:oVC animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
