//
//  JSONHelper.m
//  opencv-usage
//
//  Created by John on 15/3/17.
//  Copyright (c) 2015年 FClassroom. All rights reserved.
//

#import "JSONHelper.h"
#import "ExamPaperInfo.h"

@implementation JSONHelper

- (void)readLocalJSON
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    
    self.dic = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    NSLog(@"json---> %@", self.dic);
}

@end
