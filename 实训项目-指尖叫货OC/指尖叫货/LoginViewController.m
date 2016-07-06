//
//  LoginViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "LoginViewController.h"
#import "LookUPPWDViewController.h"
#import "MineViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *info;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBarTintColor:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]}];
    [self addLoginView];
}

-(UITextField *)createTextField:(UITextField *)textField{
    textField =  [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor colorWithRed:36/255.0 green:137/255.0  blue:251/255.0  alpha:1].CGColor;//边框颜色
    textField.textColor = [UIColor blackColor];//文字颜色
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = 5;
    [textField setFont:[UIFont systemFontOfSize:18]];
    textField.layer.masksToBounds = YES;
    return textField;
}

-(void)addLoginView{
    //设置输入框
    {
        _nameTextField = [self createTextField:_nameTextField];
        _nameTextField.frame = CGRectMake(17, 64+30, 375-17-17, 50);
        _nameTextField.tag = 1;
        _nameTextField.placeholder = @"请输入账号";
        UIImageView * imgUser = [[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 52*0.7, 38*0.7)];
        imgUser.image = [UIImage imageNamed:@"xinxi@2x.png"];
        _nameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
        [_nameTextField.leftView addSubview:imgUser];
        [self.view addSubview:_nameTextField];
        
        _passwordTextField = [self createTextField:_passwordTextField];
        _passwordTextField.frame = CGRectMake(17, 64+30+50+30, 375-17-17, 50);
        _passwordTextField.tag = 2;
        _passwordTextField.placeholder = @"请输入密码";
        UIImageView * imgPwd = [[UIImageView alloc]initWithFrame:CGRectMake(16, 8, 48*0.7, 54*0.7)];
        imgPwd.image = [UIImage imageNamed:@"mima-(1)@2x.png"];
        _passwordTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
        [_passwordTextField.leftView addSubview:imgPwd];
        _passwordTextField.secureTextEntry = YES;//密文输入
        [self.view addSubview:_passwordTextField];
    }
    
    //登录，注册，找回密码按钮设置
    {
        UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(35, 64+30+70+55+50+30, 375-70, 50)];
        [loginBtn setTitle:@"  登录" forState:UIControlStateNormal];
        loginBtn.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0  blue:251/255.0  alpha:1];
        loginBtn.layer.cornerRadius = 25;
        loginBtn.tag = 201;
        [self.view addSubview:loginBtn];
        [loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn.frame.origin.x, loginBtn.frame.origin.y+60+20, 375-70, 50)];
        [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:[UIColor colorWithRed:36/255.0 green:137/255.0  blue:251/255.0  alpha:1] forState:UIControlStateNormal];
        forgetBtn.tag = 202;
        [forgetBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgetBtn];
        
        UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(forgetBtn.frame.origin.x, forgetBtn.frame.origin.y+30+20, 375-70, 50)];
        [registerBtn setTitle:@"新用户？注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor colorWithRed:36/255.0 green:137/255.0  blue:251/255.0  alpha:1] forState:UIControlStateNormal];
        registerBtn.tag = 203;
        [registerBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:registerBtn];
    }
    
}

-(void)click:(UIButton *)btn{
    if (btn.tag == 201) {
        //判断是否登录成功
        //生成请求类
        if ([self.nameTextField.text isEqualToString:@""]||[self.passwordTextField.text isEqualToString:@""]) {
            //输入不完整
             NSLog(@"登录信息输入失败");
            NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            

        }else{
            NSString *urlString = [BaseUrl stringByAppendingString:Customer_Login];//请求地址
            NSLog(@"地址：%@",urlString);
            //配置请求参数
            NSDictionary *params = @{
                                     @"LoginName":self.nameTextField.text,
                                     @"Password":[self.passwordTextField.text md5Encrypt]
                                     };
            //block发送请求
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"QQQQQQ%@",responseObject[@"statusCode"]);
                
                if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                    self.info = responseObject[@"data"];
                    NSLog(@"登录结果:%@",self.info);
                    self.user = [User sigleUser];
                    self.user.loginStatus = true;
                    self.user.userName = self.nameTextField.text;
                    self.user.userPWD = self.passwordTextField.text;
                    self.user.addDate = self.info[0][@"AddDate"];
                    self.user.SalemenId = self.info[0][@"SalemanId"];
                    self.user.customerId = self.info[0][@"Id"];
                    NSLog(@"%@",self.user);
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:self.user.userName forKey:@"user"];
                    [userDefaults setObject:self.user.userPWD forKey:@"password"];
                    [userDefaults setObject:self.user.addDate forKey:@"addDate"];
                    [userDefaults setObject:self.user.SalemenId forKey:@"SalemenId"];
                    [userDefaults setObject:self.user.customerId forKey:@"customerId"];
                    [userDefaults synchronize];
                    
                    self.navigationController.navigationBarHidden = NO;//隐藏navigationBar
                    [self.navigationController popViewControllerAnimated:NO];
                    //返回我的
                }else{
                    NSLog(@"登录失败");
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"err = %@",error);
            }];
        }
    }
    else if (btn.tag == 202) {
        //修改密码
        LookUPPWDViewController *lupvc = [[LookUPPWDViewController alloc]init];
        [self.navigationController pushViewController:lupvc animated:NO];
    }
    else if (btn.tag == 203) {
        //返回注册
        RegisterViewController *rvc = [[RegisterViewController alloc]init];
        [self.navigationController pushViewController:rvc animated:NO];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
