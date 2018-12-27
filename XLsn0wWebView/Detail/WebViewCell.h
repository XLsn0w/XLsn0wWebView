//
//  WoodDetailWebCell.h
//  TimeForest
//
//  Created by TimeForest on 2018/11/7.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLsn0wWebView.h"
#import <WebKit/WebKit.h>
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewCell : UITableViewCell <WKNavigationDelegate>

@property (nonatomic, strong) XLsn0wWebView *webView;

- (void)loadURL:(NSDictionary *)data;

//+ (CGFloat)cellHeightFromWeb;

@end

NS_ASSUME_NONNULL_END
