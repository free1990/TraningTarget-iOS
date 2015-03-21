//
//  JKPickView.h
//  MyPick
//
//  Created by John on 14-9-26.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^update)(NSString *year, NSString *month, NSString *day);
typedef void (^completeView)();



@interface JKPickView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *settedTime;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *completeBtn;
//@property (nonatomic, strong) update update;
@property (nonatomic, strong) completeView complete;
@property (nonatomic, strong) NSString *yearString;
@property (nonatomic, strong) NSString *monthString;
@property (nonatomic, strong) NSString *dayString;
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) NSString *settedTime;

- (id)initWithFrame:(CGRect)frame withBtn:(UIButton *)btn;
//- (void)selectIndexComtent:(update)block;
- (void)completeView:(completeView)block;
- (void)completePickerView;

@end
