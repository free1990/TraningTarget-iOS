//
//  ZYSegmentView.h
//  TraningTarget-iOS
//
//  Created by John on 15/4/12.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYSegmentView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *selectView;

- (void)displayContent;

@end
