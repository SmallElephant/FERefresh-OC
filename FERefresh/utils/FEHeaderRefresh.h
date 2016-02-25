//
//  FEHeaderRefresh.h
//  FERefresh
//
//  Created by keso on 16/2/22.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERefresh.h"

extern const CGFloat HeaderHeight;

@interface FEHeaderRefresh:FERefresh

/**
 *  初始化
 *
 *  @param scrollView 关联的UIScrollView
 *
 *  @return 返回实例对象
 */
-(instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  主动触发刷新
 */
-(void)beginRefreshing;
/**
 *  刷新回调
 *
 *  @param block 外部传入Block
 */
-(void)addRefreshingBlock:(void (^)(void))block;
/**
 *  终止刷新
 */
-(void)stopRefreshing;
/**
 *  设置刷新View
 */
-(void)setUpRefreshView;
/**
 *  设置刷新的UIView,FERefreshView子类
 */
-(void)setUpRefreshView:(NSString *)refreshClass;

@end
