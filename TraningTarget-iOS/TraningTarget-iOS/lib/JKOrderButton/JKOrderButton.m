//
//  JKButton.m
//  myButton
//
//  Created by John on 14-10-15.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 255.0]

#import "JKOrderButton.h"

@implementation JKOrderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.isHighLight = NO;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2+20, frame.size.height/2-5, 4.5, 9.5)];
        self.imageView.image = [UIImage imageNamed:@"class_exam_disableorder"];
        [self addSubview:self.imageView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.text = @"没有设置名字";
        self.title.textColor = RGBA_COLOR(0x52, 0x52, 0x52, 0xFF);
        [self addSubview:self.title];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.button addTarget:self action:@selector(press:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
    }
    return self;
}

-(void)callbackByBlock:(callBack)block
{
    self.myCallBack = block;
}

- (void)selectedState
{
    self.isHighLight = YES;
    self.title.textColor = RGBA_COLOR(0x00, 0x85, 0xFF, 0xFF);
    self.imageView.image = [UIImage imageNamed:@"class_exam_down"];
}

- (void)reSetState
{
    self.isHighLight = NO;
    self.title.textColor = RGBA_COLOR(0x52, 0x52, 0x52, 0xFF);
    self.imageView.image = [UIImage imageNamed:@"class_exam_disableorder"];
}

- (void)press:(UIButton *)btn
{
    self.isHighLight = !self.isHighLight;
    if (self.isHighLight)
    {
        self.title.textColor = RGBA_COLOR(0x00, 0x85, 0xFF, 0xFF);;
        self.imageView.image = [UIImage imageNamed:@"class_exam_down"];
    }
    else
    {
        self.title.textColor = RGBA_COLOR(0x00, 0x85, 0xFF, 0xFF);;
        self.imageView.image = [UIImage imageNamed:@"class_exam_rise"];
    }
    
    if (self.myCallBack)
        self.myCallBack(self.isHighLight);
}

- (void)dealloc {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end