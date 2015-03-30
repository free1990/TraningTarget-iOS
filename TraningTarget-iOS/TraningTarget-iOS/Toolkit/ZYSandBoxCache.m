//
//  ZYSandBoxCache.m
//  TraningTarget-iOS
//
//  Created by John on 15/2/6.
//  Copyright (c) 2014年 moshou. All rights reserved.
//

#import "ZYSandBoxCache.h"

@implementation ZYSandBoxCache

-(NSString *)createFolderWithDirectory:(NSSearchPathDirectory)directory folderName:(NSString *)folderName{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *path = pathArray[0];
    NSString *folder = [NSString stringWithFormat:@"%@/%@",path,folderName];
    BOOL existDic = NO;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:folder isDirectory:&existDic];
    if (!(exist == YES && existDic == YES)) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return folder;
}

-(void)saveImageToFolderPath:(NSString *)path image:(UIImage *)image imageName:(NSString *)imageName{
    
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png", imageName]];
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
}

-(void)saveTextTOFolderPath:(NSString *)path content:(id)content textName:(NSString *)textName{
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",textName]];
    [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(NSArray *)forinFolder:(NSString *)folderPath{
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    return fileList;
}

-(void)saveDictionaryConvertJson:(NSDictionary *)dictionary toFolder:(NSString *)folderPath textName:(NSString *)textName{
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self saveTextTOFolderPath:folderPath content:json textName:textName];
    }else{
        NSLog(@"dictionary is not json farmot");
    }
}

-(NSDictionary *)getJsonData:(NSSearchPathDirectory)directory withFolderName:(NSString *)foldername withTextName:(NSString *)textName{
    NSString *path = [self createFolderWithDirectory:directory folderName:foldername];
    NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",textName]]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
@end
