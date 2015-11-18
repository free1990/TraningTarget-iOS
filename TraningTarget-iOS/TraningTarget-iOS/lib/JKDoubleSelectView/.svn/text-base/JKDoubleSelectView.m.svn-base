//
//  JKDoubleSelectView.m
//  test
//
//  Created by John on 14-10-15.
//  Copyright (c) 2014年 John. All rights reserved.
//

#import "JKDoubleSelectView.h"

#define HEIGHT_SELECT_LIST_MAX 200
#define HEIGHT_CELL 40

@implementation JKDoubleSelectView

- (id)initWithFrame:(CGRect)frame withTypeId:(int)tId andQestionId:(int)qId
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _questionTypeId = qId;
        _typeId = tId;
        
        self.backgroundColor = RGBA_COLOR(0.0, 0.0, 0.0, 255*0.25);
        
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                               frame.size.width,
                                                               frame.size.height - HEIGHT_SELECT_LIST_MAX)];
        [self addSubview:top];
        
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tap)];
        singleRecognizer.numberOfTapsRequired = 1;
        [top addGestureRecognizer:singleRecognizer];
        
        self.fristList = [[UITableView alloc] initWithFrame:CGRectMake(5,
                                                                       frame.size.height - HEIGHT_SELECT_LIST_MAX - 5,
                                                                       frame.size.width/2 - 5, HEIGHT_SELECT_LIST_MAX)
                                                      style:UITableViewStylePlain];
        self.fristList.delegate = self;
        self.fristList.dataSource = self;
        self.fristList.rowHeight = HEIGHT_CELL;
        if ([self.fristList respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.fristList setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([self.fristList respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.fristList setSeparatorInset:UIEdgeInsetsZero];
        }
        [self addSubview:self.fristList];
        self.fristList.layer.cornerRadius = 3.0;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2,
                                                                frame.size.height - HEIGHT_SELECT_LIST_MAX - 5,
                                                                1,
                                                                HEIGHT_SELECT_LIST_MAX)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        
        self.secondList = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width/2 + 1,
                                                                        frame.size.height - HEIGHT_SELECT_LIST_MAX - 5,
                                                                        frame.size.width/2 - 5,
                                                                        HEIGHT_SELECT_LIST_MAX)
                                                       style:UITableViewStylePlain];
        self.secondList.delegate = self;
        self.secondList.dataSource = self;
        self.secondList.rowHeight = HEIGHT_CELL;
        self.secondList.tag = 1;
        if ([self.secondList respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.secondList setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([self.secondList respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.secondList setSeparatorInset:UIEdgeInsetsZero];
        }
        [self addSubview:self.secondList];
        self.secondList.layer.cornerRadius = 3.0;
    }
    return self;
}


#pragma mark - Private methods
- (void)tap
{
    if (self.myUpdate) {
        self.myUpdate(_questionTypeId,_typeId);
    }
}

- (void)updateCallBack:(updateType)temp
{
    self.myUpdate = temp;
}

- (void)tableListShowWith:(NSMutableArray *)data withIdx:(int)qid
{
    self.dataAry = [[NSMutableArray alloc] initWithObjects:@"总分",@"题型",@"大题", nil];
    self.secondAry = data;
    if (qid != 0) {
        self.displayAry = [data objectAtIndex:qid - 1];
    }
    [self.fristList reloadData];
    [self.secondList reloadData];
}

#pragma mark - Public methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag){
        if (_questionTypeId == 0) {
            return 0;
        }
        return [self.displayAry count];
    }
    return [self.dataAry count];
}

#pragma mark - Tableview datasource & delegates
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView
                                                dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    UILabel *myTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.secondList.width , cell.frame.size.height)];
    myTitle.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:myTitle];
    
    if (tableView.tag){
        myTitle.text = [self.displayAry objectAtIndex:indexPath.row];
        if (indexPath.row == _typeId) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        myTitle.text = [self.dataAry objectAtIndex:indexPath.row];
        if (indexPath.row == _questionTypeId) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag) {
        _typeId = (int)indexPath.row;
        [self.secondList reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.myUpdate) {
                self.myUpdate(_questionTypeId, _typeId);
            }
        });
        
    }else{
        
        _questionTypeId = (int)indexPath.row;
        [self.fristList reloadData];
        if (indexPath.row == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.myUpdate) {
                    self.myUpdate(0, -1);
                }
            });
            return;
        }
         self.displayAry = [self.secondAry objectAtIndex:indexPath.row - 1];
        [self.secondList reloadData];
    }
}

#pragma mark - Memory management
- (void)dealloc {
    DLOGINFO();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
