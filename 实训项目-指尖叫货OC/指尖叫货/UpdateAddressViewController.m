//
//  UpdateAddressViewController.m
//  指尖叫货
//
//  Created by 吴雪琴 on 16/6/28.
//  Copyright © 2016年 team. All rights reserved.
//

#import "UpdateAddressViewController.h"
#import "AddressManageViewController.h"
#import "ComboBoxView.h"

@interface UpdateAddressViewController ()<ComboBoxViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *info;
@property(nonatomic,strong)NSMutableArray *values;
@property(nonatomic,strong)ComboBoxView *provinceComboBox;
@property(nonatomic,strong)UITextField *cityTextField;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *weChatTextField;
@property(nonatomic,strong)UITextField *emailTextField;
@property(nonatomic,strong)UITextField *shopNameTextField;
@property(nonatomic,strong)UITextView *addressTextView;
@property(nonatomic,strong)NSString *restFlag;


@end

@implementation UpdateAddressViewController

- (NSMutableArray *)values{
    if (!_values) {
        _values = [NSMutableArray array];
    }
    return _values;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.restFlag = @"true";
    
    self.navigationItem.title = @"更新地址";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[[UIColor alloc]initWithRed:45/255.0 green:188/255.0 blue:255/255.0 alpha:1]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[[UIColor alloc]initWithRed:36/255.0 green:137/255.0 blue:251/255.0 alpha:1]];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePushBarButtonHandle)];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;

    //生成请求类
    NSString *urlString = [BaseUrl stringByAppendingString:ProVince_GetList];//请求地址
    NSLog(@"地址：%@",urlString);
    //block发送请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
            self.info = responseObject[@"data"];
            for (int i = 0; i<self.info.count; i++) {
                NSString *place = self.info[i][@"Title"];
                NSLog(@"%@",place);
                [self.values addObject:place];
            }
            
            [self addDeliveryAddress];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err = %@",error);
    }];
    

}

-(void)savePushBarButtonHandle{
    //保存
    //生成请求类
    User *user = [User sigleUser];
    if (self.provinceComboBox.comboxTitle !=nil
        &&self.cityTextField.text !=nil
        &&self.nameTextField.text!=nil
        &&self.phoneTextField.text!=nil
        &&self.emailTextField.text!=nil
        &&self.addressTextView.text!=nil) {
        NSString *urlString = [BaseUrl stringByAppendingString:Customer_UpdateAdress];//请求地址
        NSLog(@"地址：%@",urlString);
        //配置请求参数
        NSDictionary *params = @{@"Id":self.addressId,
                                 @"ShopName":self.shopNameTextField.text,
                                 @"ProvinceName":self.provinceComboBox.comboxTitle,
                                 @"City":self.cityTextField.text,
                                 @"AddressDetail":self.addressTextView.text,
                                 @"Name":self.nameTextField.text,
                                 @"Weixin":self.weChatTextField.text,
                                 @"Mobile":self.phoneTextField.text,
                                 @"Zip":self.emailTextField.text,
                                 @"Rest":self.restFlag,
                                 @"StartTime":@"2016-06-27",
                                 @"EndTime":@"2016-06-27",
                                 @"CustomerId":user.customerId};
        
        //block发送请求
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"statusCode"] isEqualToNumber:@1]) {
                NSLog(@"修改成功");
//                AddressManageViewController *amvc = [[AddressManageViewController alloc]init];
                [self.navigationController popViewControllerAnimated:NO];
//                [self.navigationController pushViewController:amvc animated:NO];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"err = %@",error);
        }];
    }
    else{
        //
        NSLog(@"请填写信息");
        
    }
}

