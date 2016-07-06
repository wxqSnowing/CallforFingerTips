//
//  SearchCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property(nonatomic,strong)UIImageView *productImage;
@property(nonatomic,strong)UILabel *productName;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *package;
@property(nonatomic,strong)NSMutableDictionary *searchDic;

@end
