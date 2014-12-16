//
//  JKAlertView.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/16.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectIndex)(int idx);

static BOOL isAlertHasShow = NO;

@interface JKUpdateAlertView : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *alert;
@property (strong, nonatomic) NSString *appId;

+ (instancetype)initJKAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

+ (BOOL)alertHasShow;

//需要返回的时候可以block回调
- (void)selectIndex:(selectIndex)temp;

@end
