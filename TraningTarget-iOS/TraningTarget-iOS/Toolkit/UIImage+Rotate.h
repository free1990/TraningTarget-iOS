//
//  UIImage+Rotate.h
//  TraningTarget-iOS
//
//  Created by John on 15/2/9.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
