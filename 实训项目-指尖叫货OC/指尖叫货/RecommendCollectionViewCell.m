//
//  RecommendCollectionViewCell.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import "RecommendCollectionViewCell.h"
#import "RootViewController.h"

@implementation RecommendCollectionViewCell

-(void)setProduct:(Product *)product{
    _product = product;
    if (_product) {
        NSURL *url = [[NSURL alloc]initWithString:product.imageUrl];
        [_imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultIcon.png"]];
        _descLabel.text = product.title;
        NSMutableString *price = [NSMutableString string];
        [price appendString:@"€"];
        [price appendString:product.price];
        _moneyLabel.text = price;
        _numLabel.text = product.package;
        
        if ([_product.clickNumber integerValue]>0) {
            _clickNumberLabel.hidden = NO;
        }else {
            _clickNumberLabel.hidden = YES;
        }
        _clickNumberLabel.text = _product.clickNumber;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    //商品分类_减@2x.png  102*62
    //    商品分类_加@2x.png
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (UISCREE_WIDTH - 80) / 2, (UISCREE_WIDTH - 80) / 2)];
        self.imageView.image = [UIImage imageNamed:@"defaultIcon.png"];
        [self.imageView setUserInteractionEnabled:true];
        [self addSubview:self.imageView];
        
        CGFloat subX = 0;
        CGFloat subY = UISCREE_WIDTH/4+20;
        self.subBtn = [[UIButton alloc]initWithFrame:CGRectMake(subX, subY, 30*102/62, 30)];
        [self.subBtn setBackgroundImage:[UIImage imageNamed:@"商品分类_减@2x.png"] forState:UIControlStateNormal];
        self.subBtn.tag = 501;
        [self.subBtn addTarget:self action:@selector(subClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.subBtn];
        
        CGFloat addX = UISCREE_WIDTH/4.0;
        CGFloat addY = UISCREE_WIDTH/4+20;
        self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(addX, addY, 30*102/62, 30)];
        [self.addBtn setBackgroundImage:[UIImage imageNamed:@"商品分类_加@2x.png"] forState:UIControlStateNormal];
        self.addBtn.tag = 502;
        [self.addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addBtn];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (UISCREE_WIDTH - 80) / 2+10, (UISCREE_WIDTH - 80) / 2, 20)];
        self.descLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.descLabel];
        
        CGFloat moneyX = 10;
        CGFloat moneyY = self.descLabel.frame.origin.y+self.descLabel.frame.size.height+15;
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, (UISCREE_WIDTH - 80) / 4, 20)];
        self.moneyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.moneyLabel];
        
        CGFloat numX = UISCREE_WIDTH/4.0-10;
        CGFloat numY = self.descLabel.frame.origin.y+self.descLabel.frame.size.height+15;
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numX, numY, (UISCREE_WIDTH - 80) / 4-10, 20)];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.numLabel];
        
        CGFloat clickX = UISCREE_WIDTH/4.0+35;
        CGFloat clickY = 5;
        self.clickNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(clickX, clickY, 20, 20)];
        self.clickNumberLabel.layer.cornerRadius = CGRectGetWidth(self.clickNumberLabel.frame)/2;//取到宽一半
        self.clickNumberLabel.layer.masksToBounds = YES;
        self.clickNumberLabel.backgroundColor = [UIColor redColor];
        self.clickNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.clickNumberLabel.textColor = [UIColor whiteColor];
        [self.clickNumberLabel setFont:[UIFont systemFontOfSize:10]];
        self.clickNumberLabel.text = @"12";
        [self addSubview:self.clickNumberLabel];
        
    }
    return self;
}

-(void)addClick:(UIButton *)btn{
    NSLog(@"加上");
    [self.delegate addPackage:self];//
}

-(void)subClick:(UIButton *)btn{
    NSLog(@"减掉");
    [self.delegate subPackage:self];//
    
}


@end
