//
//  OrderDetailTableViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/28.
//  Copyright © 2016年 team. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContactViews];
    return self;
}

-(void)setGoodDict:(NSDictionary *)goodDict{
    _goodDict = goodDict;
    if (!_goodDict) {
        _goodDict = [NSDictionary dictionary];
    }
//    self.orderNumberberlabel.text = [NSString stringWithFormat:@"订单号：%@",orderDict[@"OrderId"]];
//    self.moneylabel.text = [NSString stringWithFormat:@"€%@",orderDict[@"Amount"]];
//    self.datelabel.text = [NSString stringWithFormat:@"%@",[orderDict[@"AddDate"] substringToIndex:10]];
//    self.numberberlabel.text = [NSString stringWithFormat:@"%@",orderDict[@""]];
    self.titlelabel.text = goodDict[@"Title"];
    self.numberberlabel.text = [NSString stringWithFormat:@"%@",goodDict[@"Package"]];
    self.moneylabel.text = [NSString stringWithFormat:@"€%@",goodDict[@"DiscountPrice"]];

}


-(void)loadContactViews{
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
//    _headImage.backgroundColor = [UIColor redColor];
    _headImage.image = [UIImage imageNamed:@"defaultIcon.png"];
    [self.contentView addSubview:_headImage];
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 250, 30)];
    _titlelabel.text=@"34895549";
    _titlelabel.textColor = [UIColor blackColor];
    _titlelabel.textAlignment = NSTextAlignmentLeft;
//    _titlelabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_titlelabel];
    
    _moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(290, 60, 60, 30)];
    _moneylabel.text=@"500";
    _moneylabel.textColor = [UIColor redColor];
    _moneylabel.textAlignment = NSTextAlignmentRight;
    //    _moneylabel.font = [UIFont boldSystemFontOfSize:18];
    //    _moneylabel.backgroundColor = [UIColor blueColor];
//    _moneylabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_moneylabel];
    
    _numberberlabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 100, 30)];
    _numberberlabel.text=@"X20";
    _numberberlabel.textColor = [UIColor blackColor];
    _numberberlabel.textAlignment = NSTextAlignmentLeft;
    //    _numberberlabel.font = [UIFont boldSystemFontOfSize:18];
    //    _numberberlabel.backgroundColor = [UIColor greenColor];
//    _numberberlabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_numberberlabel];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
