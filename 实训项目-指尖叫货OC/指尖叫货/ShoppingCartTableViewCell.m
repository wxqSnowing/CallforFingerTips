//
//  ShoppingCartTableViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartViewController.h"

@implementation ShoppingCartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadContactViews];
    return self;
}

-(void)add:(UIButton *)sender{
    [self.delegate addPackage:self];
    
}

-(void)reduce:(UIButton *)sender{
    [self.delegate reducePackage:self];
}

-(void)loadContactViews{
    //商品图片
    _headImage=[[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 80, 80)];
    //_headImage.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:_headImage];
    
    //名称
    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(114, 10,250, 25)];
    _nameLabel.textAlignment=NSTextAlignmentLeft;
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.text=@"名称";
    [self.contentView addSubview:_nameLabel];
    
    //原价格
    _oldPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(114,45,60,25)];
    _oldPriceLabel.textAlignment=NSTextAlignmentLeft;
    _oldPriceLabel.font=[UIFont systemFontOfSize:16];
    _oldPriceLabel.text=@"€500";
    _separateIV= [[UIImageView alloc]initWithFrame:CGRectMake(114, 55, 40, 2)];
    _separateIV.image=[UIImage imageNamed:@"欧元分割线@2x.png"];
    [self.contentView addSubview:_separateIV];
    [self.contentView addSubview:_oldPriceLabel];
    
    //打折后价格
    _nowPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(_oldPriceLabel.frame.origin.x+60+20,_oldPriceLabel.frame.origin.y,60,25)];
    _nowPriceLabel.textAlignment=NSTextAlignmentLeft;
    _nowPriceLabel.font=[UIFont systemFontOfSize:16];
    _nowPriceLabel.textColor=[UIColor redColor];
    _nowPriceLabel.text=@"€500";
    [self.contentView addSubview:_nowPriceLabel];
    
    //包装数量
    _numbersLabel=[[UILabel alloc] initWithFrame:CGRectMake(_nowPriceLabel.frame.origin.x+60+20,_oldPriceLabel.frame.origin.y,60,25)];
    _numbersLabel.textAlignment=NSTextAlignmentLeft;
    _numbersLabel.font=[UIFont systemFontOfSize:16];
    _numbersLabel.text=@"20";
    [self.contentView addSubview:_numbersLabel];
    
    //购买数量
    _buyNumbersLabel=[[UILabel alloc] initWithFrame:CGRectMake(_oldPriceLabel.frame.origin.x,75,150,25)];
    _buyNumbersLabel.textAlignment=NSTextAlignmentLeft;
    _buyNumbersLabel.font=[UIFont systemFontOfSize:16];
    _buyNumbersLabel.text=@"1";
    [self.contentView addSubview:_buyNumbersLabel];
    
    //增加数量
    _addBtn=[[UIButton alloc]initWithFrame:CGRectMake(375-10-26,_buyNumbersLabel.frame.origin.y-5 , 28, 28)];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"车_加号.png"] forState:UIControlStateNormal];
    _addBtn.tag=100;
    [self.addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    
    //减少数量
    _subtractBtn=[[UIButton alloc]initWithFrame:CGRectMake(_addBtn.frame.origin.x-66,_addBtn.frame.origin.y, 28, 28)];
    [_subtractBtn setBackgroundImage:[UIImage imageNamed:@"车_减号.png"] forState:UIControlStateNormal];
    _subtractBtn.tag=101;
    
    [self.subtractBtn addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_subtractBtn];
    
    UIImageView *imaView1= [[UIImageView alloc]initWithFrame:CGRectMake(0,103,375, 2)];
    imaView1.image=[UIImage imageNamed:@"分割线.png"];
    [self.contentView addSubview:imaView1];
}

-(void)setProduct:(Product *)product{
    _product = product;
    if (_product) {
        NSString *str=[NSString stringWithString:_product.imageUrl];
        NSURL *url=[NSURL URLWithString:str];
        [_headImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
        
        _nameLabel.text=_product.title;
        NSLog(@"%@",self.product.title);
        
        _oldPriceLabel.text=[NSString stringWithFormat:@"€%@",_product.price];
        _nowPriceLabel.text=[NSString stringWithFormat:@"€%@",_product.discountPrice];
        if ([_oldPriceLabel.text isEqualToString:_nowPriceLabel.text]) {
            _nowPriceLabel.hidden=YES;
            _separateIV.hidden=YES;
        }else{
            _nowPriceLabel.hidden=NO;
            _separateIV.hidden=NO;
        }
        
        _numbersLabel.text=[NSString stringWithFormat:@"%@",_product.package];
        _buyNumbersLabel.text=[@"购买数量："stringByAppendingString:_product.clickNumber];
        
    }

}

@end
