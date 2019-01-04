//
//  StoreCell.m
//  TimeForest
//
//  Created by TimeForest on 2018/10/29.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "ViewCell.h"
//#import "StoreModel.h"
#import "Masonry.h"
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>
///App全局使用色
#define AppThemeColor               [UIColor xlsn0w_hexString:@"#0BB81D"]
#define AppSecondLevelColor         [UIColor xlsn0w_hexString:@"#F69A49"]
#define AppViewBackgroundColor      [UIColor xlsn0w_hexString:@"#F8F8F8"]

#define AppBtnDisabledColor         [UIColor xlsn0w_hexString:@"#D4D4D4"]
#define AppBtnNormalColor           AppThemeColor
#define AppBtnHighlightedColor      [UIColor xlsn0w_hexString:@"#289934"]
#define AppPayBtnHighlightedColor   [UIColor xlsn0w_hexString:@"#C57C3B"]

#define AppBlackTextColorAlpha      [UIColor xlsn0w_hexString:@"#000000" alpha:0.87]
#define AppBlackTextColor           [UIColor xlsn0w_hexString:@"#212121"]

#define AppGrayTextColorAlpha       [UIColor xlsn0w_hexString:@"#000000" alpha:0.54]
#define AppGrayTextColor            [UIColor xlsn0w_hexString:@"#757575"]
#define AppRedTextColor             [UIColor xlsn0w_hexString:@"#FF3C3C"]

#define AppWhiteColor               UIColor.whiteColor
#define App9AlphaWhiteColor          [UIColor xlsn0w_hexString:@"#FFFFFF" alpha:0.9]
#define App5AlphaWhiteColor          [UIColor xlsn0w_hexString:@"#FFFFFF" alpha:0.5]

#define AppLightGrayTextColor       [UIColor xlsn0w_hexString:@"#000000" alpha:0.27]
#define AppLineColor                [UIColor xlsn0w_hexString:@"#000000" alpha:0.1]


#define AppWhiteTextColorAlpha      [UIColor xlsn0w_hexString:@"#FFFFFF" alpha:0.5]
#define AppWhiteTextColor           [UIColor xlsn0w_hexString:@"#FFFFFF"]


@implementation ViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = AppViewBackgroundColor;
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
    UIView* whiteView = [UIView new];
    [self addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
    whiteView.backgroundColor = AppWhiteColor;
//    [whiteView xlsn0w_addCornerRadius:7];
//    [whiteView addShadowForRadius:7 shadowOpacity:0.4 shadowOffset:(CGSizeMake(0, 2)) shadowColor:[UIColor xlsn0w_hexString:@"#000000" alpha:0.1]];
    
    _furnitureIcon = [[UIImageView alloc] init];
    [whiteView addSubview:_furnitureIcon];
    [_furnitureIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(194);
        make.width.mas_equalTo(kScreenWidth-60);
    }];
//    _furnitureIcon.image = placeholderAppImage;
//    [_furnitureIcon centerClip];
    
    _name = [[UILabel alloc] init];
    [whiteView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self->_furnitureIcon.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    _name.font = [UIFont systemFontOfSize:14];
    _name.textColor = AppBlackTextColor;
    _name.text = @"   ";
    
    _descr = [[UILabel alloc] init];
    [whiteView addSubview:_descr];
    [_descr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self->_name.mas_bottom).offset(5);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(15);
    }];
    _descr.font = [UIFont systemFontOfSize:11];
    _descr.textColor = AppGrayTextColor;
    _descr.text = @"   ";
    
    _price = [[UILabel alloc] init];
    [whiteView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self->_descr.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    _price.font = [UIFont systemFontOfSize:18];
    _price.textColor = AppRedTextColor;
    _price.text = @"¥ 100.00";
    
    _exchange = [[UILabel alloc] init];
    [whiteView addSubview:_exchange];
    _exchange.font = [UIFont systemFontOfSize:12];
    _exchange.textColor = AppThemeColor;
    _exchange.text = @"  ";
    _exchange.backgroundColor = [UIColor xlsn0w_hexString:@"#0BB81D" alpha:0.1];
    _exchange.textAlignment = NSTextAlignmentCenter;
    [_exchange xlsn0w_addCornerRadius:4];
}

//- (void)addData:(StoreModel *)model {
//    _name.text = model.name;
//    _descr.text = model.title;
//    _price.text = [NSString stringWithFormat:@"%@%@", @"¥ ", model.price];
//    [_furnitureIcon setImageFromURLString:model.headPic];
//    if (isNotNull(model.activityTitle)) {
//        _exchange.text = model.activityTitle;
//        float width =  [model.activityTitle autoTextWidthForFontSize:12 textHeight:19];
//        _exchange.frame = CGRectMake(kScreenWidth-45-width-20, 10+10+192+62, width+20, 19);
//    }
//}

//重写该方法后可以让超出父视图范围的子视图响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint convertPoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, convertPoint)) {
                view = subView;
            }
        }
    }
    return view;
}

/*
 
// 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;

// 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;

// 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;

// 将rect从view中转换到当前视图中，返回在当前视图中的rect
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
 
 // controllerA 中有一个UITableView, UITableView里有多行UITableVieCell，cell上放有一个button
 // 在controllerA中实现:
 CGRect rc = [cell convertRect:cell.btn.frame toView:self.view];
 或者
 CGRect rc = [self.view convertRect:cell.btn.frame fromView:cell];
 // 此rc为btn在controllerA中的rect
 

 

*/


@end
