//
//  User.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/25.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userPWD;
@property(nonatomic,assign)BOOL loginStatus;
@property(nonatomic,strong)NSString *customerId;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *SalemenId;


+(User *)sigleUser;

@end