-(ComboBoxView *)createComboBox:(ComboBoxView *)comboxView{
    [comboxView setTitleColor:[UIColor blackColor]];
    [comboxView setComboBoxBorderColor:[UIColor lightGrayColor]];
    [comboxView.layer setCornerRadius:5.0];
    [comboxView.layer setBorderWidth:1.0];
    [comboxView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    return comboxView;
}

-(void)addDeliveryAddress{
    UILabel *provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 64+20, 40, 30)];
    provinceLabel.text = @"省份";
    //    provinceLabel.backgroundColor = [UIColor redColor];
    provinceLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:provinceLabel];
    
    _provinceComboBox = [[ComboBoxView alloc]initWithFrame:CGRectMake(provinceLabel.frame.origin.x+provinceLabel.frame.size.width+20, 64+20, 180, 30)];
    _provinceComboBox = [self createComboBox:_provinceComboBox];
    [_provinceComboBox setPromptMessage:@"请选择"];
    [_provinceComboBox updateWithAvailableComboBoxItems:_values];
    [self.view addSubview:_provinceComboBox];
    
    UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(provinceLabel.frame.origin.x, provinceLabel.frame.origin.y+provinceLabel.frame.size.height+15, 40, 30)];
    cityLabel.text = @"城市";
    cityLabel.textAlignment = NSTextAlignmentRight;
    _cityTextField = [self createTextField:_cityTextField];
    _cityTextField.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20, _provinceComboBox.frame.origin.y+_provinceComboBox.frame.size.height+15, 180, 30);
    [self.view addSubview:_cityTextField];
    [self.view addSubview:cityLabel];
    UILabel *clabel = [self createLabel];
    clabel.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20+180+10, _provinceComboBox.frame.origin.y+_provinceComboBox.frame.size.height+15, 20, 30);
    [self.view addSubview:clabel];
    
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, cityLabel.frame.origin.y+cityLabel.frame.size.height+15, 90, 30)];
    nameLabel.text = @"收货人姓名";
    //    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameLabel];
    _nameTextField = [self createTextField:_nameTextField];
    _nameTextField.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20, _cityTextField.frame.origin.y+_cityTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:_nameTextField];
    UILabel *nlabel = [self createLabel];
    nlabel.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20+180+10, _cityTextField.frame.origin.y+_cityTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:nlabel];
    
    
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, nameLabel.frame.origin.y+nameLabel.frame.size.height+15, 90, 30)];
    phoneLabel.text = @"手机号码";
    //    phoneLabel.backgroundColor = [UIColor redColor];
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:phoneLabel];
    
    _phoneTextField = [self createTextField:_phoneTextField];
    _phoneTextField.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20, _nameTextField.frame.origin.y+_nameTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:_phoneTextField];
    UILabel *plabel = [self createLabel];
    plabel.frame = CGRectMake(cityLabel.frame.origin.x+cityLabel.frame.size.width+20+180+10, _nameTextField.frame.origin.y+_nameTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:plabel];
    
    
    UILabel *weChatLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+15, 90, 30)];
    //       weChatLabel.backgroundColor = [UIColor redColor];
    weChatLabel.text = @"微信号";
    weChatLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:weChatLabel];
    
    _weChatTextField = [self createTextField:_weChatTextField];
    _weChatTextField.frame = CGRectMake(weChatLabel.frame.origin.x+weChatLabel.frame.size.width+15, _phoneTextField.frame.origin.y+_phoneTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:_weChatTextField];
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, weChatLabel.frame.origin.y+weChatLabel.frame.size.height+15, 90, 30)];
    emailLabel.text = @"邮编";
    emailLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:emailLabel];
    _emailTextField = [self createTextField:_emailTextField];
    _emailTextField.frame = CGRectMake(emailLabel.frame.origin.x+emailLabel.frame.size.width+15, _weChatTextField.frame.origin.y+_weChatTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:_emailTextField];
    UILabel *elabel = [self createLabel];
    elabel.frame = CGRectMake(emailLabel.frame.origin.x+emailLabel.frame.size.width+15+190, _weChatTextField.frame.origin.y+_weChatTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:elabel];
    
    
    UILabel *shopLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, emailLabel.frame.origin.y+emailLabel.frame.size.height+15, 90, 30)];
    shopLabel.text = @"商店名称";
    shopLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:shopLabel];
    _shopNameTextField = [self createTextField:_emailTextField];
    _shopNameTextField.frame = CGRectMake(shopLabel.frame.origin.x+shopLabel.frame.size.width+15, _emailTextField.frame.origin.y+_emailTextField.frame.size.height+15, 180, 30);
    [self.view addSubview:_shopNameTextField];
    
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, shopLabel.frame.origin.y+shopLabel.frame.size.height+15, 90, 30)];
    addressLabel.text = @"详细地址";
    addressLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:addressLabel];
    _addressTextView = [[UITextView alloc]initWithFrame:CGRectMake(addressLabel.frame.origin.x+addressLabel.frame.size.width+15,_shopNameTextField.frame.origin.y+_shopNameTextField.frame.size.height+15,  220, 120)];
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _addressTextView.layer.borderWidth =1;
    [self.view addSubview:_addressTextView];
    UILabel *alabel = [self createLabel];
    alabel.frame = CGRectMake(addressLabel.frame.origin.x+addressLabel.frame.size.width+15+220+10,_shopNameTextField.frame.origin.y+_shopNameTextField.frame.size.height+8,  220, 30);
    [self.view addSubview:alabel];
    
    UIButton *rest = [[UIButton alloc]initWithFrame:CGRectMake(65, _addressTextView.frame.origin.y+_addressTextView.frame.size.height+18, 28, 15)];
    [rest addTarget:self action:@selector(restBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rest.tag = 800;
    rest.layer.borderWidth = 1;
    rest.layer.cornerRadius = 5;
    [rest setBackgroundImage:[UIImage imageNamed:@"收货地址_03"] forState:UIControlStateNormal];
    rest.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:rest];
    //    收货地址_03.png
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40+28*2+10, _addressTextView.frame.origin.y+_addressTextView.frame.size.height+10, 120, 30)];
    label.text = @"中午休息";
    [self.view addSubview:label];
    
    UILabel *sendlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, rest.frame.origin.y+rest.frame.size.height+15, 90, 30)];
    sendlabel.textAlignment = NSTextAlignmentRight;
    sendlabel.text = @"送货时间";
    
    [self.view addSubview:sendlabel];
}

-(UITextField *)createTextField:(UITextField *)textField{
    textField =  [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
    textField.textColor = [UIColor blackColor];//文字颜色
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = 5;
    [textField setFont:[UIFont systemFontOfSize:20]];
    textField.layer.masksToBounds = YES;
    return textField;
}

-(UILabel *)createLabel{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 20, 30);
    [label setTextColor:[UIColor redColor]];
    label.text = @"*";
    return label;
}

-(void)restBtnClick:(UIButton *)btn{
    NSLog(@"点击");
    NSLog(@"%@",self.restFlag);
    if ([self.restFlag isEqualToString:@"false"]) {
        self.restFlag = @"true";
        NSLog(@"确定");
        [btn setBackgroundImage:[UIImage imageNamed:@"收货地址_03"] forState:UIControlStateNormal];
        
    }
    else if ([self.restFlag isEqualToString:@"true"]) {
        self.restFlag = @"false";
        NSLog(@"cancel");
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
}

- (void)expandedComboBoxView:(ComboBoxView *)comboBoxView
{
    
}

- (void)collapseComboBoxView:(ComboBoxView *)comboBoxView
{
    
}

- (void)selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView
{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
