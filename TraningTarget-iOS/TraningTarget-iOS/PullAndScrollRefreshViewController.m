//
//  PullAndScrollRefreshViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/23.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "PullAndScrollRefreshViewController.h"

@interface PullAndScrollRefreshViewController ()

@end

@implementation PullAndScrollRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [self addImage:[UIImage imageNamed:@"top"] toImage:[UIImage imageNamed:@"bottom"]];
    
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    imageView.layer.borderWidth = 3.0;
    
    [self.view addSubview:imageView];
    
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
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
