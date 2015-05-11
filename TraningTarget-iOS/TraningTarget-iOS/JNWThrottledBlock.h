//
//  JNWThrottledBlock.h
//  TraningTarget-iOS
//
//  Created by John on 15/5/11.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNWThrottledBlock : NSObject

+ (void)runBlock:(void (^)())block withIdentifier:(NSString *)identifier throttle:(CFTimeInterval)bufferTime;

@end
