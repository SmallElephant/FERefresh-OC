//
//  FENormalFooterView.m
//  FERefresh
//
//  Created by keso on 16/2/25.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "FENormalFooterView.h"
static  NSString * const FooterPulling=@"上拉刷新...";
static  NSString * const FooterRefreshing=@"松开刷新...";
static  NSString * const FooterEnding=@"正在刷新...";

@interface FENormalFooterView()

@end

@implementation FENormalFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.activityView.frame=CGRectMake(frame.size.width/2-50, 5, 30, 30);
        [self insertSubview:self.activityView atIndex:0];
        self.imageView.frame=CGRectMake(frame.size.width/2-50,5 ,20, 30);
        [self insertSubview:self.imageView atIndex:0];
        self.contentLabel.frame=CGRectMake(frame.size.width/2-5, 5, 150, 30);
        self.contentLabel.text=FooterPulling;
        [self insertSubview:self.contentLabel atIndex:0];
    }
    return self;
}

#pragma mark - FERefreshDelegate

-(void)changeRefreshView:(FERefreshState)refreshState{
    switch (refreshState) {
        case FERefreshStateBegin:
            [self setUpRefreshBegin];
            break;
        case FERefreshStateRefresing:
            [self setUpRefreshing];
            break;
        case FERefreshStateTransition:
            [self setUpTransitionView];
            break;
        case FERefreshStateDragRepeat:
            [self setUpDragRepeatView];
            break;
        case FERefreshStateEnd:
            [self setUpEndView];
            break;
    }
}

#pragma mark - Change View

-(void)setUpRefreshBegin{
    self.imageView.hidden=NO;
    self.activityView.hidden=YES;
    self.contentLabel.hidden=NO;
    self.contentLabel.text=FooterPulling;
    self.imageView.transform=CGAffineTransformMakeRotation(M_PI);
}

-(void)setUpRefreshing{
    self.imageView.hidden=YES;
    self.activityView.hidden=NO;
    self.contentLabel.hidden=NO;
    self.contentLabel.text=FooterEnding;
    [self.activityView startAnimating];
}

-(void)setUpTransitionView{
    self.imageView.hidden=NO;
    self.contentLabel.hidden=NO;
    self.activityView.hidden=YES;
    self.contentLabel.text=FooterRefreshing;
    self.imageView.transform=CGAffineTransformMakeRotation(M_PI*2);
}

-(void)setUpDragRepeatView{
    self.imageView.hidden=NO;
    self.contentLabel.hidden=NO;
    self.activityView.hidden=YES;
    self.contentLabel.text=FooterPulling;
}

-(void)setUpEndView{
    self.imageView.hidden=YES;
    [self.activityView stopAnimating];
    self.activityView.hidden=YES;
    self.contentLabel.hidden=YES;
    self.contentLabel.text=FooterPulling;
}

#pragma mark - Accessor

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidden=YES;
    }
    return _activityView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[UIImageView new];
        _imageView.image=[UIImage imageNamed:@"arrow"];
        _imageView.transform=CGAffineTransformMakeRotation(M_PI);
    }
    return _imageView;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[UILabel new];
        _contentLabel.textColor=[UIColor blackColor];
        _contentLabel.textAlignment=NSTextAlignmentLeft;
        [_contentLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _contentLabel;
}


@end
