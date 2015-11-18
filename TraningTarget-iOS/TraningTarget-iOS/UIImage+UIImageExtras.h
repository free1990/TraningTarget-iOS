//
//  UIImage+UIImageExtras.h
//  TraningTarget-iOS
//
//  Created by John on 15/1/19.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtras)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height;
@end
