//
//  QuartzView.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "QuartzView.h"

@implementation QuartzView


-(void)drawInContext:(CGContextRef)context{
    
}


- (void)drawRect:(CGRect)rect {
    //使用的依旧是UIKit的坐标系
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    //开始一个新的路径
    //CGContextMoveToPoint
}


@end
