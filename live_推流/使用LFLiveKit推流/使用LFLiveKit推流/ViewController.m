//
//  ViewController.m
//  使用LFLiveKit推流
//
//  Created by 焦英博 on 2017/10/14.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import "ViewController.h"
#import <LFLiveKit/LFLiveKit.h>

@interface ViewController ()

@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)start:(id)sender {
    LFLiveStreamInfo *stream = [[LFLiveStreamInfo alloc] init];
    stream.url = @"rtmp://59.110.27.24/live/demo";
    [self.session startLive:stream];
    [self.session setRunning:YES];
}

- (LFLiveSession *)session {
    if (!_session) {
        LFLiveAudioConfiguration *audioConfig = [LFLiveAudioConfiguration defaultConfiguration];
        LFLiveVideoConfiguration *videoConfig = [LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Low2 outputImageOrientation:UIInterfaceOrientationPortrait];
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfig videoConfiguration:videoConfig];
        _session.preView = self.view;
    }
    return _session;
}


@end
