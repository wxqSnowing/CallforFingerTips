//
//  RootViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/21.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendCollectionViewCell;

@interface RootViewController : UIViewController

- (void)addPackage:(RecommendCollectionViewCell *)cell;
- (void)subPackage:(RecommendCollectionViewCell *)cell;


@end
