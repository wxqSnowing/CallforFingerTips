//
//  DetailDiscountViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/24.
//  Copyright © 2016年 team. All rights reserved.
//

#import "DetailDiscountViewController.h"



@interface DetailDiscountViewController ()
@property(nonatomic,strong)UIImageView *imv;//ImageUrl
@property(nonatomic,strong)UILabel *titleLabel;//Title
@property(nonatomic,strong)UILabel *moneyLabel;//Price
@property(nonatomic,strong)UILabel *goodCodeLabel;//GoodsCode//编码
@property(nonatomic,strong)UILabel *barCodelabel;//Barcode//条码
@property(nonatomic,strong)UILabel *discountLabel;//折扣
@property(nonatomic,strong)UILabel *priceLabel;//原价
@property(nonatomic,strong)UILabel *discountPriceLabel;//折后价
@property(nonatomic,strong)UILabel *packageLabel;//Package包装
@property(nonatomic,strong)UILabel *clickNumberLabel;
@property(nonatomic,strong)UILabel *bottomPrice;
@end

@implementation DetailDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];// 设置返回键
    
    [self addDetailProductView];
}

-(void)addDetailProductView{
    
    self.imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 375, 330)];
    NSURL *url = [[NSURL alloc]initWithString:self.product.imageUrl];
    [self.imv setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultIcon.png"]];
    //    self.imv.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.imv];
    
    CGFloat clickX = UISCREE_WIDTH - 50;
    CGFloat clickY = 64+10;
    self.clickNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(clickX, clickY, 40, 40)];
    self.clickNumberLabel.layer.cornerRadius = CGRectGetWidth(self.clickNumberLabel.frame)/2;//取到宽一半
    self.clickNumberLabel.layer.masksToBounds = YES;
    self.clickNumberLabel.backgroundColor = [UIColor redColor];
    self.clickNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.clickNumberLabel.textColor = [UIColor whiteColor];
    [self.clickNumberLabel setFont:[UIFont systemFontOfSize:10]];
    self.clickNumberLabel.text = self.product.clickNumber;
    if ([self.product.clickNumber isEqualToString:@"0"]||self.product.clickNumber==nil) {
        self.clickNumberLabel.alpha = 0;
    }
    [self.view addSubview:self.clickNumberLabel];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+330+20, 350, 30)];
    self.titleLabel.text = self.product.title;
    //    self.titleLabel.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.titleLabel];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+330+50, 50, 30)];
    NSMutableString *priceStr = [NSMutableString string];
    [priceStr appendString:@"€"];
    [priceStr appendString:self.product.price];
    self.priceLabel.text = priceStr;
//    self.priceLabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.priceLabel];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 64+330+65, 48, 2)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];

    
    self.discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 64+330+50, 80, 30)];
    NSMutableString *discountStr = [NSMutableString string];
    [discountStr appendString:@"-"];
    [discountStr appendString:self.product.discount];
    [discountStr appendString:@"%"];
    self.discountLabel.text = discountStr;
    [self.discountLabel setTextColor:[UIColor redColor]];
//    self.discountLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.discountLabel];
    
    self.discountPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 64+330+50, 80, 30)];
    NSMutableString *discountPriceStr = [NSMutableString string];
    [discountPriceStr appendString:@"€"];
    [discountPriceStr appendString:self.product.discountPrice];
    [self.discountPriceLabel setTextColor:[UIColor redColor]];
    self.discountPriceLabel.text = discountPriceStr;
//    self.discountPriceLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.discountPriceLabel];
    
    
    self.goodCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+330+30+50, 350, 30)];
    NSMutableString *goodCodeStr = [NSMutableString string];
    [goodCodeStr appendString:@"编码:"];
    [goodCodeStr appendString:self.product.goodsCode];
    self.goodCodeLabel.text = goodCodeStr;
    //    self.goodCodeLabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.goodCodeLabel];
    
    self.barCodelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+330+30+30+50, 350, 30)];
    NSMutableString *barCodeStr = [NSMutableString string];
    [barCodeStr appendString:@"条码:"];
    [barCodeStr appendString:self.product.barcode];
    self.barCodelabel.text = barCodeStr;
    //    self.barCodelabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.barCodelabel];
    
    
    self.packageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+330+30+30+50+30, 350, 30)];
    NSMutableString *packageStr = [NSMutableString string];
    [packageStr appendString:@"包装:"];
    [packageStr appendString:self.product.package];
    self.packageLabel.text = packageStr;
    //    self.packageLabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.packageLabel];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 667-64, 375, 64)];
    bottomView.backgroundColor = [[UIColor alloc]initWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview:bottomView];
    //add item in bottomView
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 22, 90, 23)];
    bottomLabel.text = @"您已经选购";
    bottomLabel.textColor = [UIColor blackColor];
    [bottomView addSubview:bottomLabel];
    
    self.bottomPrice = [[UILabel alloc]initWithFrame:CGRectMake(110, 22, 70, 23)];
    [self.bottomPrice setTextColor:[UIColor redColor]];
    NSString *str = [NSString stringWithFormat:@"€%.2f",[self.product.discountPrice floatValue]*[self.product.clickNumber integerValue]];
    self.bottomPrice.text = str;
    [bottomView addSubview:self.bottomPrice];
    
    UIButton *increase = [[UIButton alloc]initWithFrame:CGRectMake(190, 13, 70, 35)];
    [increase setBackgroundImage:[UIImage imageNamed:@"详情_加@2x.png"] forState:UIControlStateNormal];
    [increase addTarget:self action:@selector(addPackage) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:increase];
    
    UIButton *decrease = [[UIButton alloc]initWithFrame:CGRectMake(280, 13, 70, 35)];
    [decrease setBackgroundImage:[UIImage imageNamed:@"详情_减@2x.png"] forState:UIControlStateNormal];
    [decrease addTarget:self action:@selector(subPackage) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:decrease];
    
    
}


-(void)addPackage{
    self.product.clickNumber = [NSString stringWithFormat:@"%ld",[self.product.clickNumber integerValue]+[self.product.package integerValue]];
    self.clickNumberLabel.text = self.product.clickNumber;
    self.clickNumberLabel.alpha = 1;
    NSString *str = [NSString stringWithFormat:@"€%.2f",[self.product.discountPrice floatValue]*[self.product.clickNumber integerValue]];
    self.bottomPrice.text = str;
    
    [ShoppingCartSingle addProductArray:self.product];
    
}

-(void)subPackage{
    if ([self.product.clickNumber integerValue]-[self.product.package integerValue]>=0) {
        self.product.clickNumber = [NSString stringWithFormat:@"%ld",[self.product.clickNumber integerValue]-[self.product.package integerValue]];
        self.clickNumberLabel.text = self.product.clickNumber;
    }
    
    if ([self.product.clickNumber isEqualToString:@"0"]) {
        self.clickNumberLabel.alpha = 0;
    }
    NSString *str = [NSString stringWithFormat:@"€%.2f",[self.product.discountPrice floatValue]*[self.product.clickNumber integerValue]];
    self.bottomPrice.text = str;
    
    [ShoppingCartSingle reduceProductArray:self.product];
    
}


-(UILabel *)createUILabel:(UILabel *)label{
    label = [[UILabel alloc]init];
    
    
    return label;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
