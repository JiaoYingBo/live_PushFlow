//
//  NSObject+Category.m
//  Login
//
//  Created by 焦英博 on 2017/9/7.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

- (void)setImg:(UIImage *)img {
    id __weak weakObject = img;
    id (^block)() = ^{
        return weakObject;
    };
    objc_setAssociatedObject(self, "1" , block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //NSLog(@"set:%@", block());
    self.blk = block;
}

- (UIImage *)img {
    id (^block)() = objc_getAssociatedObject(self, "1");
    //NSLog(@"get:%@", block());
    return block();
}

- (void)setBlk:(id (^)(void))blk {
    objc_setAssociatedObject(self, "blk", blk, OBJC_ASSOCIATION_ASSIGN);
}

- (id (^)(void))blk {
    return objc_getAssociatedObject(self, "blk");
}

@end
