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

@synthesize foo;
@synthesize _foo;

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
    
    NSString *nullString = nil;
    
    nullString = (NSString *)[NSNull null];
    
    NSLog(@"----------%d", [@"<null>" length]);
    
    int a=1,b=2;
    printf("%f\n",S(a+b));
    
#pragma mark - viewDidLoad串行的提交任务
    // 死锁测试
    NSLog(@"死锁测试");
    // sync到当前线程的block将会引起死锁，所以只会Log出1来后主线程就进入死锁状态，不会继续执行。
    //究其原因，还要看dispatch_sync做的事，它将一个block插入到queue中，这点和async没有区别，区别在于sync会等待到这个block执行完成后才回到调用点继续执行，而这个block的执行还依仗着主线程中dispatch_sync调用的结束，所以造成了循环等待，导致死锁。
    dispatch_queue_t main = dispatch_get_main_queue();
//    dispatch_sync(main, ^{
//        NSLog(@"John在测试....");
//    });
    
    
#pragma mark -vip give me a point
    // 之前居然把这个问题看成了在viewDidLoad里面去串行的向主线程提交任务
    NSLog(@"异步提交串行的任务测试");
    
    // 异步提交后，main线程会等待空闲的时机来执行这个提交的任务，然后就木有然后了，然后就卡主了。
    // 形成死锁，和上面原因是一样的
//    dispatch_async(main, ^{
//        
//        NSLog(@"是否异步提交");
//        dispatch_sync(main, ^{
//            NSLog(@"John在测试....");
//        });
//        NSLog(@"哈哈哈哈哈");
//    });
    
    
    // 会卡主这个线程
//    dispatch_queue_t queue = dispatch_queue_create("com.zhaoyang.gcd.test", NULL);
//    dispatch_async(queue, ^{
//
//        NSLog(@"是否异步提交");
//        dispatch_sync(queue, ^{
//            NSLog(@"John在测试....");
//        });
//        NSLog(@"哈哈哈哈哈");
//    });
    
    
    //5.5 * 1 + 2*1 +2;宏，全部乘开
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    NSArray *fixedWords = @[@"Eeny", @"Meeny", @"Miny", @"Moe", @"Catch", @"A", @"Tiger", @"By", @"His", @"Toe"];
    NSMutableArray *mutWords = [[NSMutableArray alloc] initWithArray:fixedWords];
    self.words = [mutWords copy];
    
    NSLog(@"self.words = %@", [self.words class]);
    
    
    NSLog(@"foo = %@",[_foo class]);
    
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
