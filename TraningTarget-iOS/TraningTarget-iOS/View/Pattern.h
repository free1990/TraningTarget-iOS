//
//  Pattern.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "QuartzView.h"

@interface Pattern : QuartzView

@property (nonatomic, readonly) CGColorRef coloredPatternColor;
@property (nonatomic, readonly) CGColorSpaceRef uncoloredPatternColorSpace;

@end
