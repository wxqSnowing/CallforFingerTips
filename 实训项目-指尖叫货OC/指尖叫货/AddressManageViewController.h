//
//  AddressManageViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressTableViewCell;

@interface AddressManageViewController : UIViewController

@property(nonatomic,strong)User *user;

-(void)updateAddress:(AddressTableViewCell *)cell;

@end
