//
//  ViewController.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RootViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>{
    UITableView         *_myTableView;
}

@end

