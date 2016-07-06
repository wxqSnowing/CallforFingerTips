//
//  ShoppingCartTableViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartViewController;

@interface ShoppingCartTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImage;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *oldPriceLabel;
@property(nonatomic,strong) UILabel *nowPriceLabel;
@property(nonatomic,strong) UILabel *numbersLabel;
@property(nonatomic,strong) UILabel *buyNumbersLabel;
@property(nonatomic,strong) UIImageView *separateIV;

@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) UIButton *subtractBtn;

@property(nonatomic,strong) Product *product;//商品信息
@property(nonatomic,strong)ShoppingCartViewController *delegate;

@end
