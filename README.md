# FERefresh
最简单的下拉刷新，自定义视图，轻松解耦
##Header and  Footer Refresh for UIScrollView

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

##Custom RefreshView
Two Step:
+ Inheritance FERefreshView(继承FERefreshView)
+ setupRefreshView（刷新的时候设置自定View的名字即可）
<pre><code>
 -(void)setUpRefreshView:(NSString *)refreshClass;
</code></pre>

Through FERefresh update Custom View:
<pre></code>
typedef NS_ENUM(NSUInteger,FERefreshState){
    FERefreshStateBegin=0,//初始化
    FERefreshStateRefresing,//刷新
    FERefreshStateTransition,//临界值
    FERefreshStateDragRepeat,//反复拉动
    FERefreshStateEnd//结束
};
</code></pre>

##Dynamic effect diagram(动态效果图)
![image](https://github.com/SmallElephant/FERefresh/blob/master/FERefresh.gif)

##Podfile
`pod 'FERefresh'`
