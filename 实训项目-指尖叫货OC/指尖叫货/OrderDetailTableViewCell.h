//
//  OrderDetailTableViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/28.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *moneylabel;
@property(nonatomic,strong)UILabel *numberberlabel;

@property(nonatomic,strong)NSDictionary *goodDict;


@end
