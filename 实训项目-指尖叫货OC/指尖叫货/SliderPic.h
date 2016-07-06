//
//  SliderPic.h
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderPic : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *picId;

+(instancetype)sliderWithDictionary:(NSDictionary *)sliderPicInfo;
@end
