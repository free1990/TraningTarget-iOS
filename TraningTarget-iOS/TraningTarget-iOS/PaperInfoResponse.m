//
//  PaperInfoResponse.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "PaperInfoResponse.h"
#import "NSObject+GetintegerValue.h"

@implementation PaperInfoResponse

- (void)parseResponse:(NSDictionary *)response {
    [super parseResponse:response];
    
    if (self.isSuccess) {
        NSDictionary *data = [response objectForKey:@"data"];
        
        
        
        self.paper_id = [self getInterValue:[data objectForKey:@"id"]];
        
        self.paper_name = [data objectForKey:@"name"];
        self.paper_title = [data objectForKey:@"title"];
        self.paper_subTitle = [data objectForKey:@"subTitle"];

        self.paper_schoolId = [self getInterValue:[data objectForKey:@"schoolId"]];
        
        
        self.paper_subjectId = [self getInterValue:[data objectForKey:@"subjectId"]];
        self.paper_gradeId = [self getInterValue:[data objectForKey:@"gradeId"]];
        
        self.paper_status = [self getInterValue:[data objectForKey:@"status"]];
        self.paper_score = [self getInterValue:[data objectForKey:@"score"]];
        
        self.paper_printFormat = [data objectForKey:@"printFormat"];
        
        self.paper_accountId = [self getInterValue:[data objectForKey:@"accountId"]];
        
        NSDictionary *examGroup = [data objectForKey:@"examGroup"];
        
        
        if (examGroup) {
            
            self.paper_examGroup.paper_examGroup_id = [self getInterValue:[examGroup objectForKey:@"id"]];
            
            self.paper_examGroup.paper_examGroup_name = [examGroup objectForKey:@"name"];
            
            self.paper_examGroup.paper_schoolId = [self getInterValue:[examGroup objectForKey:@"schoolId"]];
            self.paper_examGroup.paper_gradeId = [self getInterValue:[examGroup objectForKey:@"gradeId"]];
            self.paper_examGroup.paper_status = [self getInterValue:[examGroup objectForKey:@"status"]];
        }
        
        self.paper_totalPage = [self getInterValue:[data objectForKey:@"totalPage"]];
        self.paper_published = [self getInterValue:[data objectForKey:@"published"]];
        self.paper_contentBinSheet = [data objectForKey:@"contentBinSheet"];
        self.paper_contentBinText = [data objectForKey:@"contentBinText"];
        
        self.paper_publishedDate = [data objectForKey:@"publishedDate"];
        self.paper_updateDate = [data objectForKey:@"updateDate"];
        
        self.paper_produceDate = [data objectForKey:@"produceDate"];
        self.paper_readTeacher = [data objectForKey:@"readTeacher"];
        
        //examPapers
        NSArray *papersArray = [data objectForKey:@"examPapers"];
        
        if (papersArray) {
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDict in papersArray) {
                
                Paper_examPaper *paper = [[Paper_examPaper alloc] init];
                
                paper.paper_examPaper_id = [self getInterValue:[tempDict objectForKey:@"id"]];
                
                paper.paper_examPaper_examId = [self getInterValue:[tempDict objectForKey:@"examId"]];
                paper.paper_examPaper_pageNo = [self getInterValue:[tempDict objectForKey:@"pageNo"]];
                paper.paper_examPaper_pointType = [self getInterValue:[tempDict objectForKey:@"pointType"]];
                paper.paper_examPaper_sequence = [self getInterValue:[tempDict objectForKey:@"sequence"]];
                paper.paper_examPaper_schoolId = [self getInterValue:[tempDict objectForKey:@"schoolId"]];
                paper.paper_examPaper_status = [self getInterValue:[tempDict objectForKey:@"status"]];
                //examQuestion暂时不解析(没有看到数据格式)
                paper.paper_examPaper_ifCrossPage = [self getInterValue:[tempDict objectForKey:@"ifCrossPage"]];
                paper.paper_examPaper_direction = [tempDict objectForKey:@"direction"];
                
                [tempArray addObject:paper];
            }
            
            self.paper_examPapers = tempArray;
        }
        
        NSArray *parentsArray = [data objectForKey:@"parents"];
        
        self.paper_parents = [self formatDataWith:parentsArray];
    
        NSDictionary *contentDic = [data objectForKey:@"content"];
        if (contentDic) {
            self.paper_content.paperContent_id = [self getInterValue:[contentDic objectForKey:@"id"]];
            self.paper_content.paperContent_contentBinSheet = [contentDic objectForKey:@"contentBinSheet"];
            self.paper_content.paperContent_contentBinText = [contentDic objectForKey:@"contentBinText"];
            self.paper_content.paperContent_docPath = [contentDic objectForKey:@"docPath"];
        }
        
        self.paper_docPath = [data objectForKey:@"docPath"];
        self.paper_clzssIds = [self getInterValue:[data objectForKey:@"clzssIds"]];
        self.paper_examType = [self getInterValue:[data objectForKey:@"examType"]];
        self.paper_version = [data objectForKey:@"version"];
        self.paper_deleteExamQuestions = [data objectForKey:@"deleteExamQuestions"];
        self.paper_deleteExamPapers = [data objectForKey:@"deleteExamPapers"];
    }
}

