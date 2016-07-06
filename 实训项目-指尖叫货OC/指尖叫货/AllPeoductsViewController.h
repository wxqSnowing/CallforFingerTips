//
//  AllPeoductsViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllProCollectionViewCell;
@interface AllPeoductsViewController : UIViewController

- (void)addPackage:(AllProCollectionViewCell *)cell;
- (void)subPackage:(AllProCollectionViewCell *)cell;
@end
