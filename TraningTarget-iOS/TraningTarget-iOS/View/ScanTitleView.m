//
//  ScanTitleView.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ScanTitleView.h"

@implementation ScanTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width-40, frame.size.height)];
        
        self.titleLbl.text = @"待处理试卷库";
        self.titleLbl.textColor = [UIColor whiteColor];
        self.titleLbl.font = [UIFont boldSystemFontOfSize:15];
        self.titleLbl.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.titleLbl];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);

    CGContextSetRGBStrokeColor(context, 69/255.0, 69/255.0, 69/255.0, 0.8);
    CGContextSetLineWidth(context, 30);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, 20.0, 15);
    CGContextAddLineToPoint(context, 130.0, 15);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}

@end
