//
//  Config.h
//  Teacher
//
//  Created by work on 9/23/14.
//  Copyright (c) 2014 FClassroom. All rights reserved.
//

// 是否生产环境
#define ProductionEnvironment   1

#if !defined(ProductionEnvironment) || ProductionEnvironment == 0

#define kServerDomain       @"http://120.131.64.134:20002/"

#else

//#define kServerDomain       @"http://data.fclassroom.com/"
#define kServerDomain       @"http://182.92.194.136:10002/"

#endif


/**
 * http://try.crashlytics.com
 * 下载 https://ssl-download-crashlytics-com.s3.amazonaws.com/mac/builds/Crashlytics-latest.zip
 * run脚本路径问题 http://cocoadocs.org/docsets/CrashlyticsFramework/2.2.2/
 */
#define kCrashlyticsAPIKey          @"4b8e3db513da9d2b77455c5325b69df772d2752d"
