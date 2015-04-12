//
//  ZYButton.m
//  TraningTarget-iOS
//
//  Created by John on 15/4/12.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ZYButton.h"

#define space_distance 5

@implementation ZYButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        //背景的图片
        self.backgroundIV = [[UIImageView alloc] initWithFrame:CGRectMake(space_distance,
                                                                                 0,
                                                                                 frame.size.width - space_distance*2,
                                                                                 frame.size.height - space_distance*2)];
        self.backgroundIV.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundIV];
        
        //题目的名字
        self.textLbl = [[UILabel alloc] initWithFrame:CGRectMake(space_distance, space_distance,
                                                                 frame.size.width - space_distance * 2,
                                                                 frame.size.height - space_distance * 2)];
        self.textLbl.font = [UIFont systemFontOfSize:14];
        self.textLbl.text = @"点击前";
        self.textLbl.textAlignment = NSTextAlignmentCenter;
        self.textLbl.numberOfLines = 1;
        self.textLbl.textColor = [UIColor blackColor];
        self.textLbl.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.textLbl];
        
        //添加响应事件
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.button.backgroundColor = [UIColor clearColor];
        [self.button addTarget:self action:@selector(press)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
    }
    return self;
}

- (void)displayView
{
   
}

- (void)press
{
    self.textLbl.text = @"点击";
    self.textLbl.backgroundColor = [UIColor blueColor];
    self.textLbl.textColor = [UIColor whiteColor];
    NSLog(@"view.tag = %ld", (long)self.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
