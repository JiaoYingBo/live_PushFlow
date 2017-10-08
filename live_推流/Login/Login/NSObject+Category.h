//
//  NSObject+Category.h
//  Login
//
//  Created by 焦英博 on 2017/9/7.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Category)

@property (nonatomic, weak) UIImage *img;
@property (nonatomic, assign) id(^blk)(void);

@end
