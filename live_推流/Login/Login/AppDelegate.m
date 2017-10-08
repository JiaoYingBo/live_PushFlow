//
//  AppDelegate.m
//  Login
//
//  Created by 龚赛强 on 2017/8/29.
//  Copyright © 2017年 龚赛强. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+Category.h"
#import "MyCell.h"
#import "MyCell+Test.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@property (nonatomic, copy) void(^blk)(void);
@property (nonatomic, assign) int num;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 0x7fff...都是栈地址
    MyCell *cell = [MyCell new];
    [cell cellTest];
    NSLog(@"=>%p", &cell);
    
    __block int a = 10;
    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"0=%d %p %@", a, &a, obj);
    void(^block)(void) = ^{
        a = 20;
        NSLog(@"1=%d %p %@", a, &a, obj);
    };
    NSLog(@"2=%d %p %@", a, &a, obj);
    block();
    NSLog(@"3=%d %p %@", a, &a, obj);
    NSLog(@"4=%@", block);
    
//    NSLog(@"%@", cell);
//    self.blk = ^{
//        NSLog(@"%@", cell);
//    };
//    NSLog(@"%@", cell);
//    self.blk();
    
//    [self testt];
    
    
    
    
    return YES;
}

- (void)testt {
    NSObject *obj = [NSObject new];
    void(^block)(void) = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5000 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"==>%@", obj);
//        });
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(3);
            NSLog(@"==>%@", obj);
        });
    };
    block();
    NSLog(@"->%@", obj);
}


@end
