//
//  Pattern.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Pattern.h"

// Colored patterns specify colors as part of their drawing
void ColoredPatternCallback(void *info, CGContextRef context)
{
    // Dark Blue
    CGContextSetRGBFillColor(context, 29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, 8.0, 8.0));
    CGContextFillRect(context, CGRectMake(8.0, 8.0, 8.0, 8.0));
    
    // Light Blue
    CGContextSetRGBFillColor(context, 204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00);
    CGContextFillRect(context, CGRectMake(8.0, 0.0, 8.0, 8.0));
    CGContextFillRect(context, CGRectMake(0.0, 8.0, 8.0, 8.0));
}

// Uncolored patterns take their color from the given context
void UncoloredPatternCallback(void *info, CGContextRef context)
{
    CGContextFillRect(context, CGRectMake(0.0, 0.0, 8.0, 8.0));
    CGContextFillRect(context, CGRectMake(8.0, 8.0, 8.0, 8.0));
}

@implementation Pattern{
    CGColorRef _coloredPatternColor;
    CGPatternRef _uncoloredPattern;
    CGColorSpaceRef _uncoloredPatternColorSpace;
}

- (CGColorRef)coloredPatternColor
{
    if (_coloredPatternColor == NULL)
    {
        // Colored Pattern setup
        CGPatternCallbacks coloredPatternCallbacks = {0, ColoredPatternCallback, NULL};
        // First we need to create a CGPatternRef that specifies the qualities of our pattern.
        CGPatternRef coloredPattern = CGPatternCreate(
                                                      NULL, // 'info' pointer for our callback
                                                      CGRectMake(0.0, 0.0, 16.0, 16.0), // the pattern coordinate space, drawing is clipped to this rectangle
                                                      CGAffineTransformIdentity, // a transform on the pattern coordinate space used before it is drawn.
                                                      16.0, 16.0, // the spacing (horizontal, vertical) of the pattern - how far to move after drawing each cell
                                                      kCGPatternTilingNoDistortion,
                                                      true, // this is a colored pattern, which means that you only specify an alpha value when drawing it
                                                      &coloredPatternCallbacks); // the callbacks for this pattern.
        
        // To draw a pattern, you need a pattern colorspace.
        // Since this is an colored pattern, the parent colorspace is NULL, indicating that it only has an alpha value.
        CGColorSpaceRef coloredPatternColorSpace = CGColorSpaceCreatePattern(NULL);
        CGFloat alpha = 1.0;
        // Since this pattern is colored, we'll create a CGColorRef for it to make drawing it easier and more efficient.
        // From here on, the colored pattern is referenced entirely via the associated CGColorRef rather than the
        // originally created CGPatternRef.
        _coloredPatternColor = CGColorCreateWithPattern(coloredPatternColorSpace, coloredPattern, &alpha);
        CGColorSpaceRelease(coloredPatternColorSpace);
        CGPatternRelease(coloredPattern);
    }
    
    return _coloredPatternColor;
}


- (CGPatternRef)uncoloredPattern
{
    if (_uncoloredPattern == NULL)
    {
        CGPatternCallbacks uncoloredPatternCallbacks = {0, UncoloredPatternCallback, NULL};
        // As above, we create a CGPatternRef that specifies the qualities of our pattern
        _uncoloredPattern = CGPatternCreate(
                                            NULL, // 'info' pointer
                                            CGRectMake(0.0, 0.0, 16.0, 16.0), // coordinate space
                                            CGAffineTransformIdentity, // transform
                                            16.0, 16.0, // spacing
                                            kCGPatternTilingNoDistortion,
                                            false, // this is an uncolored pattern, thus to draw it we need to specify both color and alpha
                                            &uncoloredPatternCallbacks); // callbacks for this pattern
    }
    
    return _uncoloredPattern;
}

-(CGColorSpaceRef)uncoloredPatternColorSpace;

{
    if (_uncoloredPatternColorSpace == NULL) {
        // With an uncolored pattern we still need to create a pattern colorspace, but now we need a parent colorspace
        // We'll use the DeviceRGB colorspace here. We'll need this colorspace along with the CGPatternRef to draw this pattern later.
        CGColorSpaceRef deviceRGB = CGColorSpaceCreateDeviceRGB();
        _uncoloredPatternColorSpace = CGColorSpaceCreatePattern(deviceRGB);
        CGColorSpaceRelease(deviceRGB);
    }
    
    return _uncoloredPatternColorSpace;
}

-(void)drawInContext:(CGContextRef)context
{
    // Draw the colored pattern. Since we have a CGColorRef for this pattern, we just set
    // that color current and draw.
    CGContextSetFillColorWithColor(context, self.coloredPatternColor);
    CGContextFillRect(context, CGRectMake(10.0, 110.0, 90.0, 90.0));
    
    // You can also stroke with a pattern.
    CGContextSetStrokeColorWithColor(context, self.coloredPatternColor);
    CGContextStrokeRectWithWidth(context, CGRectMake(120.0, 110.0, 90.0, 90.0), 8.0);
    
    // Since we aren't encapsulating our pattern in a CGColorRef for the uncolored pattern case, setup requires two steps.
    // First you have to set the context's current colorspace (fill or stroke) to a pattern colorspace,
    // indicating to Quartz that you want to draw a pattern.
    CGContextSetFillColorSpace(context, self.uncoloredPatternColorSpace);
    // Next you set the pattern and the color that you want the pattern to draw with.
    CGFloat color1[] = {1.0, 0.0, 0.0, 1.0};
    CGContextSetFillPattern(context, self.uncoloredPattern, color1);
    // And finally you draw!
    CGContextFillRect(context, CGRectMake(10.0, 220.0, 90.0, 90.0));
    // As long as the current colorspace is a pattern colorspace, you are free to change the pattern or pattern color
    CGFloat color2[] = {0.0, 1.0, 0.0, 1.0};
    CGContextSetFillPattern(context, self.uncoloredPattern, color2);
    CGContextFillRect(context, CGRectMake(10.0, 330.0, 90.0, 90.0));
    
    // And of course, just like the colored case, you can stroke with a pattern as well.
    CGContextSetStrokeColorSpace(context, self.uncoloredPatternColorSpace);
    CGContextSetStrokePattern(context, self.uncoloredPattern, color1);
    CGContextStrokeRectWithWidth(context, CGRectMake(120.0, 220.0, 90.0, 90.0), 8.0);
    // As long as the current colorspace is a pattern colorspace, you are free to change the pattern or pattern color
    CGContextSetStrokePattern(context, self.uncoloredPattern, color2);
    CGContextStrokeRectWithWidth(context, CGRectMake(120.0, 330.0, 90.0, 90.0), 8.0);
}


-(void)dealloc
{
    CGColorRelease(_coloredPatternColor);
    CGPatternRelease(_uncoloredPattern);
    CGColorSpaceRelease(_uncoloredPatternColorSpace);
}



@end
