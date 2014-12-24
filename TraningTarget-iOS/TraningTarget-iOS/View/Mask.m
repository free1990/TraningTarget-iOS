//
//  Mask.m
//  QuartzDemo
//
//  Created by John on 14/12/24.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "Mask.h"

@implementation Mask

//暂时不想看

-(void)createImages
{
    // Load the alpha image, which is just the same Ship.png image used in the clipping demo
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Ship.png" ofType:nil];
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    _alphaImage = CGImageRetain(img.CGImage);
    
    // To show the difference with an image mask, we take the above image and process it to extract
    // the alpha channel as a mask.
    // Allocate data
    NSMutableData *data = [NSMutableData dataWithLength:90 * 90 * 1];
    // Create a bitmap context
    CGContextRef context = CGBitmapContextCreate([data mutableBytes], 90, 90, 8, 90, NULL, (CGBitmapInfo)kCGImageAlphaOnly);
    // Set the blend mode to copy to avoid any alteration of the source data
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    // Draw the image to extract the alpha channel
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, 90.0, 90.0), _alphaImage);
    // Now the alpha channel has been copied into our NSData object above, so discard the context and lets make an image mask.
    CGContextRelease(context);
    // Create a data provider for our data object (NSMutableData is tollfree bridged to CFMutableDataRef, which is compatible with CFDataRef)
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFMutableDataRef)data);
    // Create our new mask image with the same size as the original image
    _maskingImage = CGImageMaskCreate(90, 90, 8, 8, 90, dataProvider, NULL, YES);
    // And release the provider.
    CGDataProviderRelease(dataProvider);
}


-(void)drawInContext:(CGContextRef)context
{
    // NOTE
    // So that the images in this demo appear right-side-up, we flip the context
    // In doing so we need to specify all of our Y positions relative to the height of the view.
    // The value we subtract from the height is the Y coordinate for the *bottom* of the image.
    CGFloat height = self.bounds.size.height;
    CGContextTranslateCTM(context, 0.0, height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    // Quartz also allows you to mask to an image or image mask, the primary difference being
    // how the image data is interpreted. Note that you can use any image
    // When you use a regular image, the alpha channel is interpreted as the alpha values to use,
    // that is a 0.0 alpha indicates no pass and a 1.0 alpha indicates full pass.
    CGContextSaveGState(context);
    CGContextClipToMask(context, CGRectMake(10.0, height - 100.0, 90.0, 90.0), self.alphaImage);
    // Because we're clipping, we aren't going to be particularly careful with our rect.
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    // You can also use the clip rect given to scale the mask image
    CGContextClipToMask(context, CGRectMake(110.0, height - 190.0, 180.0, 180.0), self.alphaImage);
    // As above, not being careful with bounds since we are clipping.
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
    
    // Alternatively when you use a mask image the mask data is used much like an inverse alpha channel,
    // that is 0.0 indicates full pas and 1.0 indicates no pass.
    CGContextSaveGState(context);
    CGContextClipToMask(context, CGRectMake(10.0, height - 300.0, 90.0, 90.0), self.maskingImage);
    // Because we're clipping, we aren't going to be particularly careful with our rect.
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    // You can also use the clip rect given to scale the mask image
    CGContextClipToMask(context, CGRectMake(110.0, height - 390.0, 180.0, 180.0), self.maskingImage);
    // As above, not being careful with bounds since we are clipping.
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
}


- (CGImageRef)maskingImage
{
    if (_maskingImage == NULL)
    {
        [self createImages];
    }
    
    return _maskingImage;
}


- (CGImageRef)alphaImage
{
    if (_alphaImage == NULL)
    {
        [self createImages];
    }
    
    return _alphaImage;
}


-(void)dealloc
{
    CGImageRelease(_maskingImage);
    CGImageRelease(_alphaImage);
}


@end
