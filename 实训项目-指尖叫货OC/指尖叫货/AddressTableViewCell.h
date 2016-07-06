//
//  AddressTableViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/27.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressManageViewController;

@interface AddressTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIButton *updateBtn;

@property(nonatomic,strong)NSDictionary *addressDict;

@property(nonatomic,strong)AddressManageViewController *delegate;

@end
