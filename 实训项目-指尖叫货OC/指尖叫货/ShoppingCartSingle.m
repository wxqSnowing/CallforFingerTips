//
//  ShoppingCartSingle.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ShoppingCartSingle.h"

@interface  ShoppingCartSingle()

@property(nonatomic,strong)NSMutableArray *allProductsArray;//存储商品的数组
@property(nonatomic,strong)UIImageView *shoppingIV;

@end

static ShoppingCartSingle  *shoppingView=nil;

@implementation ShoppingCartSingle


+(ShoppingCartSingle *)sharedShoppingCart{
    if (shoppingView==nil) {
        
        shoppingView=[[ShoppingCartSingle alloc] initWithFrame:CGRectMake(10, 580, 60, 60)];
        shoppingView.layer.cornerRadius=30;
        shoppingView.layer.masksToBounds=YES;
        shoppingView.backgroundColor=[UIColor colorWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        shoppingView.shoppingIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        shoppingView.shoppingIV.image=[UIImage imageNamed:@"购物车@2x"];
        
        shoppingView.priceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        shoppingView.shoppingIV.userInteractionEnabled=YES;
        [shoppingView addSubview:shoppingView.shoppingIV];
        [shoppingView addSubview:shoppingView.priceBtn];
    }
    
    return shoppingView;
}

+(void)addProductArray:(Product *)product{
    BOOL isHave=NO;
    
    if (!shoppingView.allProductsArray) {
        shoppingView.allProductsArray=[NSMutableArray array];
    }
    
    for (int i=0; i<shoppingView.allProductsArray.count; i++) {
        Product *one = shoppingView.allProductsArray[i];
        if ([one.goodsCode isEqualToString:product.goodsCode]) {
            isHave = YES;
            shoppingView.allProductsArray[i] = product;
            break;
        }
    }
    if (isHave==NO) {
        //添加购买
        [shoppingView.allProductsArray addObject:product];

    }
   shoppingView.shoppingIV.hidden=YES;
    CGFloat moneySum=0;
    for (Product *aOne in shoppingView.allProductsArray) {
        moneySum += [aOne.clickNumber integerValue] * [aOne.discountPrice floatValue];
    }
    [shoppingView.priceBtn setTitle:[NSString stringWithFormat:@"%.2lf",moneySum] forState:UIControlStateNormal];
    
    //存取数据到本地
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSData *mydata = [NSKeyedArchiver archivedDataWithRootObject:shoppingView.allProductsArray ];
    [udf setObject:mydata forKey:@"SnowLocalShoppingCart5"];
    [udf synchronize];
    
}

+(void)reduceProductArray:(Product *)product{
    
    if (!shoppingView.allProductsArray) {
        shoppingView.allProductsArray=[NSMutableArray array];
    }
    
    if ([product.clickNumber isEqualToString:@"0"]) {
        //删除元素
        NSMutableArray *deA= [NSMutableArray array];
        for (int i=0; i<shoppingView.allProductsArray.count; i++) {
            Product *one = shoppingView.allProductsArray[i];
            if (one.goodsCode==product.goodsCode) {
                [deA addObject:one];
            }
        }
        [shoppingView.allProductsArray removeObjectsInArray:deA];
        //从购物车中删除购买量魏0的元素
        NSLog(@"从购物车中删除购买量魏0的元素");
        
    }else{
        
        for (int i=0; i<shoppingView.allProductsArray.count; i++) {
            Product *one = shoppingView.allProductsArray[i];
            if ([one.goodsCode isEqualToString:product.goodsCode]) {
                shoppingView.allProductsArray[i] = product;
                break;
            }
        }
    }
    
//修改显示数据
    if (shoppingView.allProductsArray.count==0) {
        shoppingView.shoppingIV.hidden=NO;
        shoppingView.priceBtn.alpha = 1;
        [shoppingView.priceBtn setTitle:[NSString stringWithFormat:@" "] forState:UIControlStateNormal];
    }else{
        shoppingView.shoppingIV.hidden=YES;
        
        CGFloat moneySum=0;
        for (Product *aOne in shoppingView.allProductsArray) {
            moneySum += [aOne.clickNumber integerValue] * [aOne.discountPrice floatValue];
        }
        [shoppingView.priceBtn setTitle:[NSString stringWithFormat:@"%.2lf",moneySum] forState:UIControlStateNormal];
        if (moneySum == 0) {
            shoppingView.shoppingIV.hidden=YES;
        }

    }
    
    //存取数据到本地
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSData *mydata = [NSKeyedArchiver archivedDataWithRootObject:shoppingView.allProductsArray ];
    [udf setObject:mydata forKey:@"SnowLocalShoppingCart5"];
    [udf synchronize];
}

+(NSMutableArray *)getShoppingArray{
    if (!shoppingView.allProductsArray) {
        shoppingView.allProductsArray=[NSMutableArray array];
    }
    return shoppingView.allProductsArray;
}

+(void)setShoppingArray:(NSArray *)arr{
    
    if (![ShoppingCartSingle sharedShoppingCart].allProductsArray) {
        shoppingView.allProductsArray=[NSMutableArray array];
    }

    for (Product *one in arr) {
        [shoppingView.allProductsArray addObject:one];
    }
    
    if (shoppingView.allProductsArray.count!=0) {
        shoppingView.shoppingIV.hidden=YES;
        shoppingView.priceBtn.alpha = 1;
        CGFloat moneySum=0;
        for (Product *aOne in shoppingView.allProductsArray) {
            moneySum += [aOne.clickNumber integerValue] * [aOne.discountPrice floatValue];
        }
        [shoppingView.priceBtn setTitle:[NSString stringWithFormat:@"%.2lf",moneySum] forState:UIControlStateNormal];
    }
}

@end
