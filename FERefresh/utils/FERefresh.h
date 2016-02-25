//
//  FERefresh.h
//  FERefresh
//
//  Created by keso on 16/2/25.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,FERefreshState){
    FERefreshStateBegin=0,//初始化
    FERefreshStateRefresing,//刷新
    FERefreshStateTransition,//临界值
    FERefreshStateDragRepeat,//反复拉动
    FERefreshStateEnd//结束
};

typedef NS_ENUM(NSUInteger,FERefreshType){
    FERefreshTypeHeader=0,
    FERefreshTypeFooter
};

@protocol FERefreshDelegate <NSObject>

@optional
-(void)changeRefreshView:(FERefreshState)refreshState;

@end

@interface FERefresh : NSObject

@property (weak,nonatomic  ) id<FERefreshDelegate> delegate;

@end
