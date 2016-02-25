//
//  FEFooterRefresh.h
//  FERefresh
//
//  Created by keso on 16/2/25.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FERefresh.h"

@interface FEFooterRefresh:FERefresh
/**
 *   初始化
 *
 *  @param scrollView 关联的UIScrollView
 *
 *  @return 实例
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
