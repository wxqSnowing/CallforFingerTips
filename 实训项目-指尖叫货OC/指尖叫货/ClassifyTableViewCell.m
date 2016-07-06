//
//  ClassifyTableViewCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ClassifyTableViewCell.h"
#import "ProductCatogoryChild.h"

@implementation ClassifyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadContactViews];
    return self;
}
-(void)setChild:(ProductCatogoryChild *)child{
    _child = child;
    NSLog(@"QQQQQQQ%ld",(long)[child.total integerValue]);
    NSLog(@"传进来的child%@",child.title);
    if (_child) {
        NSURL *url = [[NSURL alloc]initWithString:child.imageUrl];
        NSLog(@"图片地址%@",url);
        [_headImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultIcon.png"]];

        _titlelabel.text = child.title;
        NSLog(@"%@",_titlelabel.text);
        _totallabel.text = child.total;
        NSLog(@"%@",_totallabel.text);
    }

}

-(void)loadContactViews{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREE_WIDTH/4-80, 10, 70,70)];
    _headImage.image = [UIImage imageNamed:@"defaultIcon.png"];
//    _headImage.backgroundColor = [UIColor redColor];
    //-------------------阴影的效果，图片圆形时不能显示阴影---------------------------------------//

    //--------------------------------------END----------------------------------------------------//
    [self.contentView addSubview:_headImage];
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, 90, 28)];
    _titlelabel.text=@"wxq";
    _titlelabel.textColor = [UIColor blackColor];

    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_titlelabel];

    _totallabel = [[UILabel alloc]initWithFrame:CGRectMake(190, 30,60, 24)];
    _totallabel.text=@"189";
    _totallabel.textColor = [UIColor darkGrayColor];

    _totallabel.textAlignment = NSTextAlignmentLeft;
    _totallabel.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:_totallabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}


@end
