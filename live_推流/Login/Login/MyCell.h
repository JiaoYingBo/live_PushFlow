//
//  MyCell.h
//  Login
//
//  Created by 龚赛强 on 2017/8/30.
//  Copyright © 2017年 龚赛强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell {
    @private
    int a;
    @public
    int b;
}

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, copy) void(^block)(NSString *str);

@end
