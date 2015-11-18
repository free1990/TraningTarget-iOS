//
//  JKDoubleSelectView.h
//  test
//
//  Created by John on 14-10-15.
//  Copyright (c) 2014年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^updateType)(int qId, int tId);

@interface JKDoubleSelectView : UIView<UITableViewDelegate, UITableViewDataSource,
    UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSMutableArray *secondAry;
@property (nonatomic, strong) NSMutableArray *displayAry;
@property (nonatomic, strong) UITableView *fristList;
@property (nonatomic, strong) UITableView *secondList;
@property (nonatomic, strong) updateType myUpdate;
@property (nonatomic, assign) int questionTypeId;
@property (nonatomic, assign) int typeId;

- (void)tableListShowWith:(NSMutableArray *)data withIdx:(int)qid;
- (void)updateCallBack:(updateType)temp;
- (id)initWithFrame:(CGRect)frame withTypeId:(int)tId andQestionId:(int)qId;
@end
