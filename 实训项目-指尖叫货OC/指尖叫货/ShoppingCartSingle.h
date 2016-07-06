//
//  ShoppingCartSingle.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartSingle : UIView
@property(nonatomic,strong)UIButton *priceBtn;

+(void)addProductArray:(Product *)product;
+(void)reduceProductArray:(Product *)product;
+(ShoppingCartSingle *)sharedShoppingCart;
+(NSMutableArray *)getShoppingArray;
+(void)setShoppingArray:(NSArray *)arr;
@end
