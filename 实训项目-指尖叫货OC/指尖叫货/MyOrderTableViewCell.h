//
//  MyOrderTableViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/27.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Product;
@interface MyOrderTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *orderNumberberlabel;
@property(nonatomic,strong)UILabel *moneylabel;
@property(nonatomic,strong)UILabel *numberberlabel;
@property(nonatomic,strong)UILabel *datelabel;

@property(nonatomic,strong)NSDictionary *orderDict;

@end
