//
//  UpdateViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()<UITextFieldDelegate>

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]}];
    
    [self addUpdatePWDView];
}

-(UITextField *)createTextField:(UITextField *)textField{
    textField =  [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];//文字颜色
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.layer.cornerRadius = 5;
    [textField setFont:[UIFont systemFontOfSize:20]];
    textField.layer.masksToBounds = YES;
    return textField;
}


-(void)addUpdatePWDView{
    UILabel *oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+15+10, 90, 40)];
    oldLabel.text = @"旧密码：    ";
    [self.view addSubview:oldLabel];
    
    _oldPWDTextField = [self createTextField:_oldPWDTextField];
    _oldPWDTextField.frame = CGRectMake(oldLabel.frame.origin.x+oldLabel.frame.size.width+13, oldLabel.frame.origin.y, 375-50-80, 40);
    [self.view addSubview:_oldPWDTextField];
    
    UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+_oldPWDTextField.frame.origin.y, 90, 40)];
    newLabel.text = @"新密码：    ";
    [self.view addSubview:newLabel];
    
    _freshPWDTextField = [self createTextField:_freshPWDTextField];
    _freshPWDTextField.frame = CGRectMake(newLabel.frame.origin.x+newLabel.frame.size.width+13, 64+_oldPWDTextField.frame.origin.y, 375-50-80, 40);
    [self.view addSubview:_freshPWDTextField];
    
    UILabel *confirmNewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+_freshPWDTextField.frame.origin.y, 90, 40)];
    confirmNewLabel.text = @"确认密码：";
    [self.view addSubview:confirmNewLabel];
    
    _conFirmFreshPWDTextField = [self createTextField:_conFirmFreshPWDTextField];
    _conFirmFreshPWDTextField.frame = CGRectMake(confirmNewLabel.frame.origin.x+confirmNewLabel.frame.size.width+13, 64+_freshPWDTextField.frame.origin.y, 375-50-80, 40);
    [self.view addSubview:_conFirmFreshPWDTextField];
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _conFirmFreshPWDTextField.frame.origin.y+_conFirmFreshPWDTextField.frame.size.height+112, 375-40, 50)];
    [okBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    okBtn.layer.cornerRadius = 5;
    okBtn.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0  blue:251/255.0  alpha:1];
    [self.view addSubview:okBtn];
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
