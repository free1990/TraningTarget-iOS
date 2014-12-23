//
//  Blend.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Blend.h"

@implementation Blend

-(void)drawInContext:(CGContextRef)context{
    
    //相当于是背景
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, CGRectMake(0, 300, 320, 100));
    
    //两个进行混合
    CGContextSetBlendMode(context, kCGBlendModeLuminosity);
    
    //前景
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(110.0, 20.0, 100.0, 400.0));
    
    enum CGBlendMode {
        /* Available in Mac OS X 10.4 & later. */
        kCGBlendModeNormal,
        kCGBlendModeMultiply,
        kCGBlendModeScreen,
        kCGBlendModeOverlay,
        kCGBlendModeDarken,
        kCGBlendModeLighten,
        kCGBlendModeColorDodge,
        kCGBlendModeColorBurn,
        kCGBlendModeSoftLight,
        kCGBlendModeHardLight,
        kCGBlendModeDifference,
        kCGBlendModeExclusion,
        kCGBlendModeHue,
        kCGBlendModeSaturation,
        kCGBlendModeColor,
        kCGBlendModeLuminosity,
        
        /* Available in Mac OS X 10.5 & later. R, S, and D are, respectively,
         premultiplied result, source, and destination colors with alpha; Ra,
         Sa, and Da are the alpha components of these colors.
         
         The Porter-Duff "source over" mode is called `kCGBlendModeNormal':
         R = S + D*(1 - Sa)
         
         Note that the Porter-Duff "XOR" mode is only titularly related to the
         classical bitmap XOR operation (which is unsupported by
         CoreGraphics). */
        
        kCGBlendModeClear,			/* R = 0 */
        kCGBlendModeCopy,			/* R = S */
        kCGBlendModeSourceIn,		/* R = S*Da */
        kCGBlendModeSourceOut,		/* R = S*(1 - Da) */
        kCGBlendModeSourceAtop,		/* R = S*Da + D*(1 - Sa) */
        kCGBlendModeDestinationOver,	/* R = S*(1 - Da) + D */
        kCGBlendModeDestinationIn,		/* R = D*Sa */
        kCGBlendModeDestinationOut,		/* R = D*(1 - Sa) */
        kCGBlendModeDestinationAtop,	/* R = S*(1 - Da) + D*Sa */
        kCGBlendModeXOR,			/* R = S*(1 - Da) + D*(1 - Sa) */
        kCGBlendModePlusDarker,		/* R = MAX(0, (1 - D) + (1 - S)) */
        kCGBlendModePlusLighter		/* R = MIN(1, S + D) */
    };
    typedef enum CGBlendMode CGBlendMode;
    
}

@end
