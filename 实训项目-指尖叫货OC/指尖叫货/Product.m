//
//  Product.m
//  UIClass11_网络请求
//
//  Created by wangzheng on 16/6/19.
//  Copyright © 2016年 wangzheng. All rights reserved.
//

#import "Product.h"
@implementation Product

+ (instancetype)productWithDictionary:(NSDictionary *)proInfo
{
    Product *pro = [[Product alloc]init];
    pro.barcode = proInfo[@"Barcode"];//依次赋值每个字段
    pro.categoryTitle = proInfo[@"CategoryTitle"];
    pro.discount = [NSString stringWithFormat:@"%@",proInfo[@"Discount"]];
    pro.discountPrice = [NSString stringWithFormat:@"%@",proInfo[@"DiscountPrice"]];
    pro.goodsCode = proInfo[@"GoodsCode"];
//    pro.imageUrl = proInfo[@"ImageUrl"];
    
    pro.imageUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,proInfo[@"ImageUrl"]];
    pro.remark = proInfo[@"Remark"];
    pro.package = [NSString stringWithFormat:@"%@",proInfo[@"Package"]];
    pro.price = [NSString stringWithFormat:@"%@",proInfo[@"Price"]];
    pro.reserve = [NSString stringWithFormat:@"%@",proInfo[@"Reserve"]];
    pro.title = proInfo[@"Title"];
    pro.clickNumber = proInfo[@"ClickNumber"];
    return pro;
}

- (NSString *)imageUrl
{
    if (_imageUrl) {
//        return [NSString stringWithFormat:@"http://zj.rimiedu.com%@",_imageUrl];
        return _imageUrl;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.barcode forKey:@"barcode"];
    [aCoder encodeObject:self.categoryTitle forKey:@"categoryTitle"];
    [aCoder encodeObject:self.discount forKey:@"discount"];
    [aCoder encodeObject:self.discountPrice forKey:@"discountPrice"];
    [aCoder encodeObject:self.goodsCode forKey:@"goodsCode"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.package forKey:@"package"];
    [aCoder encodeObject:self.pictureList forKey:@"pictureList"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.reserve forKey:@"reserve"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.clickNumber forKey:@"clickNumber"];
    
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.barcode = [aDecoder decodeObjectForKey:@"barcode"];
        self.categoryTitle= [aDecoder decodeObjectForKey:@"categoryTitle"];
        self.discount= [aDecoder decodeObjectForKey:@"discount"];
        self.discountPrice= [aDecoder decodeObjectForKey:@"discountPrice"];
        self.goodsCode= [aDecoder decodeObjectForKey:@"goodsCode"];
        self.imageUrl= [aDecoder decodeObjectForKey:@"imageUrl"];
        self.package= [aDecoder decodeObjectForKey:@"package"];
        self.pictureList= [aDecoder decodeObjectForKey:@"pictureList"];
        self.price= [aDecoder decodeObjectForKey:@"price"];
        self.remark= [aDecoder decodeObjectForKey:@"remark"];
        self.reserve= [aDecoder decodeObjectForKey:@"reserve"];
        self.title= [aDecoder decodeObjectForKey:@"title"];
        self.clickNumber= [aDecoder decodeObjectForKey:@"clickNumber"];
    }
    return self;
}

@end
