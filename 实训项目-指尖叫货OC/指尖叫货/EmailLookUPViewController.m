//
//  EmailLookUPViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import "EmailLookUPViewController.h"
#import "LookUPPWDViewController.h"
#import "MineViewController.h"

@interface EmailLookUPViewController ()
@property(nonatomic,strong)UIButton *updatePWDBtn;
@property(nonatomic,strong)UIImageView *emailImage;
@property(nonatomic,strong)UILabel *label;
@end

@implementation EmailLookUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _emailImage = [[UIImageView alloc]initWithFrame:CGRectMake(130, 64+25, 121*0.96, 88*0.96)];
    _emailImage.image = [UIImage imageNamed:@"信"];
    [self.view addSubview:_emailImage];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, _emailImage.frame.origin.y+_emailImage.frame.size.height+20, 335, 50)];
    _label.text = @"找回密码邮件已发送至你的邮箱";
    [self.view addSubview:_label];
    
    _updatePWDBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _label.frame.origin.y+_label.frame.size.height+40, 335, 50)];
    [_updatePWDBtn setBackgroundImage:[UIImage imageNamed:@"修改密码"] forState:UIControlStateNormal];
    [_updatePWDBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_updatePWDBtn];
    
}
-(void)click:(UIButton *)btn{
    MineViewController* myVC = [[MineViewController alloc]init];
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
