//
//  ShoppingCartViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/26.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartTableViewCell;
@class User;
@interface ShoppingCartViewController : UIViewController


- (void)addPackage:(ShoppingCartTableViewCell *)cell;
- (void)reducePackage:(ShoppingCartTableViewCell *)cell;

@end
