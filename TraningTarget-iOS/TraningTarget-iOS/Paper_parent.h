//
//  Paper_parent.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper_parent : NSObject

@property (nonatomic, assign) NSInteger paper_parent_id;
@property (nonatomic, assign) NSInteger paper_parent_examPaperId;
@property (nonatomic, assign) NSInteger paper_parent_questionType;
@property (nonatomic, assign) NSInteger paper_parent_rootId;
@property (nonatomic, assign) NSInteger paper_parent_parentId;

@property (nonatomic, strong) NSArray *paper_parent_children;

@property (nonatomic, assign) NSInteger paper_parent_questionId;
@property (nonatomic, strong) NSString *paper_parent_questionNo;
@property (nonatomic, strong) NSString *paper_parent_typeName;
@property (nonatomic, assign) float paper_parent_score;

@property (nonatomic, assign) NSInteger paper_parent_sequence;
@property (nonatomic, assign) float paper_parent_scoreLimit;
@property (nonatomic, assign) float paper_parent_scoreStep;
@property (nonatomic, assign) NSInteger paper_parent_optionCount;
@property (nonatomic, strong) NSString *paper_parent_answer;

@property (nonatomic, strong) NSString *paper_parent_subScores;
@property (nonatomic, strong) NSString *paper_parent_subLengths;

@property (nonatomic, strong) NSString *paper_parent_contentHtml;
@property (nonatomic, strong) NSString *paper_parent_contentImage;

@property (nonatomic, strong) NSString *paper_parent_docPath;
@property (nonatomic, strong) NSString *paper_parent_contentBin;
@property (nonatomic, strong) NSString *paper_parent_contentDoc;
@property (nonatomic, strong) NSString *paper_parent_answerSheetContent;

@property (nonatomic, assign) NSInteger paper_parent_parent_id;
@property (nonatomic, assign) NSInteger paper_parent_temp_id;
@property (nonatomic, assign) NSInteger paper_parent_schoolId;

@property (nonatomic, strong) NSString *paper_parent_questionTitle;

@property (nonatomic, assign) NSInteger paper_parent_ifCollected;
@property (nonatomic, assign) NSInteger paper_parent_ifRelated;

@property (nonatomic, strong) NSArray *paper_parent_knowledges;

@end
