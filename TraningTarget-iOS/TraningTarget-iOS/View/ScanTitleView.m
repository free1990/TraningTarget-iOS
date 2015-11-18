//
//  ScanTitleView.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ScanTitleView.h"
#import "UIView+MGBadgeView.h"

@implementation ScanTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *logo = [UIImage imageNamed:@"wait_deal"];
        
        UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
        
        logoView.backgroundColor = [UIColor clearColor];
        [logoView setCenter:CGPointMake(19, 22)];
        
        [self addSubview:logoView];
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, frame.size.width-30, frame.size.height)];
        
        self.titleLbl.text = @"待处理试卷库";
        self.titleLbl.textColor = [UIColor whiteColor];
        self.titleLbl.font = [UIFont boldSystemFontOfSize:12];
        self.titleLbl.textAlignment = NSTextAlignmentLeft;
        self.titleLbl.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.titleLbl];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
        [btn setFrame:self.frame];
        
        [self addSubview:btn];
    }
    return self;
}

- (void)setLableBadgeViewWithNum:(int)num
{
    [self.titleLbl.badgeView setFixedHeight:15];
    [self.titleLbl.badgeView setDisplayIfZero:NO];
    [self.titleLbl.badgeView setBadgeValue:num];
    [self.titleLbl.badgeView setOutlineWidth:0.0];
    [self.titleLbl.badgeView setFont:[UIFont systemFontOfSize:10]];
    [self.titleLbl.badgeView setOutlineColor:[UIColor redColor]];
    [self.titleLbl.badgeView setBadgeColor:[UIColor redColor]];
    [self.titleLbl.badgeView setTextColor:[UIColor whiteColor]];
    [self.titleLbl.badgeView setPosition:MGBadgePositionTopRight];
}

- (void)click
{
    if (self.callback) {
        self.callback();
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);

    CGContextSetRGBStrokeColor(context, 69/255.0, 69/255.0, 69/255.0, 0.8);
    CGContextSetLineWidth(context, 30);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, 20.0, 22);
    CGContextAddLineToPoint(context, self.frame.size.width - 20, 22);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}

@end
