//
//  FENormalFooterView.h
//  FERefresh
//
//  Created by keso on 16/2/25.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "FERefreshView.h"

@interface FENormalFooterView : FERefreshView

@property (strong,nonatomic) UIActivityIndicatorView *activityView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel     *contentLabel;

-(instancetype)initWithFrame:(CGRect)frame;

@end
