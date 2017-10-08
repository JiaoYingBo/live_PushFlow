//
//  ViewController.m
//  Login
//
//  Created by 龚赛强 on 2017/8/29.
//  Copyright © 2017年 龚赛强. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "Masonry.h"
#import "FirstViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark - UI

- (void)setupUI {
    [self.view addSubview:self.accountTextField];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTextField.mas_bottom).offset(20);
        make.centerX.width.height.equalTo(self.accountTextField);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(20);
        make.centerX.width.height.equalTo(self.accountTextField);
    }];
}

#pragma mark - 按钮点击

- (void)loginButtonClick {
//    NSString *account = self.accountTextField.text;
//    NSString *password = self.passwordTextField.text;
//    if (![self validateMobile:account]) {
//        [self showAlertWithMassage:@"请输入正确的手机号!"];
//        return;
//    }
//    if (password.length < 6) {
//        [self showAlertWithMassage:@"密码长度不能少于6位!"];
//        return;
//    }
    
//    NSMutableArray *arr = @[@"1",@"2"].mutableCopy;
//    ListViewController *listVC = [[ListViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
//    [self presentViewController:nav animated:YES completion:nil];
//    listVC.blk = ^(NSString *str){
//        [arr replaceObjectAtIndex:1 withObject:str];
//        NSLog(@"%@", arr);
//    };
    
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 私有方法

- (BOOL)validateMobile:(NSString *)mobile {
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (void)showAlertWithMassage:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 手机号限制11位
    if (range.location > 10) {
        return NO;
    }
    return YES;
}

#pragma mark - 懒加载

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.placeholder = @"请输入手机号";
        _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
        _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
        _accountTextField.delegate = self;
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _accountTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"密码不能少于6位";
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1]];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 4;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

@end
