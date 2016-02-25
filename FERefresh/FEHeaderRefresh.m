//
//  FEHeaderRefresh.m
//  FERefresh
//
//  Created by keso on 16/2/22.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "FEHeaderRefresh.h"
#import "FERefreshView.h"
const CGFloat HeaderHeight=40;

@interface FEHeaderRefresh(){
    CGFloat originOffset;
    CGFloat lastPosition;
    BOOL isRefresh;
    FERefreshState currentState;
}
@property (strong,nonatomic) UIScrollView *relateScrollView;
@property (copy,nonatomic)   void (^refreshBlock)(void);

@end

@implementation FEHeaderRefresh

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
        isRefresh=YES;
        currentState=FERefreshStateRefresing;
        [self.delegate changeRefreshView:FERefreshStateRefresing];
        [UIView animateWithDuration:0.3 animations:^{
            self.relateScrollView.contentInset=UIEdgeInsetsMake(originOffset+HeaderHeight, 0, 0, 0);
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
        [self.delegate changeRefreshView:FERefreshStateEnd];
    }];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset=[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (self.relateScrollView.dragging) {
            if (!isRefresh) {
                if (contentOffset.y<-originOffset&&contentOffset.y>-5) {
                    currentState=FERefreshStateBegin;
                }else if (contentOffset.y<=-originOffset-HeaderHeight) {
                    currentState=FERefreshStateTransition;
                }else{
                    CGFloat currentPostion=contentOffset.y;
                    if (lastPosition-currentPostion>5) {
                        lastPosition=currentPostion;
                    }else if(currentPostion-lastPosition>5){
                        //向上之后向下滑动
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
    [self setUpRefreshView:@"FENormalHeaderView"];
}

-(void)setUpRefreshView:(NSString *)refreshClass{
    Class classType=[NSClassFromString(refreshClass) class];
    FERefreshView *refreshView=[[classType alloc]initWithFrame:CGRectMake(0, -HeaderHeight, self.relateScrollView.frame.size.width,HeaderHeight)];
    self.delegate=refreshView;
    [self.relateScrollView insertSubview:refreshView atIndex:0];
}

#pragma mark - dealloc

-(void)dealloc{
    [self.relateScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
