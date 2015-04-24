//
//  AppUtil.h
//  Template
//
//  Created by zhangkai on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    InterfaceIdiomPhone6Plus,
    InterfaceIdiomPhone6,
	InterfaceIdiomPhone5,
	InterfaceIdiomPhone4,
	InterfaceIdiomPad
} InterfaceIdiom;

@interface AppUtil : NSObject

/**
 * 获取当前屏幕类型
 */
+ (InterfaceIdiom)interfaceIdiom;

/**
 * 获取app名称
 */
+ (NSString *)appDisplayName;

/**
 * 获取app版本信息
 */
+ (NSString *)appVersion;

/**
 * 内容缩放因子，用来适配iPhone 6, iPhone 6 plus
 */
+ (float)contentScaleFactor;

+ (NSString *)floatFormat:(double)value;

/**
 * save image to NSDocumentDirectory, YYYYMMdd_HHmmss_flag.jpg
 */
+ (NSString *)saveImage:(UIImage *)image withFlag:(NSString *)flag;

/**
 * eg: increase free memory to 200MB
 */
+ (void)increaseFreeMemoryTo:(int)MB;

/**
 * 文件大小，单位byte
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)path;


@end
