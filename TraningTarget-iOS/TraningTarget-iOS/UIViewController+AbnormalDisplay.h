//
//  Teacher
//  UIViewController+AbnormalDisplay.h
//
//  Created by John on 14-12-23.
//  Copyright (c) 2014年 FClassroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AbnormalDisplay)

-(void)showEmptyDataViewAtPosition:(CGPoint)point;
-(void)hideEmptyDataView;

-(void)showReloadButtonAtPosition:(CGPoint)point;
-(void)addReloadButtonAction:(NSString *)selectorString;
-(void)hideReloadButton;

-(void)showEmptyDataTextAtPosition:(CGPoint)point;
-(void)hideEmptyDataText;

@end
