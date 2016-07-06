//
//  LoginViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface LoginViewController : UIViewController
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)User *user;

@end
