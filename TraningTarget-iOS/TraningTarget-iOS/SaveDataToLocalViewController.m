//
//  SaveDataToLocalViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/30.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "SaveDataToLocalViewController.h"
#import "ZYSandBoxCache.h"

@implementation SaveDataToLocalViewController


+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Practice";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ZYSandBoxCache *cache = [[ZYSandBoxCache alloc] init];
    
    //create folder
    NSString *filePath = [cache createFolderWithDirectory:NSLibraryDirectory folderName:@"test"];
    
    //use terminal, open filePath
    NSLog(@"filePath = %@",filePath);
    
    //save image to folder
    [cache saveImageToFolderPath:filePath image:[UIImage imageNamed:@"xcode"] imageName:@"xcode"];
    
    //save text(or NSArray,NSDictionary) to folder
    [cache saveTextTOFolderPath:filePath content:@"use termainal open folder path" textName:@"text"];
    
    [cache saveTextTOFolderPath:filePath content:@"use termainal open folder path1" textName:@"text1"];
    
    [cache saveTextTOFolderPath:filePath content:@"use termainal open folder path2" textName:@"text2"];
    
    //get text
    NSString *filePath2 = [filePath stringByAppendingPathComponent:@"text.txt"];
    NSString *textContent = [[NSString alloc] initWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"修改之前----> %@",textContent);
    
    NSLog(@"count----> %ld",[[cache forinFolder:filePath] count]);
    
    for (int i = 0; i < [[cache forinFolder:filePath] count]; i++) {
        
        NSLog(@"name----> %@",(NSString *)[[cache forinFolder:filePath] objectAtIndex:i]);
    }

}

@end
