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

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    
    NSMutableString *string = [[NSMutableString alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    id proxy = [[RuntimeMsgForWarding alloc] initWithTarget1:string target2:array];
    
    [proxy appendString:@"This "];
    [proxy appendString:@"is "];
    [proxy appendString:@"a "];
    [proxy appendString:@"test!"];
    
    [proxy addObject:string];
    [proxy addObject:string];
    
    NSLog(@"count should be 2, it is: %lu", (unsigned long)[proxy count]);
    
    if ([[proxy objectAtIndex:0] isEqualToString:@"This is a test!"]) {
        NSLog(@"Appending successful.");
    } else {
        NSLog(@"Appending failed, got: '%@'", proxy);
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
    };
    
    ClassItem *item = [[ClassSet sharedClassGallery] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.classTitleName;
    
    NSLog(@"item.classTitleName:%@", item.classTitleName);
    NSLog(@"item.className:%@", item.className);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Class *class = [NSClassFromString(<#NSString *aClassName#>)]
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
