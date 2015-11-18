//
//  CAShapeLayerUse.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/6.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CAShapeLayerDrawing.h"

@implementation CAShapeLayerDrawing

+ (Class)layerClass
{
    //重载，让返回的self.layer返回CAShapeLayer
    //this makes our view create a CAShapeLayer
    //instead of a CALayer for its backing layer
    return [CAShapeLayer class];
}

- (instancetype)init
{
    if (self = [super init]){
        
        //create a mutable path
        self.path = [[UIBezierPath alloc] init];
    
        //configure the layer
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    
    //update the layer with a copy of the path
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}
@end
