//
//  ViewController.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    UITableView         *_myTableView;
    NSMutableArray      *_dataArray;
}

@end

