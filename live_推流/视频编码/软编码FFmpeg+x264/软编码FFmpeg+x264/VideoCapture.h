//
//  VideoCapture.h
//  软编码FFmpeg+x264
//
//  Created by 焦英博 on 2017/10/10.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCapture : NSObject

- (void)startCapture:(UIView *)preview;

- (void)stopCapture;

@end
