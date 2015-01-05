//
//  CoreAnimationDemoThreeViewController.h
//  TraningTarget-iOS
//
//  Created by John on 15/1/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CoreAnimationDemoThreeViewController : BaseViewController{
    CALayer *_colorLayer;
}

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@end
