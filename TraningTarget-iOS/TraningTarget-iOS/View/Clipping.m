//
//  Clipping.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/24.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Clipping.h"

@implementation Clipping

-(CGImageRef)image
{
    if (_image == NULL)
    {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Ship.png" ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
        _image = CGImageRetain(img.CGImage);
    }
    return _image;
}


-(void)drawInContext:(CGContextRef)context{
    
    // The value we subtract from the height is the Y coordinate for the *bottom* of the image.
    CGFloat height = self.bounds.size.height;
    
    //先把起点从左上角移动到左下角
    CGContextTranslateCTM(context, 0.0, height);
    
    //翻转Y轴
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    
    //此时坐标的起点已经是左下角x向右，y向上
    CGContextDrawImage(context, CGRectMake(10.0, height - 200.0, 90.0, 90.0), self.image);
    
    CGContextSaveGState(context);
    
    CGRect clips[] =
    {
        CGRectMake(150.0, height - 200.0, 35.0, 90.0),
        CGRectMake(205.0, height - 200.0, 35.0, 90.0),
    };
    
    CGContextClipToRects(context, clips, sizeof(clips) / sizeof(clips[0]));
    
    CGContextDrawImage(context, CGRectMake(150.0, height - 200.0, 90.0, 90.0), self.image);
    
    CGContextRestoreGState(context);
    
    
}


-(void)dealloc
{
    CGImageRelease(_image);
}


@end