- (NSInteger)getInterValue:(id)object
{
    NSInteger result = 0;
    if (! [self isExist:object]) {
        result = 0;
    }else{
        if ([object performSelector:@selector(integerValue)]) {
            result = [object integerValue];
        }
    }
    return result;
}

- (NSArray *)formatDataWith:(NSArray *)array{
    NSArray *resultArray;
    
    if (array && [array count]>0) {
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in array) {
            
            NSLog(@"++++++++++++> %ld", [[tempDict objectForKey:@"id"] integerValue]);
            
            Paper_parent *temp = [[Paper_parent alloc] init];
            
            temp.paper_parent_id = [self getInterValue:[tempDict objectForKey:@"id"]];
            temp.paper_parent_examPaperId = [self getInterValue:[tempDict objectForKey:@"examPaperId"]];
            temp.paper_parent_questionType = [self getInterValue:[tempDict objectForKey:@"questionType"]];
            temp.paper_parent_rootId = [self getInterValue:[tempDict objectForKey:@"rootId"]];
            temp.paper_parent_parentId = [self getInterValue:[tempDict objectForKey:@"parentId"]];
            
            NSArray *childrenArray = [tempDict objectForKey:@"children"];
            temp.paper_parent_children = [self formatDataWith:childrenArray];
            
            temp.paper_parent_questionId = [self getInterValue:[tempDict objectForKey:@"questionId"]];
            temp.paper_parent_questionNo = [tempDict objectForKey:@"questionNo"];
            temp.paper_parent_typeName = [tempDict objectForKey:@"typeName"];
            temp.paper_parent_score = [self getInterValue:[tempDict objectForKey:@"score"]];
            temp.paper_parent_sequence = [self getInterValue:[tempDict objectForKey:@"sequence"]];
            temp.paper_parent_scoreLimit = [self getInterValue:[tempDict objectForKey:@"scoreLimit"]];
            temp.paper_parent_scoreStep = [self getInterValue:[tempDict objectForKey:@"scoreStep"]];
            temp.paper_parent_optionCount = [self getInterValue:[tempDict objectForKey:@"optionCount"]];
            temp.paper_parent_answer = [tempDict objectForKey:@"answer"];
            temp.paper_parent_subScores = [tempDict objectForKey:@"subScores"];
            temp.paper_parent_subLengths = [tempDict objectForKey:@"subLengths"];
            temp.paper_parent_contentHtml = [tempDict objectForKey:@"contentHtml"];
            temp.paper_parent_contentImage = [tempDict objectForKey:@"contentImage"];
            temp.paper_parent_docPath = [tempDict objectForKey:@"docPath"];
            temp.paper_parent_contentBin = [tempDict objectForKey:@"contentBin"];
            temp.paper_parent_contentDoc = [tempDict objectForKey:@"contentDoc"];
            temp.paper_parent_answerSheetContent = [tempDict objectForKey:@"answerSheetContent"];
            temp.paper_parent_parent_id = [self getInterValue:[tempDict objectForKey:@"parent_id"]];
            temp.paper_parent_temp_id = [self getInterValue:[tempDict objectForKey:@"temp_id"]];
            temp.paper_parent_schoolId = [self getInterValue:[tempDict objectForKey:@"schoolId"]];
            temp.paper_parent_questionTitle = [tempDict objectForKey:@"questionTitle"];
            temp.paper_parent_ifCollected  = [self getInterValue:[tempDict objectForKey:@"ifCollected"]];
            
            temp.paper_parent_ifRelated = [self getInterValue:[tempDict objectForKey:@"ifRelated"]];
            temp.paper_parent_knowledges = [tempDict objectForKey:@"knowledges"];
            
            [dataArray addObject:temp];
        }
        
        resultArray = dataArray;
    }
    
    return resultArray;
    
}

@end
