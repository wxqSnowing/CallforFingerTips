//
//  Notice.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notice : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *noticeId;
@property (nonatomic, strong) NSString *title;

+(instancetype)noticeWithDictionary:(NSDictionary *)noticeInfo;
@end
