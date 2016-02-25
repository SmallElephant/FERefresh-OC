//
//  FEFooterRefresh.m
//  FERefresh
//
//  Created by keso on 16/2/25.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "FEFooterRefresh.h"
static const CGFloat HeaderHeight=40;
#import "FERefreshView.h"

@interface FEFooterRefresh(){
    CGFloat originOffset;
    CGFloat lastPosition;
    BOOL isRefresh;
    FERefreshState currentState;
    FERefreshView *refreshView;
}

@property (strong,nonatomic) UIScrollView *relateScrollView;
@property (copy,nonatomic)   void (^refreshBlock)(void);

@end

@implementation FEFooterRefresh

-(instancetype)initWithScrollView:(UIScrollView *)scrollView{
    self=[super init];
    if (self) {
        self.relateScrollView=scrollView;
        isRefresh=NO;
        [self.relateScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)beginRefreshing{
    if (!isRefresh) {
        NSLog(@"开始刷新");
        isRefresh=YES;
        currentState=FERefreshStateRefresing;
        [self.delegate changeRefreshView:FERefreshStateRefresing];
        [UIView animateWithDuration:0.3 animations:^{
            self.relateScrollView.contentInset=UIEdgeInsetsMake(originOffset, 0, HeaderHeight, 0);
        } completion:^(BOOL finished) {
            self.refreshBlock();
        }];
    }
}

-(void)addRefreshingBlock:(void (^)(void))block{
    self.refreshBlock=block;
}

-(void)stopRefreshing{
    isRefresh=NO;
    currentState=FERefreshStateEnd;
    [UIView animateWithDuration:0.1 animations:^{
        self.relateScrollView.contentInset=UIEdgeInsetsMake(originOffset, 0, 0, 0);
        [self.delegate changeRefreshView:currentState];
    }];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint contentOffset=[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (self.relateScrollView.dragging) {
            if (!isRefresh) {
                CGSize contentSize=self.relateScrollView.contentSize;
                if (contentSize.height<self.relateScrollView.frame.size.height) {
                    return;
                }
                CGFloat diff=contentOffset.y-(contentSize.height-self.relateScrollView.frame.size.height);
                refreshView.frame=CGRectMake(0, contentSize.height, contentSize.width, HeaderHeight);
                if (diff<5) {
                    currentState=FERefreshStateBegin;
                }else if (diff>HeaderHeight) {
                    currentState=FERefreshStateTransition;
                }else{
                    CGFloat currentPostion=contentOffset.y;
                    if (currentPostion-lastPosition>5) {
                        lastPosition=currentPostion;
                    }else if(lastPosition-currentPostion>5){
                        //向下之后向上滑动
                        lastPosition=currentPostion;
                        currentState=FERefreshStateDragRepeat;
                    }
                }
                [self.delegate changeRefreshView:currentState];
            }
        }else{
            if (currentState==FERefreshStateTransition) {
                [self beginRefreshing];
            }
        }
    }
}


#pragma mark - SetUp

-(void)setUpRefreshView{
    [self setUpRefreshView:@"FENormalFooterView"];
}

-(void)setUpRefreshView:(NSString *)refreshClass{
    Class classType=[NSClassFromString(refreshClass) class];
    refreshView=[[classType alloc]initWithFrame:CGRectMake(0, self.relateScrollView.frame.size.height, self.relateScrollView.frame.size.width,HeaderHeight)];
    self.delegate=refreshView;
    [self.relateScrollView insertSubview:refreshView atIndex:0];
}

#pragma mark - dealloc

-(void)dealloc{
    [self.relateScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
