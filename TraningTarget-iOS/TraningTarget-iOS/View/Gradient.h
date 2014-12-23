//
//  Gradient.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "QuartzView.h"

@interface Gradient : QuartzView{
    CGGradientRef _gradient;
}

@property (nonatomic, readonly) CGGradientRef gradient;

@end
