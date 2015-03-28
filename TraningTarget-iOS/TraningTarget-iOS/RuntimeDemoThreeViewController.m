//
//  RuntimeDemoThreeViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeDemoThreeViewController.h"

@interface RuntimeDemoThreeViewController ()

@end

@implementation RuntimeDemoThreeViewController

- (id)init{
    if (self = [super init]) {
        self.className   = @"Runtime Demo Three";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //交换系统方法
    [self methodExchange];
    
    //自定义方法实现
    [self methodSetImplementation];
    [self justLog2];
    [self justLog1];
    
    //类的版本号
//    __unsafe_unretained Class *temp = [RuntimeDemoThreeViewController class];
    NSLog(@"version--old-----%d", class_getVersion([RuntimeDemoThreeViewController class]));
    class_setVersion([RuntimeDemoThreeViewController class], 3);
    NSLog(@"version--new-----%d", class_getVersion([RuntimeDemoThreeViewController class]));
    
    //系统替换方法
    [self replaceMethod];
    [@"test" uppercaseString];
    
}

- (void) methodExchange {
    Method m1 = class_getInstanceMethod([NSString class],@selector(lowercaseString));
    Method m2 = class_getInstanceMethod([NSString class],@selector(uppercaseString));
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"%@", [@"sssAAAAss" lowercaseString]);
    NSLog(@"%@", [@"sssAAAAss" uppercaseString]);
}


- (void) justLog1 {
    NSLog(@"justLog1");
}
- (void) justLog2 {
    NSLog(@"justLog2");
}
- (void) methodSetImplementation {
    
    //justlog1 会作为justlog2的执行
    Method method = class_getInstanceMethod([RuntimeDemoThreeViewController class],@selector(justLog1));
    IMP originalImp = method_getImplementation(method);
    Method m1 = class_getInstanceMethod([RuntimeDemoThreeViewController class],@selector(justLog2));
    method_setImplementation(m1, originalImp);
}

IMP cFuncPointer;
//IMP cFuncPointer1;
//IMP cFuncPointer2;
//
NSString* CustomUppercaseString(id self,SEL _cmd){
    printf("真正起作用的是本函数CustomUppercaseString\r\n");
    return @"-----------";
}

//void CustomComponentsSeparatedByString(id self, SEL _cmd){
//     printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//}


//DEMO
//NSString* CustomUppercaseString(id self,SEL _cmd){
//    printf("真正起作用的是本函数CustomUppercaseString\r\n");
//    NSString *string = cFuncPointer(self,_cmd);
//    return string;
//}
//
//NSArray* CustomComponentsSeparatedByString(id self,SEL _cmd,NSString *str){
//    printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//    return cFuncPointer1(self,_cmd, str);
//}
//不起作用，求解释
//bool CustomIsEqualToString(id self,SEL _cmd,NSString *str) {
//    printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//    return cFuncPointer2(self,_cmd, str);
//}

- (void) replaceMethod{
//    cFuncPointer = [NSString instanceMethodForSelector:@selector(uppercaseString)];
    class_replaceMethod([NSString class],@selector(uppercaseString), (IMP)CustomUppercaseString,"@@:");
    
//    cFuncPointer1 = [NSString instanceMethodForSelector:@selector(componentsSeparatedByString:)];
//    class_replaceMethod([NSString class],@selector(componentsSeparatedByString:), (IMP)CustomComponentsSeparatedByString,"@@:@");
    
//    cFuncPointer2 = [NSString instanceMethodForSelector:@selector(isEqualToString:)];
//    class_replaceMethod([NSString class],@selector(isEqualToString:), (IMP)CustomIsEqualToString,"B@:@");
}

