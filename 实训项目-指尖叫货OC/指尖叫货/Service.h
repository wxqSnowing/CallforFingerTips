//
//  Service.h
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

+ (void)sericeWithMothed:(NSString *)mothed params:(NSDictionary *)params succeed:(void (^)(id response))succeedBlock fail:(void (^)(id error))failBlock;

@end
