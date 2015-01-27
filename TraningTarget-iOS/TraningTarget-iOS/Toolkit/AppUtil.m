//
//  AppUtil.m
//  Template
//
//  Created by zhangkai on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "AppUtil.h"
#import "Macros.h"
#import "Config.h"

@implementation AppUtil

+ (InterfaceIdiom)interfaceIdiom {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (WinSize.height == 736 || WinSize.width == 736) {
            return InterfaceIdiomPhone6Plus;
        } else if (WinSize.height == 667 || WinSize.width == 667) {
            return InterfaceIdiomPhone6;
        } else if (WinSize.height == 568 || WinSize.width == 568) {
            return InterfaceIdiomPhone5;
        } else {
            return InterfaceIdiomPhone4;
        }
    } else {
        return InterfaceIdiomPad;
    }
}

+ (NSString *)appDisplayName {
    return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (CGFloat)contentScaleFactor {
    if (InterfaceIdiomPhone6 == [AppUtil interfaceIdiom]) {
        // iPhone 6
        return 1.18;
    } else if (InterfaceIdiomPhone6Plus == [AppUtil interfaceIdiom]) {
        // iPhone 6 Plus
        return 1.30;
    }
    return 1.0;
}

+ (NSString *)floatFormat:(double)value
{
    int tempInt = value * 100;
    
    if (tempInt%100 == 0) {
        return  [NSString stringWithFormat:@"%d",tempInt/100];
    }else if (tempInt%10 == 0){
        return  [NSString stringWithFormat:@"%.1f",tempInt/100.0];
    }else{
        if (((int)(value * 1000) % 10) >= 5) {
            return  [NSString stringWithFormat:@"%.2f",tempInt/100.0 + 0.01];
        }else {
            return  [NSString stringWithFormat:@"%.2f",tempInt/100.0];
        }
    }
    
}

@end
