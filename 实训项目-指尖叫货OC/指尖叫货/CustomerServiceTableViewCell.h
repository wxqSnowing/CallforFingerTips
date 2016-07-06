//
//  CustomerServiceTableViewCell.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/25.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomerServiceTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *phoneNumberlabel;
@property(nonatomic,strong)UIImageView *callImage;

@property(nonatomic,strong)NSDictionary *mainInfo;
@end
