//
//  CDPImageCollectionViewCell.m
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CDPImageCollectionViewCell{
    UIImageView *_imageView;

}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
        _label = label1;
        _label.backgroundColor = [UIColor whiteColor];
        [self addSubview:_label];
        _label.text = self.imageViewUrl;
    }
    
    return self;
}

@end
