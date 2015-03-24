//
//  ScanTitleView.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanTitleView : UIView

@property (strong, nonatomic) UILabel *titleLbl;

- (id)initWithFrame:(CGRect)frame;

- (void)setLableBadgeViewWithNum:(int)num;

@end
