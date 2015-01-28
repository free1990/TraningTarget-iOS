//
//  Teacher
//  UIViewController+AbnormalDisplay.m
//
//  Created by John on 14-12-23.
//  Copyright (c) 2014年 FClassroom. All rights reserved.
//

#import "UIViewController+AbnormalDisplay.h"
#import <objc/runtime.h>
#import "Config.h"
#import "Macros.h"

@implementation UIViewController (AbnormalDisplay)

static const char *kMGEmptyDataViewKey = "kMGEmptyDataViewKey";
static const char *kMGReloadButtonViewKey = "kMGReloadButtonViewKey";
static const char *kMGTextTipViewKey = "kMGTextTipViewKey";

//custom set && get method
- (void)setEmptyDataView:(UIImageView *)emptyDataView {
    objc_setAssociatedObject(self, kMGEmptyDataViewKey, emptyDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)emptyDataView {
    
    UIImageView *emptyDataView = objc_getAssociatedObject(self, kMGEmptyDataViewKey);
    
    if (!emptyDataView) {
    
        UIImage *myImage = [UIImage imageNamed:@"no_result_common"];
        emptyDataView = [[UIImageView alloc] initWithImage:myImage];
        emptyDataView.center = WinCenter;
        emptyDataView.backgroundColor = [UIColor clearColor];
        emptyDataView.contentMode = UIViewContentModeCenter;
        [emptyDataView setHidden:YES];
        [self.view addSubview:emptyDataView];
        
        [self setEmptyDataView:emptyDataView];
    }
    
    return emptyDataView;
}

- (void)setReloadButton:(UIButton *)reloadButton {
    objc_setAssociatedObject(self, kMGReloadButtonViewKey, reloadButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)reloadButton {
    
    UIButton *reloadButton = objc_getAssociatedObject(self, kMGReloadButtonViewKey);
    
    if (!reloadButton) {
        
        reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [reloadButton setTitle:NSLocalizedString(@"重新加载", nil) forState:UIControlStateNormal];
        
        reloadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        reloadButton.layer.cornerRadius = 2.0f;
        reloadButton.layer.borderWidth = 0.5f;
        reloadButton.frame = CGRectMake(0, 0, 107, 41);
        reloadButton.center = WinCenter;
        reloadButton.layer.borderColor = RGBA_COLOR(0x89, 0x89, 0x89, 0xFF).CGColor;
        [reloadButton setTitleColor:RGBA_COLOR(0x8E, 0x8E, 0x8E, 0xFF) forState:UIControlStateNormal];
        reloadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        reloadButton.backgroundColor = [UIColor whiteColor];
        
        [reloadButton setHidden:YES];
        [self.view addSubview:reloadButton];
        
        [self setReloadButton:reloadButton];
    }
    
    return reloadButton;
}

- (void)setTextTip:(UILabel *)textTip {
    objc_setAssociatedObject(self, kMGTextTipViewKey, textTip, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)textTip {
    
    UILabel *textTip = objc_getAssociatedObject(self, kMGTextTipViewKey);
    
    if (!textTip) {
        
        textTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
        textTip.center = CGPointMake(self.view.width*3/2, (self.view.height)/2 - 64);
        textTip.textAlignment = NSTextAlignmentCenter;
        textTip.text = NSLocalizedString(@"暂无考试统计信息", nil);
        textTip.font = [UIFont systemFontOfSize:16];
        textTip.textColor = RGBA_COLOR(0xCD, 0xD5, 0xDD, 0xFF);
        textTip.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:textTip];

        [textTip setHidden:YES];
        
        [self.view addSubview:textTip];
        
        [self setTextTip:textTip];
    }
    return textTip;
}

//imageview tip
-(void)showEmptyDataViewAtPosition:(CGPoint)point{
    
    [[self reloadButton] setHidden:YES];
    
    [[self emptyDataView] setHidden:NO];
    
    [self.view bringSubviewToFront:[self emptyDataView]];
    [self emptyDataView].center = point;
}

-(void)hideEmptyDataView{
    [[self emptyDataView] setHidden:YES];
}

//reload button
-(void)showReloadButtonAtPosition:(CGPoint)point{
    
    [[self emptyDataView] setHidden:YES];
    [[self textTip] setHidden:YES];
    
    [[self reloadButton] setHidden:NO];
    [self.view bringSubviewToFront:[self reloadButton]];
    [self reloadButton].center = point;
}

-(void)addReloadButtonAction:(NSString *)selectorString{
    SEL sel = NSSelectorFromString(selectorString);
    [[self reloadButton] addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
}

-(void)hideReloadButton{
    [[self reloadButton] setHidden:YES];
}

//text tip
-(void)showEmptyDataTextAtPosition:(CGPoint)point{
    
    [[self reloadButton] setHidden:YES];
    
    [[self textTip] setHidden:NO];
    [self.view bringSubviewToFront:[self textTip]];
    [self textTip].center = point;
}

-(void)hideEmptyDataText{
    [[self textTip] setHidden:YES];
}


@end
