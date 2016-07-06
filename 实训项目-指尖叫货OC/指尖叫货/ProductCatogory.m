//
//  ProductCatogory.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ProductCatogory.h"
#import "ProductCatogoryChild.h"

@implementation ProductCatogory

+(instancetype)productCatogoryWithDictionary:(NSDictionary *)productCatogoryInfo{

    ProductCatogory *pc = [[ProductCatogory alloc]init];
    pc.children = [NSMutableArray array];//初始化
    NSArray *arr = productCatogoryInfo[@"Children"];
    if (arr.count>0) {
        for (int i = 0; i<arr.count; i++) {
            NSDictionary *dic = [NSDictionary dictionary];
            dic = productCatogoryInfo[@"Children"][i];
            ProductCatogoryChild *one = [ProductCatogoryChild productCatogoryChildWithDictionary:dic];
            [pc.children addObject:one];
        }
    }
    pc.title = productCatogoryInfo[@"Title"];
    return pc;
}



@end
