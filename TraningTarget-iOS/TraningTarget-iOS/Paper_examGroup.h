//
//  Paper_examGroup.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper_examGroup : NSObject

@property (nonatomic, assign) NSInteger paper_examGroup_id;
@property (nonatomic, strong) NSString *paper_examGroup_name;
@property (nonatomic, assign) NSInteger paper_schoolId;
@property (nonatomic, assign) NSInteger paper_gradeId;
@property (nonatomic, assign) NSInteger paper_status;

@end
