//
//  UIViewController+AbnormalDisplay.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/24.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AbnormalDisplay)

@property (nonatomic, strong) UIImageView       *emptyDataView;
@property (nonatomic, strong) UIButton          *reloadButton;

-(void)showEmptyDataViewAtPosition:(CGPoint)point;
-(void)hideEmptyDataView;

-(void)showReloadButtonAtPosition:(CGPoint)point;
-(void)addReloadButtonAction:(NSString *)selectorString;
-(void)hideReloadButton;

@end
