//
//  SearchCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 team. All rights reserved.
//

#import "SearchCell.h"
#import "UIImageView+AFNetworking.h"

@implementation SearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContentViews];
    return self;
}

-(void)loadContentViews
{
    _productImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 75, 70)];
    [self.contentView addSubview:_productImage];
    
    _productName=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 260, 20)];
    _productName.textAlignment=NSTextAlignmentLeft;
    _productName.textColor=[UIColor blackColor];
    _productName.font=[UIFont systemFontOfSize:20];
    [self.contentView addSubview:_productName];
    
    _price=[[UILabel alloc]initWithFrame:CGRectMake(100, 60, 50, 20)];
    _price.textAlignment=NSTextAlignmentLeft;
    _price.textColor=[UIColor blackColor];
    _price.font=[UIFont systemFontOfSize:20];
    [self.contentView addSubview:_price];
    
    _package=[[UILabel alloc]initWithFrame:CGRectMake(260, 60, 20, 15)];
    _package.textAlignment=NSTextAlignmentLeft;
    _package.textColor=[UIColor blackColor];
    _package.font=[UIFont systemFontOfSize:20];
    [self.contentView addSubview:_package];
}

-(void)setSearchDic:(NSMutableDictionary *)searchDic
{
    _searchDic=searchDic;
    if (_searchDic) {
        NSString *urlString=[BaseUrl stringByAppendingString:_searchDic[@"ImageUrl"]];
        NSURL *imageUrl=[NSURL URLWithString:urlString];
        [_productImage setImageWithURL:imageUrl];
        if (_productImage.image==nil || _productImage==NULL) {
            _productImage.image=[UIImage imageNamed:@"defaultIcon.png"];
        }
        _productName.text=_searchDic[@"Title"];
        
        NSString *text=[NSString stringWithFormat:@"%@",_searchDic[@"Price"]];
        _price.text= text;
        
        _package.text=[NSString stringWithFormat:@"%@",_searchDic[@"Package"]];
        
    }
}
/*
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
@end
