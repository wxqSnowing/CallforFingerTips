//
//  ClassifyTableViewCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductCatogoryChild;
@interface ClassifyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *totallabel;

@property(nonatomic,strong)ProductCatogoryChild *child;
@end
