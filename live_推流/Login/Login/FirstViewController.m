//
//  FirstViewController.m
//  Login
//
//  Created by 焦英博 on 2017/9/14.
//  Copyright © 2017年 jyb. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view11)];
    [self.view1 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view22)];
    [self.view2 addGestureRecognizer:tap2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"=>%@", NSStringFromCGRect(self.label.frame));
    UIFont *font = [UIFont systemFontOfSize:17];
    NSLog(@"->%f",font.lineHeight);
}

- (void)view11 {
    NSLog(@"view1");
}

- (void)view22 {
    NSLog(@"view2");
}

- (IBAction)btn:(id)sender {
    NSLog(@"btn click");
}


@end
