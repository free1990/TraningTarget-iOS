//
//  UIViewController+AbnormalDisplay.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/24.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#define WinSize CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define WinCenter CGPointMake(WinSize.width / 2, WinSize.height / 2)
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 255.0]

#import "UIViewController+AbnormalDisplay.h"
#import <objc/runtime.h>

@implementation UIViewController (AbnormalDisplay)

static const char *kMGEmptyDataViewKey = "kMGEmptyDataViewKey";
static const char *kMGReloadButtonViewKey = "kMGReloadButtonViewKey";

//custom set && get method
- (void)setEmptyDataView:(UIImageView *)emptyDataView {
    objc_setAssociatedObject(self, kMGEmptyDataViewKey, emptyDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)emptyDataView {
    
    UIImageView *emptyDataView = objc_getAssociatedObject(self, kMGEmptyDataViewKey);
    
    if (!emptyDataView) {
        
        UIImage *myImage = [UIImage imageNamed:@"no_result_common"];
        self.emptyDataView = [[UIImageView alloc] initWithImage:myImage];
        self.emptyDataView.center = WinCenter;
        self.emptyDataView.backgroundColor = [UIColor clearColor];
        self.emptyDataView.contentMode = UIViewContentModeCenter;
        [self.emptyDataView setHidden:YES];
        [self.view addSubview:self.emptyDataView];
        
        [self setEmptyDataView:self.emptyDataView];
        [self.view addSubview:emptyDataView];
        
        emptyDataView = self.emptyDataView;
    }
    
    return emptyDataView;
}

- (void)setReloadButton:(UIButton *)reloadButton {
    objc_setAssociatedObject(self, kMGReloadButtonViewKey, reloadButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)reloadButton {
    
    UIButton *reloadButton = objc_getAssociatedObject(self, kMGReloadButtonViewKey);
    
    if (!reloadButton) {
        
        self.reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.reloadButton setTitle:NSLocalizedString(@"重新加载", nil)
                        forState:UIControlStateNormal];
        
        self.reloadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.reloadButton.layer.cornerRadius = 2.0f;
        self.reloadButton.layer.borderWidth = 0.5f;
        self.reloadButton.frame = CGRectMake(0, 0, 107, 41);
        self.reloadButton.center = WinCenter;
        self.reloadButton.layer.borderColor = RGBA_COLOR(0x89, 0x89, 0x89, 0xFF).CGColor;
        [self.reloadButton setTitleColor:RGBA_COLOR(0x8E, 0x8E, 0x8E, 0xFF) forState:UIControlStateNormal];
        self.reloadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.reloadButton.backgroundColor = [UIColor whiteColor];
        
        [self.reloadButton setHidden:YES];
        [self.view addSubview:self.reloadButton];
        
        reloadButton = self.reloadButton;
        
        [self setReloadButton:self.reloadButton];
    }
    return reloadButton;
}

//control interface
-(void)showEmptyDataViewAtPosition:(CGPoint)point{
    
    [self.reloadButton setHidden:YES];
    
    [self.emptyDataView setHidden:NO];
    [self.emptyDataView bringSubviewToFront:self.view];
    self.emptyDataView.center = point;
}

-(void)hideEmptyDataView{
    [self.emptyDataView setHidden:YES];
}

-(void)showReloadButtonAtPosition:(CGPoint)point{
    
    [self.emptyDataView setHidden:YES];
    
    [self.reloadButton setHidden:NO];
    [self.reloadButton bringSubviewToFront:self.view];
    self.reloadButton.center = point;
}

-(void)addReloadButtonAction:(NSString *)selectorString{
    SEL sel = NSSelectorFromString(selectorString);
    [self.reloadButton addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
}

-(void)hideReloadButton{
    [self.reloadButton setHidden:YES];
}

@end
