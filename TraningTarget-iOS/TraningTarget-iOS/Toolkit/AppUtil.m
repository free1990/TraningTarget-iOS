//
//  AppUtil.m
//  Template
//
//  Created by work on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "AppUtil.h"
#import "Macros.h"
#import "Config.h"
#import "mach/mach.h"

@implementation AppUtil

+ (InterfaceIdiom)interfaceIdiom {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (WinSize.height == 736 || WinSize.width == 736) {
            return InterfaceIdiomPhone6Plus;
        } else if (WinSize.height == 667 || WinSize.width == 667) {
            return InterfaceIdiomPhone6;
        } else if (WinSize.height == 568 || WinSize.width == 568) {
            return InterfaceIdiomPhone5;
        } else {
            return InterfaceIdiomPhone4;
        }
    } else {
        return InterfaceIdiomPad;
    }
}

+ (NSString *)appDisplayName {
    return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (CGFloat)contentScaleFactor {
    if (InterfaceIdiomPhone6 == [AppUtil interfaceIdiom]) {
        // iPhone 6
        return 1.18;
    } else if (InterfaceIdiomPhone6Plus == [AppUtil interfaceIdiom]) {
        // iPhone 6 Plus
        return 1.30;
    }
    return 1.0;
}

+ (NSString *)floatFormat:(double)value
{
    int tempInt = value * 100;
    
    if (tempInt%100 == 0) {
        return  [NSString stringWithFormat:@"%d",tempInt/100];
    }else if (tempInt%10 == 0){
        return  [NSString stringWithFormat:@"%.1f",tempInt/100.0];
    }else{
        if (((int)(value * 1000) % 10) >= 5) {
            return  [NSString stringWithFormat:@"%.2f",tempInt/100.0 + 0.01];
        }else {
            return  [NSString stringWithFormat:@"%.2f",tempInt/100.0];
        }
    }
}

+ (NSString *)saveImage:(UIImage *)image withFlag:(NSString *)flag {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd_HHmmss"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    NSString *filename = [NSString stringWithFormat:@"%@_%@.jpg", datetime, flag];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:filename];
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
    
    return filePath;
}

#pragma mark -

vm_size_t usedMemory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

vm_size_t freeMemory(void) {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

+ (void)logMemUsage {
    // compute memory usage and log if different by >= 100k
    static long prevMemUsage = 0;
    long curMemUsage = usedMemory();
    long memUsageDiff = curMemUsage - prevMemUsage;
    
    if (memUsageDiff > 100000 || memUsageDiff < -100000) {
        prevMemUsage = curMemUsage;
        DLOG(@"Memory used %7.1f (%+5.0f), free %7.1f kb", curMemUsage/1000.0f, memUsageDiff/1000.0f, freeMemory()/1000.0f);
    }
}

+ (void)increaseFreeMemoryTo:(int)MB {
    vm_size_t size = freeMemory();
    while (size < MB * 1024 * 1024) {
        DLOG(@"%.1f KB", size / 1000.f);
        
        // Allocate the remaining amount of free memory, minus 2 megs
        void *allocation = malloc(size - 2048);
        bzero(allocation, size - 2048);
        free(allocation);
        
        size = freeMemory();
    }
}

+ (unsigned long long)fileSizeAtPath:(NSString *)path {
    NSDictionary *attrib = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    if (!attrib) {
        return 0;
    }
    return [attrib fileSize];
}


@end
