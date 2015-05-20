//
//  VVStack.h
//  TraningTarget-iOS
//
//  Created by John on 15/5/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVStack : NSObject
- (void)push:(double)num;
- (double)top;
@property (nonatomic, strong) NSMutableArray *numbers; 
@end
