//
//  VideoEncoder.h
//  硬编码VideoToolBox
//
//  Created by 焦英博 on 2017/10/10.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VideoToolbox/VideoToolbox.h>

@interface VideoEncoder : NSObject

- (void)encodeSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)endEncode;

@end
