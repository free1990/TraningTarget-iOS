//
//  Macros.h
//  Template
//
//  Created by work on 9/3/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "UIView+Frame.h"
#import "CoreData+MagicalRecord.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define WinSize CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define WinCenter CGPointMake(WinSize.width / 2, WinSize.height / 2)
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 255.0]
#define Alert(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil] show]
#define TRIM_STRING(string) [(string) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

/*
 * if DEBUG is not defined, or if it is 0 then
 * all DLOGXXX macros will be disabled
 *
 * if DEBUG==1 then:
 * DLOG() will be enabled
 * DLOGERROR() will be enabled
 * DLOGINFO()will be disabled
 *
 * if DEBUG==2 or higher then:
 * DLOG() will be enabled
 * DLOGERROR() will be enabled
 * DLOGINFO()will be enabled
 */
#if !defined(DEBUG) || DEBUG == 0
#define DLOG(format, ...) do {} while (0)
#define DLOGINFO(format, ...) do {} while (0)
#define DLOGERROR(format, ...) do {} while (0)

#elif DEBUG == 1
#define DLOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGERROR(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGINFO(format, ...) do {} while (0)

#elif DEBUG > 1
#define DLOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGERROR(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGINFO(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
