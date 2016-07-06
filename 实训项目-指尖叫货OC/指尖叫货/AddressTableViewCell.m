//
//  AddressTableViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/27.
//  Copyright © 2016年 team. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressManageViewController.h"

@implementation AddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContactViews];
    return self;
}

-(void)setAddressDict:(NSDictionary *)addressDict{
    _addressDict = addressDict;
    if (!_addressDict) {
        _addressDict = [NSDictionary dictionary];
    }
    self.nameLabel.text = addressDict[@"Name"];
    self.phoneLabel.text = addressDict[@"Mobile"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",addressDict[@"ProvinceName"],addressDict[@"AddressDetail"]];
    self.addressLabel.text = str;
    
}


-(void)loadContactViews{
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 30)];
    name.text = @"姓名:";
    name.textColor = [UIColor blackColor];
    [self.contentView addSubview:name];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 50, 30)];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.text = @"wxq";
    [self.contentView addSubview:self.nameLabel];
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(180, 10, 90, 30)];
    phone.text = @"电话号码:";
    phone.textColor = [UIColor blackColor];
    [self.contentView addSubview:phone];
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 10, 120, 30)];
    self.phoneLabel.textColor = [UIColor lightGrayColor];
    self.phoneLabel.text = @"18982641698";
    [self.contentView addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 375, 50)];
    self.addressLabel.text = @"QWEDDSAXXXXXXXXXXXX";
    self.addressLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.addressLabel];

    self.updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(280, 85, 80, 40)];
    [self.updateBtn setBackgroundImage:[UIImage imageNamed:@"修改@2x.png"] forState:UIControlStateNormal];
    [self.updateBtn addTarget:self action:@selector(updateAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.updateBtn];
    
}

-(void)updateAddress{
    NSLog(@"修改");
    [self.delegate updateAddress:self];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
