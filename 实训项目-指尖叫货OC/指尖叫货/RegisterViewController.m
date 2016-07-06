//
//  RegisterViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSuccessViewController.h"
#import "AFNetworking/AFNetworking.h"

#define UISCREE_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Customer_Register @"/Customer/Register"


@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *confirmRegisterBtn;
@property (nonatomic, strong) NSArray *info;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]}];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    [self addRegisterView];
    self.navigationController.navigationBarHidden = NO;//隐藏navigationBar
}

-(UITextField *)createTextField:(UITextField *)textField{
    textField =  [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.borderWidth = 1;
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = 5;
    [textField setFont:[UIFont systemFontOfSize:20]];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0  blue:215/255.0  alpha:1].CGColor;
    textField.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0  blue:250/255.0  alpha:1];
    return textField;
}

-(void)addRegisterView{
    _nameTextField = [self createTextField:_nameTextField];
    _nameTextField.frame = CGRectMake(4.5, 64+20, 375-9, 50);
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    nameLabel.text = @"账号：";
    _nameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 70)];
    [_nameTextField.leftView addSubview:nameLabel];
    [self.view addSubview:_nameTextField];
    
    _passwordTextField = [self createTextField:_nameTextField];
    _passwordTextField.frame = CGRectMake(4.5, _nameTextField.frame.origin.y+_nameTextField.frame.size.height+20, 375-9, 50);
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    passwordLabel.text = @"输入密码：";
    _passwordTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 70)];
    [_passwordTextField.leftView addSubview:passwordLabel];
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    
    _confirmPWDTextField = [self createTextField:_nameTextField];
    _confirmPWDTextField.frame = CGRectMake(4.5, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+20, 375-9, 50);
    UILabel *confirmPWDLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    confirmPWDLabel.text = @"确认密码：";
    _confirmPWDTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 70)];
    [_confirmPWDTextField.leftView addSubview:confirmPWDLabel];
    _confirmPWDTextField.secureTextEntry = YES;
    [self.view addSubview:_confirmPWDTextField];
    
    _emailTextField = [self createTextField:_nameTextField];
    _emailTextField.frame = CGRectMake(4.5, _confirmPWDTextField.frame.origin.y+_confirmPWDTextField.frame.size.height+20, 375-9, 50);
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    emailLabel.text = @"邮箱：";
    _emailTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 70)];
    [_emailTextField.leftView addSubview:emailLabel];
    [self.view addSubview:_emailTextField];
    
    _salerTextField = [self createTextField:_nameTextField];
    _salerTextField.frame = CGRectMake(4.5, _emailTextField.frame.origin.y+_emailTextField.frame.size.height+20, 375-9, 50);
    UILabel *salerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    salerLabel.text = @"业务员ID：";
    _salerTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 70)];
    [_salerTextField.leftView addSubview:salerLabel];
    [self.view addSubview:_salerTextField];
    //
    _confirmRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(35.5, 76+_salerTextField.frame.size.height+_salerTextField
                                                                    .frame.origin.y, 375-71, 50)];
    [_confirmRegisterBtn setBackgroundImage:[UIImage imageNamed:@"确认注册"] forState:UIControlStateNormal];
    [self.view addSubview:_confirmRegisterBtn];
    [_confirmRegisterBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton *)btn{
    if ([self.passwordTextField.text isEqualToString:self.confirmPWDTextField.text]) {
        //生成请求类
        NSString *urlString = [BaseUrl stringByAppendingString:Customer_Register];//请求地址
        NSLog(@"地址：%@",urlString);
        //配置请求参数
        NSDictionary *params = @{
                                 @"LoginName":self.nameTextField.text,
                                 @"Password":self.passwordTextField.text,
                                 @"Email":self.emailTextField.text,
                                 @"SalemanId":self.salerTextField.text
                                 };
        //block发送请求
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                self.info = responseObject[@"data"];
                NSLog(@"注册结果:%@",self.info);
                User *user = [User sigleUser];
                user.userName = self.nameTextField.text;
                user.userPWD = self.passwordTextField.text;
                user.customerId = self.info[0][@"Id"];
                user.SalemenId = self.info[0][@"SalemanId"];
                user.loginStatus = true;
                user.addDate = self.info[0][@"AddDate"];
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:user.userName forKey:@"user"];
                [userDefaults setObject:user.userPWD forKey:@"password"];
                [userDefaults setObject:user.addDate forKey:@"addDate"];
                [userDefaults setObject:user.SalemenId forKey:@"SalemenId"];
                [userDefaults setObject:user.customerId forKey:@"customerId"];
                [userDefaults synchronize];

                
                RegisterSuccessViewController *rsvc = [[RegisterSuccessViewController alloc]init];
                [self.navigationController pushViewController:rsvc animated:YES];
            }else{
                NSLog(@"注册失败");
                NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该账户已被注册" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"err = %@",error);
        }];
        
    }else{
        //
        NSLog(@"两次密码输入不同！");
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"两次密码输入不同" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        

    
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
