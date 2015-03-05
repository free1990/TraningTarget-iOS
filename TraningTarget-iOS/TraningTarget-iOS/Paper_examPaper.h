//
//  Paper_examPaper.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper_examPaper : NSObject

@property (nonatomic, assign) NSInteger paper_examPaper_id;
@property (nonatomic, assign) NSInteger paper_examPaper_examId;
@property (nonatomic, assign) NSInteger paper_examPaper_pageNo;
@property (nonatomic, assign) NSInteger paper_examPaper_pointType;
@property (nonatomic, assign) NSInteger paper_examPaper_sequence;
@property (nonatomic, assign) NSInteger paper_examPaper_schoolId;
@property (nonatomic, assign) NSInteger paper_examPaper_status;
@property (nonatomic, strong) NSArray *paper_examPaper_examQuestions;
@property (nonatomic, assign) NSInteger paper_examPaper_ifCrossPage;
@property (nonatomic, strong) NSString *paper_examPaper_direction;

@end
