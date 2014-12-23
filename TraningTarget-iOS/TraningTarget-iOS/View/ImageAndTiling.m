//
//  ImageAndTiling.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "ImageAndTiling.h"
#define kTextString "Hello From Quartz"
#define kTextStringLength strlen(kTextString)

@implementation ImageAndTiling

-(void)drawInContext:(CGContextRef)context{
    
    CGRect imageRect;
    imageRect.origin = CGPointMake(100, 100);
    imageRect.size = CGSizeMake(40, 40);
    
    CGContextDrawImage(context, imageRect, self.image);
    
//    CGContextClipToRect(context, CGRectMake(0.0, 80.0, self.bounds.size.width,200));
    
    imageRect.origin = CGPointMake(132.0, 112.0);
    CGContextDrawTiledImage(context, imageRect, self.image);
    
    // Highlight the "first" image from the DrawTiledImage call.
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
    CGContextFillRect(context, imageRect);
    // And stroke the clipped area
    CGContextSetLineWidth(context, 3.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokeRect(context, CGContextGetClipBoundingBox(context));
    
#pragma mark - quartz text
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    CGContextSelectFont(context, "Helvetica", 36.0, kCGEncodingMacRoman);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextShowTextAtPoint(context, 10.0, 330.0, kTextString, kTextStringLength);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    CGContextShowTextAtPoint(context, 10.0, 370.0, kTextString, kTextStringLength);
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    CGContextShowTextAtPoint(context, 10.0, 410.0, kTextString, kTextStringLength);
    
    
    CGFontRef helvetica = CGFontCreateWithFontName((CFStringRef)@"Helvetica");
    CGContextSetFont(context, helvetica);
    CGContextSetFontSize(context, 12.0);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // Next we'll display lots of glyphs from the font.
    CGGlyph start = 0;
    for(int y = 0; y < 20; ++y)
    {
        CGGlyph glyphs[32];
        for(int i = 0; i < 32; ++i)
        {
            glyphs[i] = start + i;
        }
        start += 32;
        CGContextShowGlyphsAtPoint(context, 10.0, 150.0 + 12 * y, glyphs, 32);
    }
    CGFontRelease(helvetica);
    
}

- (CGImageRef)image
{
    if (_image == NULL)
    {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
        _image = CGImageRetain(img.CGImage);
    }
    return _image;
}


-(void)dealloc
{
    CGImageRelease(_image);
}

@end
