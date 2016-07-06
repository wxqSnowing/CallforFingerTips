//
//  ProductCatogoryChild.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import "ProductCatogoryChild.h"

@implementation ProductCatogoryChild

+(instancetype)productCatogoryChildWithDictionary:(NSDictionary *)childInfo{
    ProductCatogoryChild *pCChild = [[ProductCatogoryChild alloc]init];
    pCChild.imageUrl = childInfo[@"ImageUrl"];
    pCChild.title = childInfo[@"Title"];
    pCChild.total =[NSString stringWithFormat:@"%@",childInfo[@"Total"]];
    return pCChild;
}

- (NSString *)imageUrl
{
    if (_imageUrl) {
        return [NSString stringWithFormat:@"http://zj.rimiedu.com%@",_imageUrl];
    }
    return nil;
}

@end
