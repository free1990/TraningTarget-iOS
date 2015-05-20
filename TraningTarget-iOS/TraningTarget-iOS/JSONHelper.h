//
//  JSONHelper.h
//  opencv-usage
//
//  Created by John on 15/3/17.
//  Copyright (c) 2015年 FClassroom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

@property (nonatomic, strong) NSDictionary *dic;
- (void)readLocalJSON;
@end
