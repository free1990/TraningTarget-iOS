//
//  DrawingView.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/6.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
    
        self.strokes = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}


//使用脏矩形，减少不必须要的重绘
- (void)addBrushStrokeAtPoint:(CGPoint)point
{
    //add brush stroke to array
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    //set dirty rect
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}

- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect
{
    
    //redraw strokes
    for (NSValue *value in self.strokes) {
        //get point
        CGPoint point = [value CGPointValue];
        
        //get brush rect
        CGRect brushRect = [self brushRectForPoint:point];
        
        //only draw brush stroke if it intersects dirty rect
        if (CGRectIntersectsRect(rect, brushRect)) {
            //draw brush stroke
            [[UIImage imageNamed:@"qq"] drawInRect:brushRect];
        }
    }
}

//- (void)addBrushStrokeAtPoint:(CGPoint)point
//{
//    //add brush stroke to array
//    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
//    
//    //needs redraw
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    //redraw strokes
//    for (NSValue *value in self.strokes) {
//        //get point
//        CGPoint point = [value CGPointValue];
//        
//        //get brush rect
//        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
//        
//        //draw brush stroke    ￼
//        [[UIImage imageNamed:@"qq"] drawInRect:brushRect];
//    }
//}

@end
