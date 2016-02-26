# FERefresh
最简单的下拉刷新，自定义视图，轻松解耦
#Header and  Footer Refresh for UIScrollView
##HeaderRefresh(头部刷新)

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

##FooterRefresh(底部刷新)

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

##Custom RefreshView(FENormalHeaderView and FENormalFooterView)

typedef NS_ENUM(NSUInteger,FERefreshState){
    FERefreshStateBegin=0,//初始化
    FERefreshStateRefresing,//刷新
    FERefreshStateTransition,//临界值
    FERefreshStateDragRepeat,//反复拉动
    FERefreshStateEnd//结束
};

+ Inheritance FERefreshView
+ setupRefreshView
 -(void)setUpRefreshView:(NSString *)refreshClass;



