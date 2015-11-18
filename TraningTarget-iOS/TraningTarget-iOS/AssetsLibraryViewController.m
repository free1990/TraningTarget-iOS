//
//  AssetsLibraryViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/2/27.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "AssetsLibraryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PictureObject.h"

static dispatch_queue_t rec_pic_processing_queue() {
    static dispatch_queue_t rec_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rec_processing_queue = dispatch_queue_create("com.fclassroom.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return rec_processing_queue;
}

@interface AssetsLibraryViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    ALAssetsLibrary *_library;
    
    UITableView *_tableview;
    
    NSMutableArray *_imageInfoArray;
}

@end

@implementation AssetsLibraryViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"获取相册图片";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _library = [[ALAssetsLibrary alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _imageInfoArray = [[NSMutableArray alloc] init];
    
    _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    _tableview.separatorInset = UIEdgeInsetsZero;
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _tableview.rowHeight = 66;
    
    [self.view addSubview:_tableview];
    
    [self getImgs];
    
//    ALAssetsLibrary     指的是整个相册库
//    ALAssetsGroup       指的是相册中的文件夹
//    ALAsset             指的是文件夹中的照片、视频
    
//    ALAssetsLibrary *libray = [[ALAssetsLibrary alloc] init];
//    
//    [libray enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        
//        if (group != nil) {
//            
//            //设置过滤对象
//            //            ALAssetsFilter *filter = [ALAssetsFilter allVideos];
//            //            [group setAssetsFilter:filter];
//            
//            //通过文件夹枚举遍历所有的相片ALAsset对象，有多少照片，则调用多少次block
//            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                if (result != nil) {
//                    //将result对象存储到数组中
//                    
//                }
//            }];
//        }
//        
//    } failureBlock:^(NSError *error) {
//        
//    }];

}

-(void)getImgs{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
//        @autoreleasepool {
        
            ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
                NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
                if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                    NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
                }else{
                    NSLog(@"相册访问失败.");
                }
            };
            
            ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result,NSUInteger index, BOOL *stop){
                if (result != NULL) {
                    
                    if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                        
                        NSString *urlstr = [NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                        
//                        NSLog(@"urlstr--------%@", urlstr);
                        
                        /*result.defaultRepresentation.fullScreenImage//图片的大图
                         result.thumbnail                            //图片的缩略图小图
                         //                    NSRange range1=[urlstr rangeOfString:@"id="];
                         //                    NSString *resultName=[urlstr substringFromIndex:range1.location+3];
                         //                    resultName=[resultName stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."];//格式demo:123456.png
                         */
                        
                        PictureObject *picObject = [[PictureObject alloc] init];
                        
                        picObject.alAsset = result;
                        
                        [_imageInfoArray addObject:picObject];
                        
                        [_dataArray addObject:urlstr];
                        
                        NSLog(@"--->%ld",  [_dataArray count]);
                        [_tableview reloadData];
            
                    }
                }
            };
            
            
            ALAssetsLibraryGroupsEnumerationResultsBlock
            
            libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
                
                ALAssetsFilter *filter = [ALAssetsFilter allPhotos];
                
                [group setAssetsFilter:filter];
                
                if (group != nil) {
                    
                    NSString *grounpName = [NSString stringWithFormat:@"%@",group];//获取相簿的组
                    NSLog(@"gg:%@",grounpName);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
                    
                    NSString *g1 = [grounpName substringFromIndex:16] ;
                    NSArray *arr = [NSArray arrayWithArray:[g1 componentsSeparatedByString:@","]];
                    NSString *g2 = [[arr objectAtIndex:0] substringFromIndex:5];
            
                    [group enumerateAssetsUsingBlock:groupEnumerAtion];
                    
//                    if ([g2 isEqualToString:@"Camera Roll"]) {
//                        
//                        //只读取默认相册的
//                        
//                    }
                }
                
            };
            
            _library = [[ALAssetsLibrary alloc] init];
            [_library enumerateGroupsWithTypes:ALAssetsGroupAll
                                  usingBlock:libraryGroupsEnumeration
                                failureBlock:failureblock];
//        }
        
        
    });
    
}


#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_imageInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentiferId = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentiferId];
    };
    
    PictureObject *picObject = [_imageInfoArray objectAtIndex:indexPath.row];
    
    if (picObject.isSelect) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.imageView.image = [UIImage imageWithCGImage:[picObject.alAsset thumbnail]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PictureObject *picObject = [_imageInfoArray objectAtIndex:indexPath.row];
    
    picObject.isSelect = !picObject.isSelect;
    
    [_imageInfoArray replaceObjectAtIndex:indexPath.row withObject:picObject];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


////------------------------根据图片的url反取图片－－－－－
//
//ALAssetsLibrary *assetLibrary=[[ALAssetsLibraryalloc] init];
//NSURL *url=[NSURLURLWithString:urlStr];
//[assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//    UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
//    cellImageView.image=image;
//    
//}failureBlock:^(NSError *error) {
//    NSLog(@"error=%@",error);
//}
// ];
//－－－－－－－－－－－－－－－－－－－－－


//ALAssetsLibrary *libray = [[ALAssetsLibrary alloc] init];
//
///*
// 通过相册库枚举遍历所有的文件夹ALAssetsGroup
// usingBlock : 有多少个Group文件夹，则调用多少次block，每次将对应的文件夹Group传过来
// */
//[libray enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//    
//    if (group != nil) {
//        
//        //设置过滤对象
//        //            ALAssetsFilter *filter = [ALAssetsFilter allVideos];
//        //            [group setAssetsFilter:filter];
//        
//        //通过文件夹枚举遍历所有的相片ALAsset对象，有多少照片，则调用多少次block
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            if (result != nil) {
//                //将result对象存储到数组中
//                [_data addObject:result];
//            }
//        }];
//    }
//    
//    //刷新表格，显示照片
//    [_tableView reloadData];
//    
//} failureBlock:^(NSError *error) {
//    
//}];

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _data.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *identify = @"imageCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//    
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
//    }
//    
//    ALAsset *asset = [_data objectAtIndex:indexPath.row];
//    
//    //获取到媒体的类型
//    NSString *type = [asset valueForProperty:ALAssetPropertyType];
//    //媒体类型是视频
//    if ([type isEqualToString:ALAssetTypeVideo]) {
//        cell.textLabel.text = @"视频";
//    } else {
//        cell.textLabel.text = @"照片";
//    }
//    
//    //获取到相片、视频的缩略图
//    CGImageRef cgImage = [asset thumbnail];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    
//    cell.imageView.image = image;
//    
//    
//    return cell;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
