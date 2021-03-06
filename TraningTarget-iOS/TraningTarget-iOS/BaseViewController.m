//
//  BaseViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassItem.h"
#import "ClassSet.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize className;
@synthesize sectionName;

+(void)registerClassItem:(id)item
{
//    NSLog(@"registerPlotItem for class %@", [item class]);
    
    Class itemClass = [item class];
    
    if ( itemClass ) {
        
        
//        BaseViewController *class = [[itemClass alloc] init];
        
        ClassItem *item = [[ClassItem alloc] init];
        
        item.classTitleName = NSStringFromClass(itemClass);
        item.className = NSStringFromClass(itemClass);
        
        if ( item ) {
            [[ClassSet sharedClassGallery] addClassItem:item];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.className;
    self.view.backgroundColor = [UIColor whiteColor];
 
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@""
                                             style:UIBarButtonItemStyleDone
                                             target:self
                                             action:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
