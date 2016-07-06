//
//  CatogoryDetailViewController.h
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassifyCollectionViewCell;
@class ProductCatogory;
@interface CatogoryDetailViewController : UIViewController
@property(nonatomic,strong)ProductCatogory *pc;


- (void)addPackage:(ClassifyCollectionViewCell *)cell;
- (void)subPackage:(ClassifyCollectionViewCell *)cell;

@end
