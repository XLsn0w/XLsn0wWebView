//
//  WoodDetailWebCell.m
//  TimeForest
//
//  Created by TimeForest on 2018/11/7.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "WebViewCell.h"

@implementation WebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = AppWhiteColor;
        [self drawSubviews];
//        [self noneCellSelection];
    }
    return self;
}

- (void)drawSubviews {
    _webView = [[XLsn0wWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    [self addSubview:_webView];
    _webView.scrollView.scrollEnabled = NO;
    _webView.scrollView.bounces = NO;
    _webView.navigationDelegate = self;
    [_webView sizeToFit];
}

- (void)loadURL:(NSDictionary *)data {
    [_webView loadURLString:@"https://lapin.ithome.com/html/digi/402710.htm"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
        CGFloat height = [data floatValue];
        XLsn0wLog(@"WebViewHeight = %F", [data floatValue]);
        [webView setFrame:CGRectMake(0, 0, kScreenWidth, height)];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%f",height] forKey:@"frame"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCellHeight" object:nil userInfo:dic];
    }];
}

@end
