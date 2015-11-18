//
//  ScanView.h
//  Teacher
//
//  Created by John on 15/3/18..
//  Copyright (c) 2015年 FClassroom. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ScanView : UIView

- (void)customScanAnimationRect:(CGSize)size WithImage:(UIImage *)image scanWidth:(float)scanWidth;

- (void)startScanAnimation;
- (void)stopScanAnimation;

@end
