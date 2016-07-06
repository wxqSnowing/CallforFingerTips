//
//  User.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/25.
//  Copyright © 2016年 team. All rights reserved.
//

#import "User.h"

@implementation User

+(User *)sigleUser{

    static User *stu = nil;
    if (stu == nil) {
        stu = [[User alloc]init];
        stu.loginStatus = false;
    }
    return stu;
    
}

@end
