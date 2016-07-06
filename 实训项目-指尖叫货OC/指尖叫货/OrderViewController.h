//
//  OrderViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController

@property(nonatomic,strong)NSString *num;


@end
/*
 如果cell中需要给按钮添加按钮，触发事件
 1.tag+本地数据存储
 2.delegeate返回去，让controller处理
 
 
 */