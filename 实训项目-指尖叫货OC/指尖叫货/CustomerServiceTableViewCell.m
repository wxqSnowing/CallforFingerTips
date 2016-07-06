//
//  CustomerServiceTableViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/25.
//  Copyright © 2016年 team. All rights reserved.
//

#import "CustomerServiceTableViewCell.h"

@implementation CustomerServiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContactViews];
    return self;
}


-(void)setMainInfo:(NSDictionary *)mainInfo{
    _mainInfo = mainInfo;
    if (_mainInfo) {
        NSMutableString *str = [NSMutableString string];
        [str appendString:@"客服电话"];
        [str appendString:[NSString stringWithFormat:@"%@",mainInfo[@"Id"]]];
        _titlelabel.text = str;
        _phoneNumberlabel.text = mainInfo[@"PhoneNumber"];
    }
}


-(void)loadContactViews{
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 50)];
    _titlelabel.text=@"wxq";
    _titlelabel.textColor = [UIColor blackColor];
    _titlelabel.textAlignment = NSTextAlignmentLeft;
//    _titlelabel.font = [UIFont boldSystemFontOfSize:18];
//    _titlelabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_titlelabel];
    

    _phoneNumberlabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 10,160, 50)];
    _phoneNumberlabel.text=@"189";
    _phoneNumberlabel.textColor = [UIColor blackColor];
    _phoneNumberlabel.textAlignment = NSTextAlignmentLeft;
//    _phoneNumberlabel.font = [UIFont boldSystemFontOfSize:18];
//    _phoneNumberlabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_phoneNumberlabel];
    
    
    
    _callImage = [[UIImageView alloc]initWithFrame:CGRectMake(320, 10, 49,49)];
    _callImage.image = [UIImage imageNamed:@"iconfont-dianhua-(1)@2x.png"];
//    _callImage.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_callImage];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
