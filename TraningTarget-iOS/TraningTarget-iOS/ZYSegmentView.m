//
//  ZYSegmentView.m
//  TraningTarget-iOS
//
//  Created by John on 15/4/12.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ZYSegmentView.h"
#import "ZYButton.h"

#define ButtonWidth 70

@implementation ZYSegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        self.selectView = [[UIScrollView alloc] initWithFrame:frame];
        
        self.selectView.bounces = YES;
        self.selectView.pagingEnabled = NO;
        self.selectView.userInteractionEnabled = YES;
        self.selectView.showsHorizontalScrollIndicator = NO;
        self.selectView.delegate = self;
        
        [self addSubview:self.selectView];
        
    }
    return self;
}

- (void)displayContent
{
    [self.selectView setContentSize:CGSizeMake(ButtonWidth * 10,  self.frame.size.height)];
    
    for (int i = 0; i < 10;i++)
    {
        
        ZYButton *button = [[ZYButton alloc] initWithFrame:CGRectMake(0, 0, ButtonWidth, self.frame.size.height)];
        
        button.tag = i;
        
        button.frame = CGRectMake((button.frame.size.width * i), 0, ButtonWidth, self.frame.size.height);
        
        [self.selectView addSubview:button];
    }
}

//scrollView和pageControl配合
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.selectView.frame.size.width;
//    int page = floor((_scrollView.contentOffset.x - pagewidth/([_slideImages count]+2))/pagewidth)+1;
//    page --;
//    _pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.selectView.frame.size.width;
//    int currentPage = floor((_scrollView.contentOffset.x - pagewidth/ ([_slideImages count]+2)) / pagewidth) + 1;
//    if (currentPage==0)
//    {
//        [_scrollView scrollRectToVisible:CGRectMake(WinSize.width * [_slideImages count],0,WinSize.width,150)
//                                animated:NO]; // 序号0 最后1页
//    }
//    else if (currentPage==([_slideImages count]+1))
//    {
//        [_scrollView scrollRectToVisible:CGRectMake(WinSize.width,0,WinSize.width,150) animated:NO]; // 最后+1,循环第1页
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
