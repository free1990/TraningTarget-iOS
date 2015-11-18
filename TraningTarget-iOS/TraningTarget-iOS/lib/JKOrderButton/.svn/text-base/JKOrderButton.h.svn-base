//
//  JKButton.h
//  myButton
//
//  Created by John on 14-10-15.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^callBack)(BOOL isSelected);

@interface JKOrderButton : UIView

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isHighLight;
@property (nonatomic, strong) callBack myCallBack;

- (void)callbackByBlock:(callBack)block;
- (void)selectedState;
- (void)reSetState;
@end
