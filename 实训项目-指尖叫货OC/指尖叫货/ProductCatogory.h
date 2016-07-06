//
//  ProductCatogory.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductCatogoryChild;

@interface ProductCatogory : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSMutableArray *children;

+(instancetype)productCatogoryWithDictionary:(NSDictionary *)productCatogoryInfo;

@end
