//
//  ZYSandBoxCache.h
//  TraningTarget-iOS
//
//  Created by John on 15/2/6.
//  Copyright (c) 2014年 moshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Documents,
    Library,
    Caches,
} FolderStyle;

@interface ZYSandBoxCache : NSObject

/**
 *  Create folder
 *
 *  @param directory  folder directory
 *  @param folderName folder name
 *
 *  @return folder path
 */
-(NSString *)createFolderWithDirectory:(NSSearchPathDirectory)directory folderName:(NSString *)folderName;

/**
 *  Save image to folder
 *
 *  @param path      save path
 *  @param image     image
 *  @param imageName file name
 */
-(void)saveImageToFolderPath:(NSString *)path image:(UIImage *)image imageName:(NSString *)imageName;


/**
 *  Save txt to folder
 *
 *  @param path     save path
 *  @param content  support NSArray,NSDictionary
 *  @param textName file name
 */
-(void)saveTextTOFolderPath:(NSString *)path content:(id)content textName:(NSString *)textName;


/**
 *  Browse all file
 *
 *  @param folderPath path
 *
 *  @return file array
 */
-(NSArray *)forinFolder:(NSString *)folderPath;


/**
 *  NSDictionary to Json
 *
 *  @param dictionary NSDictionary
 */
-(void)saveDictionaryConvertJson:(NSDictionary *)dictionary toFolder:(NSString *)folderPath textName:(NSString *)textName;


/**
 *  return json
 *
 *  @param directory  folder directory
 *  @param foldername folder name
 *  @param textName save json's txt file name
 *
 *  @return json to dictionary
 */
-(NSDictionary *)getJsonData:(NSSearchPathDirectory)directory withFolderName:(NSString *)foldername withTextName:(NSString *)textName;

@end
