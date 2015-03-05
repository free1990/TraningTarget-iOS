//
//  PaperInfoResponse.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "HTTPResponse.h"
#import "Paper_Content.h"
#import "Paper_examGroup.h"
#import "Paper_examPaper.h"
#import "Paper_parent.h"

@interface PaperInfoResponse : HTTPResponse

@property (nonatomic, assign) NSInteger paper_id;
@property (nonatomic, strong) NSString *paper_name;
@property (nonatomic, strong) NSString *paper_title;
@property (nonatomic, strong) NSString *paper_subTitle;
@property (nonatomic, assign) NSInteger paper_schoolId;
@property (nonatomic, assign) NSInteger paper_subjectId;
@property (nonatomic, assign) NSInteger paper_gradeId;
@property (nonatomic, assign) NSInteger paper_status;
@property (nonatomic, assign) double paper_score;
@property (nonatomic, strong) NSString *paper_printFormat;
@property (nonatomic, assign) NSInteger paper_accountId;
@property (nonatomic, strong) Paper_examGroup *paper_examGroup;
@property (nonatomic, assign) NSInteger paper_totalPage;
@property (nonatomic, assign) NSInteger paper_published;
@property (nonatomic, strong) NSString *paper_contentBinSheet;
@property (nonatomic, strong) NSString *paper_contentBinText;
@property (nonatomic, strong) NSString *paper_publishedDate;
@property (nonatomic, strong) NSString *paper_updateDate;
@property (nonatomic, strong) NSString *paper_produceDate;
@property (nonatomic, strong) NSString *paper_readTeacher;

@property (nonatomic, strong) NSArray *paper_examPapers;

@property (nonatomic, strong) NSArray *paper_parents;

//content
@property (nonatomic, strong) Paper_Content *paper_content;

@property (nonatomic, strong) NSString *paper_docPath;
@property (nonatomic, assign) NSInteger paper_clzssIds;
@property (nonatomic, assign) NSInteger paper_examType;
@property (nonatomic, strong) NSString *paper_version;
@property (nonatomic, strong) NSString *paper_deleteExamQuestions;
@property (nonatomic, strong) NSString *paper_deleteExamPapers;

@end
