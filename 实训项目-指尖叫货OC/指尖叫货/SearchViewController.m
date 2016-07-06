//
//  SearchViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 team. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "DetailProductViewController.h"

#import "AFNetworking/AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"

#import "Service.h"
#import "Product.h"

//#define BaseUrl @"http://jh.wzjkj.com"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>

@property(nonatomic, strong)UITableView *searchTableView;
@property(nonatomic, strong)UITextField *searchField;
@property(nonatomic, strong)NSMutableArray *searchResultArray;
@property(nonatomic, strong)NSString *inputSearch;
@property(nonatomic, strong)NSMutableArray *historyArray;
@property(nonatomic, assign)BOOL isSearch;
@property(nonatomic, strong)UIButton *clearHistory;
@property(nonatomic, strong)UILabel *historyLabel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addContentView];
    
    NSArray *history=[[NSUserDefaults standardUserDefaults]objectForKey:@"history"];
    self.historyArray=[history mutableCopy];
    [self.view addSubview:self.searchTable];
}

-(NSMutableArray *)searchResultArray
{
    if(!_searchResultArray){
        _searchResultArray=[NSMutableArray array];
    }
    return _searchResultArray;
}

-(NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray=[NSMutableArray array];
    }
    return _historyArray;
}

-(void)clickSearch:(UIButton *)btn
{
    if([self.searchField.text isEqualToString:@""]){
        [self showAlert:@"请输入想要搜索的内容"];
    }else{
        _inputSearch=self.searchField.text;
        [[NSUserDefaults standardUserDefaults] setObject:_historyArray forKey:@"history"];
        NSDictionary *params = @{@"keyword":_inputSearch,
                                 @"pageIndex":@"1",
                                 @"pageSize":@"20"};
        
        [Service sericeWithMothed:@"/Goods/FindList" params:params succeed:^(id searchResultDic) {
            if ( [ searchResultDic[@"statusCode"] isEqualToNumber:@1]) {
                NSArray *array=searchResultDic[@"data"][0][@"List"];
                NSLog(@"%@",array);
                if (array.count==0) {
                    [self showAlert:@"抱歉，没有相关产品"];
                }else{
                    [self.searchResultArray addObjectsFromArray:searchResultDic[@"data"][0][@"List"]];
                    _isSearch=YES;
                    if (![self.historyArray containsObject:_inputSearch.uppercaseString]){
                        [self.historyArray addObject:_inputSearch.uppercaseString];
                    }
                    [[NSUserDefaults standardUserDefaults]setObject:self.historyArray forKey:@"history"];
                    [self.searchTable reloadData];
                }
            }
        } fail:^(id error) {
            NSLog(@"erro=%@",error);
        }];
    }
}

-(void)addContentView
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(clickSearch:)];
    UIImageView *searchImage=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 280,30)];
    searchImage.image=[UIImage imageNamed:@"输入框@2x.png"];
    searchImage.userInteractionEnabled = YES;
    
    _searchField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    _searchField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _searchField.placeholder=@"请输入商品名称";
    _searchField.borderStyle=UITextBorderStyleNone;
    _searchField.contentMode=UIViewContentModeCenter;
    _searchField.clearButtonMode=UITextFieldViewModeAlways;
    _searchField.delegate=self;
    
    [_searchField becomeFirstResponder];
    [searchImage addSubview:_searchField];
    self.navigationItem.titleView=searchImage;
}

-(UITableView *)searchTable
{
    if(!_searchTableView){
        _searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 677) style:UITableViewStylePlain];
        _searchTableView.separatorColor=[UIColor clearColor];
        _searchTableView.delegate=self;
        _searchTableView.dataSource=self;
        if (_isSearch==NO) {
            UIView *labelView=[[UIView alloc]initWithFrame:CGRectMake(20, 10, 80, 50)];
            _historyLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 80, 15)];
            _historyLabel.text=@"历史记录";
            _historyLabel.font=[UIFont systemFontOfSize:16];
            _historyLabel.textColor=[UIColor grayColor];
            _historyLabel.textAlignment=NSTextAlignmentLeft;
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 375, 1)];
            view.backgroundColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
            [labelView addSubview:view];
            [labelView addSubview:_historyLabel];
            
            UIView *clearView=[[UIView alloc]initWithFrame:CGRectMake(20, 20, 80, 60)];
            _clearHistory=[[UIButton alloc]initWithFrame:CGRectMake(65, 20, 200, 40)];
            [_clearHistory setBackgroundImage:[UIImage imageNamed:@"清除历史记录@2x.png"] forState:UIControlStateNormal];
            [_clearHistory addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
            [clearView addSubview:_clearHistory];
            
            clearView.clipsToBounds = YES;
            _searchTableView.tableHeaderView=labelView;
            _searchTableView.tableFooterView=clearView;
        }
    }
    return _searchTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isSearch==NO){
        return _historyArray.count;
    }else{
        return _searchResultArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_isSearch==NO){
        static NSString *idetify=@"history";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idetify];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
        }
        cell.textLabel.text=_historyArray[indexPath.row];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 375, 1)];
        view.backgroundColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
        [cell.contentView addSubview:view];
        return cell;
    }

    static NSString *identifier=@"searchCell";
    SearchCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell=[[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSMutableDictionary *productInfo=[self.searchResultArray[indexPath.row] mutableCopy];
    cell.searchDic=productInfo;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 99, 375, 1)];
    view.backgroundColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    [cell.contentView addSubview:view];
    return cell;
}
//点击cell行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击");
    if (_isSearch) {
        DetailProductViewController *dpVC = [[DetailProductViewController alloc]init];
        //    dpvc.Prod
        NSDictionary *dic = self.searchResultArray[indexPath.row];
        Product *product = [Product productWithDictionary:dic];
        product.clickNumber = @"0";
        dpVC.product = product;
        [self.navigationController pushViewController:dpVC animated:NO];
    }
    else{
        NSLog(@"重新搜索");
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSearch==YES) {
        return 100;
    }
    return 50;
}


- (void)showAlert:(NSString *)message
{
    NSString *title = NSLocalizedString(@"温馨提示：", nil);
    NSString *okButtonTitle = NSLocalizedString(@"ok", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"确认！");
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)clearHistory:(UIButton *)btn
{
    [self.historyArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:self.historyArray forKey:@"history"];
    self.clearHistory.hidden=YES;
    [self.searchTableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    _isSearch=NO;
    [self.searchTableView reloadData];
    return YES;
}

@end
