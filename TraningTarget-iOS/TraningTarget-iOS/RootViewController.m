//
//  ViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RootViewController.h"
#import "RuntimeMsgForWarding.h"
#import "ClassSet.h"

#import "UINavigationBar+Awesome.h"
static int allocCount = 0;


@interface RootViewController ()

@end

@implementation RootViewController

// initialize 和 load
//    在不考虑开发者主动使用的情况下，系统最多会调用一次
//    如果父类和子类都被调用，父类的调用一定在子类之前
//    都是为了应用运行提前创建合适的运行环境
//    在使用时都不要过重地依赖于这两个方法，除非真正必要


+ (void)load{
    [super load];
    
//    调用时机比较早，运行环境有不确定因素。具体说来，在iOS上通常就是App启动时进行加载，但当load调用的时候，并不能保证所有类都加载完成且可用，必要时还要自己负责做auto release处理。
//    补充上面一点，对于有依赖关系的两个库中，被依赖的类的load会优先调用。但在一个库之内，调用顺序是不确定的。
//    对于一个类而言，没有load方法实现就不会调用，不会考虑对NSObject的继承。
//    一个类的load方法不用写明[super load]，父类就会收到调用，并且在子类之前。
//    Category的load也会收到调用，但顺序上在主类的load调用之后。
//    不会直接触发initialize的调用。
    
    NSLog(@"我被加载进内存了");
}

+ (void)initialize{
    [super initialize];
    
//    initialize的自然调用是在第一次主动使用当前类的时候（lazy，这一点和Java类的“clinit”的很像）。
//    在initialize方法收到调用时，运行环境基本健全。
//    initialize的运行过程中是能保证线程安全的。
//    和load不同，即使子类不实现initialize方法，会把父类的实现继承过来调用一遍。注意的是在此之前，父类的方法已经被执行过一次了，同样不需要super调用。
    
    NSLog(@"我被初始化了");
}

#define PT    5.5
#define S(x)  PT*x*x

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a=1,b=2;
    printf("%f\n",S(a+b));
    
    //5.5 * 1 + 2*1 +2;宏，全部乘开
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    self.title = @"Tree New bee";
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    _myTableView.separatorInset = UIEdgeInsetsZero;
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    _myTableView.rowHeight = 44;
    
    [self.view addSubview:_myTableView];
    
//    NSString *temp = @"33.41";
//    //float 转成double可以避免运算的时候的干扰
//    NSLog(@"----------> %f", [temp doubleValue]);
//    NSLog(@"----------> %f", [temp floatValue]*1000);
//    NSLog(@"----------> %f", ([temp floatValue]*1000)/10);
//    NSLog(@"----------> %f", (([temp floatValue]*1000)/10)/100);
    
    //线程测试
    NSThread *testThread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
    [testThread start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(beginRecognize)
                                                 name:@"CapturedImage" object:nil];
}

- (void)beginRecognize{
    
    NSLog(@"通知出现了");
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
}

- (void)testThread
{
    @autoreleasepool {
        
        [[NSThread currentThread] setName:@"AFNetworking"];
        
        NSLog(@"线程开始了, happy！");
        
        if ([NSThread isMainThread]) {
            NSLog(@"我是主线程");
        }else{
            NSLog(@"我不是主线程，我叫%@", [NSThread currentThread].name);
        }
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        if (runLoop == [NSRunLoop mainRunLoop]) {
            NSLog(@"我是主loop");
        }else{
            NSLog(@"我是子loop");
        }
        
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        NSLog(@"Port----> %@", [NSMachPort port]);
        
        [runLoop run];
    }
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ClassSet sharedClassGallery] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentiferId = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentiferId];
        
        allocCount ++ ;
    };
    
    ClassItem *item = [[ClassSet sharedClassGallery] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.classTitleName;
    
//    if (indexPath.row == ([[ClassSet sharedClassGallery] count] - 1)) {
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassItem *item = [[ClassSet sharedClassGallery] objectAtIndex:indexPath.row];
    
    UIViewController *temp = [[NSClassFromString(item.className) alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
//    Class *class = NSClassFromString();
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
