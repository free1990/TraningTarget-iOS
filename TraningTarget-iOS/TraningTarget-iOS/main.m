//
//  main.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


//#import <objc/runtime.h>
//#import <objc/message.h>
//#import <stdio.h>

//extern int UIApplicationMain (int argc,char *argv[],void *principalClassName,void *delegateClassName);
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
//int tableView_numberOfRowsInSection(void *receiver,struct objc_selector *selector, void *tblview,int section) {
//    return numberOfRows;
//}
//
//void *tableView_cellForRowAtIndexPath(void *receiver,struct objc_selector *selector, void *tblview,void *indexPath) {
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
//void tableView_didSelectRowAtIndexPath(void *receiver,struct objc_selector *selector, void *tblview,void *indexPath) {
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
//    return class_createInstance(DataSource,0);
//}
//
//void * createDelegate() {
//    Class superclass = (Class)objc_getClass("NSObject");
//    Class DataSource = objc_allocateClassPair(superclass,"Delegate",0);
//    class_addMethod(DataSource,sel_registerName("tableView:didSelectRowAtIndexPath:"), (void(*))tableView_didSelectRowAtIndexPath,nil);
//    objc_registerClassPair(DataSource);
//    return class_createInstance(DataSource,0);
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
//    struct objc_selector *selName = sel_registerName("application:didFinishLaunchingWithOptions:");
//    class_addMethod(mySubclass, selName, (void(*))applicationdidFinishLaunching,nil);
//    objc_registerClassPair(mySubclass);
//    return objc_msgSend(objc_getClass("NSString"),sel_registerName("stringWithUTF8String:"),"AppDelegate");
//}
//
//
//int main(int argc, char *argv[]) {
//    return UIApplicationMain(argc, argv,0,createAppDelegate());
//}
