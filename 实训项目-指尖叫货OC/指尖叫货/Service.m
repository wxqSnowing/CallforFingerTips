//
//  Service.m
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 team. All rights reserved.
//

#import "Service.h"
#import "AFNetworking.h"

@implementation Service

+ (void)sericeWithMothed:(NSString *)mothed params:(NSDictionary *)params succeed:(void (^)(id response))succeedBlock fail:(void (^)(id error))failBlock
{
    NSString *urlString = [BaseUrl stringByAppendingString:mothed];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"responce:%@",responseObject);
        succeedBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        NSLog(@"err = %@",error);
    }];
    
}

@end
