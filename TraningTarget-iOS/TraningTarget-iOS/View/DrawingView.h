//
//  DrawingView.h
//  TraningTarget-iOS
//
//  Created by John on 15/1/6.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define BRUSH_SIZE 32

@interface DrawingView : UIView

@property (nonatomic, strong) NSMutableArray *strokes;

@end
