//
//  ViewController.m
//  FERefresh
//
//  Created by keso on 16/2/21.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "FEHeaderRefresh.h"
#import "FEFooterRefresh.h"

#define SCREENWIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREENHEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

static  NSString * const cellIdentifier=@"cellIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSource;

@property (strong,nonatomic) UIView *refreshView;
@property (strong,nonatomic) UILabel *descLabel;
@property (strong,nonatomic) UIView *footerView;

@property (strong,nonatomic) FEHeaderRefresh *headerRefresh;
@property (strong,nonatomic) FEFooterRefresh *footerRefresh;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self config];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - Accessors

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,64,SCREENWIDTH,SCREENHEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(UIView *)refreshView{
    if (!_refreshView) {
        _refreshView=[[UIView alloc] initWithFrame:CGRectMake(0, -50, SCREENWIDTH, 50)];
        _refreshView.backgroundColor=[UIColor redColor];
    }
    return _refreshView;
}
-(UIView *)footerView{
    if (!_footerView) {
        _footerView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-64, SCREENWIDTH, 50)];
        _footerView.backgroundColor=[UIColor greenColor];
    }
    return _footerView;
}

#pragma mark - setup method

-(void)config{
    [self.navigationItem setTitle:@"FERefresh"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    for (NSInteger i=0; i<30; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"FlyElephant-%ld",(long)i]];
    }
    [self.view addSubview:self.tableView];
    
    self.headerRefresh=[[FEHeaderRefresh alloc]initWithScrollView:self.tableView];
    [self.headerRefresh setUpRefreshView:@"FENormalHeaderView"];
    __weak FEHeaderRefresh *weakHeaderRefresh=self.headerRefresh;
    __weak typeof(self) weakSelf=self;
    [self.headerRefresh addRefreshingBlock:^{
        dispatch_time_t delayTime=dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            for (NSInteger i=100;i<110 ;i++) {
                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"FlyElephant-%ld",(long)i]];
            }
            [weakSelf.tableView reloadData];
            [weakHeaderRefresh stopRefreshing];
        });
    }];
    
    self.footerRefresh=[[FEFooterRefresh alloc]initWithScrollView:self.tableView];
    [self.footerRefresh setUpRefreshView];
    
    __weak FEFooterRefresh *weakFooterRefresh=self.footerRefresh;
    [self.footerRefresh addRefreshingBlock:^{
        dispatch_time_t delayTime=dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            for (NSInteger i=100;i<110 ;i++) {
                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"FlyElephant-%ld",(long)i]];
            }
            [weakSelf.tableView reloadData];
            [weakFooterRefresh stopRefreshing];
        });
    }];
}

@end
