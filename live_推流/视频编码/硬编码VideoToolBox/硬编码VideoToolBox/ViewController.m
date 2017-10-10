//
//  ViewController.m
//  硬编码VideoToolBox
//
//  Created by 焦英博 on 2017/10/10.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import "ViewController.h"
#import "VideoCapture.h"

@interface ViewController ()

@property (nonatomic, strong) VideoCapture *videoCapture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)start:(UIButton *)sender {
    [self.videoCapture startCapture:self.view];
}

- (IBAction)stop:(UIButton *)sender {
    [self.videoCapture stopCapture];
}

- (VideoCapture *)videoCapture {
    if (!_videoCapture) {
        _videoCapture = [[VideoCapture alloc] init];
    }
    
    return _videoCapture;
}

@end
