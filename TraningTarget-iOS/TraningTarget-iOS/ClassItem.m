//
//  ClassItem.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "ClassItem.h"

@implementation ClassItem

-(NSComparisonResult)titleCompare:(ClassItem *)other
{
    
    NSLog(@"------------%@", other.classTitleName);
    NSComparisonResult comparisonResult ;
    
    if ( comparisonResult == NSOrderedSame ) {
        comparisonResult = [self.classTitleName caseInsensitiveCompare:other.classTitleName];
    }
    
    return comparisonResult;
}

@end
