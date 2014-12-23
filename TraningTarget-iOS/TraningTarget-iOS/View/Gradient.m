//
//  Gradient.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Gradient.h"

@implementation Gradient

-(CGGradientRef)gradient
{
    if(_gradient == NULL)
    {
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGFloat colors[] =
        {
            204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
            29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
            0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
        };
        _gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGColorSpaceRelease(rgb);
    }
    return _gradient;
}

-(void)drawInContext:(CGContextRef)context{

//    CGContextDrawLinearGradient(context, self.gradient, CGPointMake(160, 100), CGPointMake(160, 400), kCGGradientDrawsBeforeStartLocation);
    
//    void CGContextDrawRadialGradient(CGContextRef context,
//                                     CGGradientRef gradient, CGPoint startCenter, CGFloat startRadius,
//                                     CGPoint endCenter, CGFloat endRadius, CGGradientDrawingOptions options)
    
//    kCGGradientDrawsAfterEndLocation      从开始之后绘制
//    kCGGradientDrawsBeforeStartLocation 从开始之前（也就是能利用的更早的点）的开始绘制
    
    CGContextDrawRadialGradient(context, self.gradient, self.center, 10, self.center, 100, kCGGradientDrawsAfterEndLocation);
    
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokeRectWithWidth(context, self.frame, 2.0);

}


@end
