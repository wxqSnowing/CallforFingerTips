//
//  Product.h
//  UIClass11_网络请求
//
//  Created by wangzheng on 16/6/19.
//  Copyright © 2016年 wangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

//构造数据模型，使得数据分发和处理更方便

@interface Product : NSObject<NSCoding>

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *categoryTitle;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *discountPrice;
@property (nonatomic, strong) NSString *goodsCode;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *pictureList;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *reserve;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *clickNumber;


+ (instancetype)productWithDictionary:(NSDictionary *)proInfo;
@end
