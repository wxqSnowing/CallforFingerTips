//
//  DiscountCollectionViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscountViewController;

@interface DiscountCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)Product *product;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UIButton *addBtn;
@property(strong,nonatomic) UIButton *subBtn;
@property(strong,nonatomic) UILabel *descLabel;
@property(strong,nonatomic) UILabel *moneyLabel;
@property(strong,nonatomic) UILabel *numLabel;
@property(strong,nonatomic)UILabel *discountLabel;
@property(strong,nonatomic) UILabel *clickNumberLabel;

@property (weak, nonatomic) DiscountViewController *delegate;


@end
