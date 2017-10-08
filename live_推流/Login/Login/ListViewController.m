//
//  ListViewController.m
//  Login
//
//  Created by 龚赛强 on 2017/8/29.
//  Copyright © 2017年 龚赛强. All rights reserved.
//

#import "ListViewController.h"
#import "ViewController.h"
#import "MyCell.h"
#import "MyModel.h"
#import "Masonry.h"
#import "NSObject+Category.h"
#import <objc/runtime.h>

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) MyCell *myC;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftItem];
    [self setupUI];
    
    
    // timer不能再dealloc中移除，因为循环引用了根本不会走dealloc方法
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gg) userInfo:nil repeats:YES];
    
//    __weak typeof(self)wself = self;
//    wself.myC = [MyCell new];
//    wself.myC.block = ^(NSString *str) {
//        __strong typeof(wself)sself = wself;
//        NSLog(@"===>%@ %@", sself, str);
//    };
//    
//    NSObject *obj = [NSObject new];
//    for (int i = 0; i < 1; i ++) {
//        obj.img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"666.jpg" ofType:nil]];
//    }
//    
//    NSLog(@"-->%@", obj.img);
    
//    id __weak weakObject = self.myC;
//    id (^block)() = ^{
//        return weakObject;
//    };
//    objc_setAssociatedObject(self, "1" , block, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    NSLog(@"set:%@", block());
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gg) userInfo:nil repeats:YES];
    
    // MJRefresh刷新原理
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
//    [self.tableView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
//    UIPanGestureRecognizer *pan = self.tableView.panGestureRecognizer;
//    [pan addObserver:self forKeyPath:@"state" options:options context:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}
    
- (void)time {
    NSLog(@"time");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:@"contentSize"]) {
        //
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        //
    } else if ([keyPath isEqualToString:@"state"]) {
        if (self.tableView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
            [self.tableView setContentInset:UIEdgeInsetsMake(150, 0, 0, 0)];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2000 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
                }];
            });
        }
    }
}

//- (void)gg {
//    NSLog(@"gg");
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    id (^block)() = objc_getAssociatedObject(self, "1");
    //    NSLog(@"get:%@", block());
//    [self gcdGroup];
}

- (void)gcdGroup {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self getRequestWithURL:@"https://github.com" Sucess:^(NSDictionary *dic, NSData *datas) {
        NSLog(@"group1");
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self getRequestWithURL:@"http://www.baidu.com" Sucess:^(NSDictionary *dic, NSData *datas) {
        NSLog(@"group2");
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self getRequestWithURL:@"https://www.apple.com" Sucess:^(NSDictionary *dic, NSData *datas) {
        NSLog(@"group3");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group done");
    });
}

- (void)getRequestWithURL:(NSString *)urlString Sucess:(void(^)(NSDictionary *dic, NSData *datas))block {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"\n%@",response);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (block) {
                block(dic,data);
            }
        });
    }];
    [task resume];
}

#pragma mark - UI

- (void)setLeftItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)dealloc {
    NSLog(@"listVC dealloc");
}

#pragma mark - tableView dataSource & delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MyModel *model = self.datas[indexPath.row];
    cell.headerImageView.image = [UIImage imageNamed:model.headerImage];
    cell.titleLabel.text = model.title;
    cell.subTitleLabel.text = model.subTitle;
    cell.timeLabel.text = model.time;
        
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MyModel *model = self.datas[indexPath.row];    
    [self showAlertWithTitle:model.title Massage:model.subTitle];
}

#pragma mark - 按钮点击

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.blk(@"666");
}

#pragma mark - 私有方法

- (void)showAlertWithTitle:(NSString *)title Massage:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.rowHeight = 60;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)datas {
    if (!_datas) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"datas.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            MyModel *model = [[MyModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [temp addObject:model];
        }
        
        _datas = temp.copy;
    }
    return _datas;
}

@end
