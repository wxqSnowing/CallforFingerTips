//
//  SliderPic.m
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 team. All rights reserved.
//

#import "SliderPic.h"

@implementation SliderPic
+(instancetype)sliderWithDictionary:(NSDictionary *)sliderPicInfo{
    SliderPic *sliderPic = [[SliderPic alloc]init];
    sliderPic.picId = [NSString stringWithFormat:@"%@", sliderPicInfo[@"Id"]];
    sliderPic.imageUrl = sliderPicInfo[@"ImageUrl"];
    sliderPic.linkUrl = sliderPicInfo[@"LinkUrl"];
    return sliderPic;
}

- (NSString *)imageUrl
{
    if (_imageUrl) {
        return [NSString stringWithFormat:@"%@%@",BaseUrl,_imageUrl];
    }
    return nil;
}

@end
