//
//  Notice.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import "Notice.h"

@implementation Notice

+(instancetype)noticeWithDictionary:(NSDictionary *)noticeInfo{
    Notice *notice = [[Notice alloc]init];
    notice.content = noticeInfo[@"Content"];
    notice.noticeId = noticeInfo[@"Id"];
    notice.title = noticeInfo[@"Title"];
    return notice;
}

@end
