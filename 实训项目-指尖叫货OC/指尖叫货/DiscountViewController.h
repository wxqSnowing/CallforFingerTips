//
//  DiscountViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiscountCollectionViewCell;
@interface DiscountViewController : UIViewController

- (void)addPackage:(DiscountCollectionViewCell *)cell;
- (void)subPackage:(DiscountCollectionViewCell *)cell;

@end
