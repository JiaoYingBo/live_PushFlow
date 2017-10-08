//
//  ListViewController.h
//  Login
//
//  Created by 龚赛强 on 2017/8/29.
//  Copyright © 2017年 龚赛强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController

@property (nonatomic, copy) void(^blk)(NSString *str);

@end
