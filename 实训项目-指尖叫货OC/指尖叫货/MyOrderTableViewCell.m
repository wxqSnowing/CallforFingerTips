//
//  MyOrderTableViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/27.
//  Copyright © 2016年 team. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContactViews];
    return self;
}

-(void)setOrderDict:(NSDictionary *)orderDict{
    _orderDict = orderDict;
    if (!_orderDict) {
        _orderDict = [NSDictionary dictionary];
    }
    self.orderNumberberlabel.text = [NSString stringWithFormat:@"订单号：%@",orderDict[@"OrderId"]];
    self.moneylabel.text = [NSString stringWithFormat:@"€%@",orderDict[@"Amount"]];
    self.datelabel.text = [NSString stringWithFormat:@"%@",[orderDict[@"AddDate"] substringToIndex:10]];
    
    NSInteger sum = 0;
    NSArray *arr = self.orderDict[@"GoodsList"];
    for (int i = 0; i<arr.count; i++) {
        NSDictionary *one = arr[i];
        NSInteger num = [one[@"Quantity"] integerValue];
        sum = sum + num;
    }
    self.numberberlabel.text = [NSString stringWithFormat:@"X%ld",(long)sum];

}

-(void)loadContactViews{

    _orderNumberberlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 250, 30)];
    _orderNumberberlabel.text=@"订单号：34895549";
    _orderNumberberlabel.textColor = [UIColor blackColor];
    _orderNumberberlabel.textAlignment = NSTextAlignmentLeft;
//    _orderNumberberlabel.font = [UIFont boldSystemFontOfSize:18];
//    _orderNumberberlabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_orderNumberberlabel];
    
    _moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 0, 100, 30)];
    _moneylabel.text=@"500";
    _moneylabel.textColor = [UIColor redColor];
    _moneylabel.textAlignment = NSTextAlignmentRight;
//    _moneylabel.font = [UIFont boldSystemFontOfSize:18];
//    _moneylabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_moneylabel];

    _datelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 130, 30)];
    _datelabel.text=@"2016-2-22";
    _datelabel.textColor = [UIColor blackColor];
    _datelabel.textAlignment = NSTextAlignmentLeft;
//    _datelabel.font = [UIFont boldSystemFontOfSize:18];
//    _datelabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_datelabel];

    
    _numberberlabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 50, 100, 30)];
    _numberberlabel.text=@"X20";
    _numberberlabel.textColor = [UIColor blackColor];
    _numberberlabel.textAlignment = NSTextAlignmentRight;

    [self.contentView addSubview:_numberberlabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
