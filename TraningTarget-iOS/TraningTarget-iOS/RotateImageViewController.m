//
//  RotateImageViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/2/9.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "RotateImageViewController.h"

@interface RotateImageViewController ()

@end

@implementation RotateImageViewController


+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Rotate Image";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"rotate.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, image.size.width/15, image.size.height/15)];
    
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
    
    UIImage *rotateImage = [image imageRotatedByDegrees:270];
    
    UIImageView *rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 300, rotateImage.size.width/15, rotateImage.size.height/15)];
    
    rotateImageView.image = rotateImage;
    
    [self.view addSubview:rotateImageView];
    
}


- (UIImage *)rotateImage:(UIImage *)image onDegrees:(float)degrees
{
    CGFloat rads = M_PI * degrees / 180;
    float newSide = MAX([image size].width, [image size].height);
    
    CGSize size =  CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
