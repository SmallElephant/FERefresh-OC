//
//  FENormalHeaderView.h
//  FERefresh
//
//  Created by keso on 16/2/24.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERefreshView.h"

@interface FENormalHeaderView:FERefreshView

@property (strong,nonatomic) UIActivityIndicatorView *activityView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel     *contentLabel;

-(instancetype)initWithFrame:(CGRect)frame;

@end
