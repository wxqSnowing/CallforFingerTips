//
//  LookUPPWDViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "LookUPPWDViewController.h"
#import "UpdateViewController.h"
#import "MineViewController.h"
#import "EmailLookUPViewController.h"

@interface LookUPPWDViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *emailTextField;
@property(nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic, strong) NSArray *info;
@end

@implementation LookUPPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"找回密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]}];
    
    _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(19, 64+24, 337, 45)];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.textColor = [UIColor blackColor];//文字颜色
    _emailTextField.delegate = self;
    _emailTextField.layer.cornerRadius = 5;
    _emailTextField.placeholder = @"请输入邮箱";
    _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_emailTextField];
    
    _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(_emailTextField.frame.origin.x+_emailTextField.frame.size.width-90, _emailTextField.frame.origin.y+_emailTextField.frame.size.height+25, 90, 45)];
    _confirmBtn.layer.cornerRadius = 5;
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = [UIColor colorWithRed:56/255.0 green:189/255.0  blue:252/255.0  alpha:1];
    [_confirmBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
}

-(void)click:(UIButton *)btn{
    NSString *urlString = [BaseUrl stringByAppendingString:Customer_ResetPassword];//请求地址
    NSLog(@"地址：%@",urlString);
    
    if ([self isValidateEmail:self.emailTextField.text]) {
        //配置请求参数
        NSDictionary *params = @{
                                 @"email":self.emailTextField.text
                                 };
        //block发送请求
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"QQQQQQ%@",responseObject);
            
            if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                self.info = responseObject[@"data"];
                NSLog(@"搜索邮箱结果:%@",self.info);
                
                EmailLookUPViewController * myVC = [[EmailLookUPViewController alloc]init];
                [self.navigationController pushViewController:myVC animated:NO];
                //返回我的
            }else{
                NSLog(@"这个邮箱帐号没有被注册");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"err = %@",error);
        }];
        
    }else{
        NSLog(@"请输入合法的邮箱地址");
    
    
    
    }
}

-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
