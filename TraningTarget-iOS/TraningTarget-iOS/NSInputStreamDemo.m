//
//  NSInputStreamDemo.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/8.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "NSInputStreamDemo.h"
#import "Reader.h"

@interface NSInputStreamDemo ()

@property (nonatomic, strong) Reader *reader;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end

@implementation NSInputStreamDemo

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"NSInputStream";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addViews];
}

- (void)addViews
{
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = CGRectMake(0, 10, 320, 100);
    [self.button addTarget:self action:@selector(import:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"Press Me" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 120, 320, 64)];
    slider.continuous = YES;
    [slider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 64)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
}

- (void)sliderMoved:(UISlider *)sender;
{
    self.label.text = [NSString stringWithFormat:@"%g", [sender value]];
}

- (void)import:(id)sender
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Clarissa Harlowe" withExtension:@"txt"];
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]], @"Please download the sample data");
    
    self.reader = [[Reader alloc] initWithFileAtURL:fileURL];
    [self.reader enumerateLinesWithBlock:^(NSUInteger i, NSString *line){
        if ((i % 2000ull) == 0) {
            NSLog(@"i: %ld", i);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.button setTitle:line forState:UIControlStateNormal];
            }];
        }
    } completionHandler:^(NSUInteger numberOfLines){
        NSLog(@"lines: %ld", numberOfLines);
        [self.button setTitle:@"Done" forState:UIControlStateNormal];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
