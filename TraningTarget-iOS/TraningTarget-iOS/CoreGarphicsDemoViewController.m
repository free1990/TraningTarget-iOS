//
//  CoreGarphicsDemoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/19.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "CoreGarphicsDemoViewController.h"
#import "Line.h"
#import "Arcs.h"
#import "RectView.h"
#import "Blend.h"
#import "ImageAndTiling.h"
#import "Pattern.h"
#import "Gradient.h"
#import "Clipping.h"
#import "Mask.h"

@interface CoreGarphicsDemoViewController ()

@end

@implementation CoreGarphicsDemoViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Core Garphics Demo";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //划线
//    Line *line = [[Line alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:line];
//    
//    //弧线和圆、椭圆
//    Arcs *arcs = [[Arcs alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:arcs];
    
//    //矩形
//    RectView *rect = [[RectView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:rect];
    
//    //混合模式
//    Blend *blend = [[Blend alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:blend];
    
//    //CG使用图片
//    ImageAndTiling *image = [[ImageAndTiling alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:image];
    
//    //Pattern
//    Pattern *pattern = [[Pattern alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:pattern];
    
//    //Gradient
//    Gradient *gradient = [[Gradient alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:gradient];
    
    //ClippingView
    Clipping *clip = [[Clipping alloc] initWithFrame:self.view.frame];
    clip.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clip];
    
    //mask
//    Mask *mask = [[Mask alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:mask];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
