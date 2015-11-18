//
//  Roundbutton.m
//  TraningTarget-iOS
//
//  Created by John on 15/4/21.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "Roundbutton.h"

@implementation Roundbutton


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetRGBStrokeColor(context, self.redValue, self.greenValue, self.blueValue, 0.8);
    CGContextSetLineWidth(context, self.frame.size.height);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, self.frame.size.height, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width - self.frame.size.height, self.frame.size.height/2);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}

@end
