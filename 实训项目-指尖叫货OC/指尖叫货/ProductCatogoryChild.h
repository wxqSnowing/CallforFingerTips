//
//  ProductCatogoryChild.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCatogoryChild : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *total;

+(instancetype)productCatogoryChildWithDictionary:(NSDictionary *)childInfo;

@end
