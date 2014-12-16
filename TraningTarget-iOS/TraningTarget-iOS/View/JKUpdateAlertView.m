//
//  JKAlertView.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/16.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "JKUpdateAlertView.h"
static JKUpdateAlertView *jkUpdate;

#define WinSize CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@implementation JKUpdateAlertView

+ (instancetype)initJKAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles{
    
    jkUpdate = nil;
    jkUpdate = [[JKUpdateAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    
    return jkUpdate;
}

+ (BOOL)alertHasShow
{
    return isAlertHasShow;
}

#pragma mark Private methods

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles{
    
    self = [super init];
    
    if (self) {
        
        if (isAlertHasShow == NO) {
            
            self.appId = @"942833276";
            self.alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
            
            [self.alert show];
            
            isAlertHasShow = YES;
        }
        
    }
    
    return self;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    isAlertHasShow = NO;
    
}



@end