//---------------------------------------------------------
//C实现tableview
//#import <objc/runtime.h>
//#import <objc/message.h>
//#import <stdio.h>
//
//extern int UIApplicationMain (int argc,char *argv[],void *principalClassName,void *delegateClassName);
//
//
//struct Rect {
//    float x;
//    float y;
//    float width;
//    float height;
//};
//typedef struct Rect Rect;
//
//
//void *navController;
//static int numberOfRows =100;
//
//
//
//int tableView_numberOfRowsInSection(void *receiver,structobjc_selector *selector, void *tblview,int section) {
//    returnnumberOfRows;
//}
//
//void *tableView_cellForRowAtIndexPath(void *receiver,structobjc_selector *selector, void *tblview,void *indexPath) {
//    Class TableViewCell = (Class)objc_getClass("UITableViewCell");
//    void *cell = class_createInstance(TableViewCell,0);
//    objc_msgSend(cell, sel_registerName("init"));
//    char buffer[7];
//    int row = (int) objc_msgSend(indexPath, sel_registerName("row"));
//    sprintf (buffer, "Row %d", row);
//    void *label =objc_msgSend(objc_getClass("NSString"),sel_registerName("stringWithUTF8String:"),buffer);
//    objc_msgSend(cell, sel_registerName("setText:"),label);
//    return cell;
//}
//
//void tableView_didSelectRowAtIndexPath(void *receiver,structobjc_selector *selector, void *tblview,void *indexPath) {
//    Class ViewController = (Class)objc_getClass("UIViewController");
//    void * vc = class_createInstance(ViewController,0);
//    objc_msgSend(vc, sel_registerName("init"));
//    char buffer[8];
//    int row = (int) objc_msgSend(indexPath, sel_registerName("row"));
//    sprintf (buffer, "Item %d", row);
//    void *label =objc_msgSend(objc_getClass("NSString"),sel_registerName("stringWithUTF8String:"),buffer);
//    objc_msgSend(vc, sel_registerName("setTitle:"),label);
//    objc_msgSend(navController,sel_registerName("pushViewController:animated:"),vc,1);
//}
//
//void *createDataSource() {
//    Class superclass = (Class)objc_getClass("NSObject");
//    Class DataSource = objc_allocateClassPair(superclass,"DataSource",0);
//    class_addMethod(DataSource,sel_registerName("tableView:numberOfRowsInSection:"), (void(*))tableView_numberOfRowsInSection,nil);
//    class_addMethod(DataSource,sel_registerName("tableView:cellForRowAtIndexPath:"), (void(*))tableView_cellForRowAtIndexPath,nil);
//    objc_registerClassPair(DataSource);
//    returnclass_createInstance(DataSource,0);
//}
//
//void * createDelegate() {
//    Class superclass = (Class)objc_getClass("NSObject");
//    Class DataSource = objc_allocateClassPair(superclass,"Delegate",0);
//    class_addMethod(DataSource,sel_registerName("tableView:didSelectRowAtIndexPath:"), (void(*))tableView_didSelectRowAtIndexPath,nil);
//    objc_registerClassPair(DataSource);
//    returnclass_createInstance(DataSource,0);
//}
//
//
//
//void applicationdidFinishLaunching(void *receiver,structobjc_selector *selector, void *application) {
//    Class windowClass = (Class)objc_getClass("UIWindow");
//    void * windowInstance = class_createInstance(windowClass, 0);
//    
//    objc_msgSend(windowInstance, sel_registerName("initWithFrame:"),(Rect){0,0,320,480});
//    
//    //Make Key and Visiable
//    objc_msgSend(windowInstance,sel_registerName("makeKeyAndVisible"));
//    
//    //Create Table View
//    Class TableViewController = (Class)objc_getClass("UITableViewController");
//    void *tableViewController = class_createInstance(TableViewController, 0);
//    objc_msgSend(tableViewController, sel_registerName("init"));
//    void *tableView = objc_msgSend(tableViewController,sel_registerName("tableView"));
//    objc_msgSend(tableView, sel_registerName("setDataSource:"),createDataSource());
//    objc_msgSend(tableView, sel_registerName("setDelegate:"),createDelegate());
//    
//    Class NavController = (Class)objc_getClass("UINavigationController");
//    navController = class_createInstance(NavController,0);
//    objc_msgSend(navController,sel_registerName("initWithRootViewController:"),tableViewController);
//    void *view =objc_msgSend(navController,sel_registerName("view"));
//    
//    //Add Table View To Window
//    objc_msgSend(windowInstance, sel_registerName("addSubview:"),view);
//}
//
//
////Create an class named "AppDelegate", and return it's name as an instance of class NSString
//void *createAppDelegate() {
//    Class mySubclass = objc_allocateClassPair((Class)objc_getClass("NSObject"),"AppDelegate",0);
//    structobjc_selector *selName =sel_registerName("application:didFinishLaunchingWithOptions:");
//    class_addMethod(mySubclass, selName, (void(*))applicationdidFinishLaunching,nil);
//    objc_registerClassPair(mySubclass);
//    returnobjc_msgSend(objc_getClass("NSString"),sel_registerName("stringWithUTF8String:"),"AppDelegate");
//}
//
//
//int main(int argc, char *argv[]) {
//    returnUIApplicationMain(argc, argv,0,createAppDelegate());
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
