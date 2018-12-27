
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

// 显示导航条的通知
#define SHOW_NAVBAR_NOTIFI @"showNavigationBar"

@interface XLsn0wWebViewController : UIViewController

//@property (nonatomic, weak) UIWebView *ui_webView;
@property (nonatomic, weak) WKWebView *wk_webView;


// 使用 UIWebView  默认使用 WKWebView
@property (nonatomic, assign) BOOL useUIWebView;

// 接口
@property (nonatomic, copy) NSString *url;

// 是否隐藏 nav
@property (nonatomic, assign) BOOL isHideNavigationBar;

// 是否能刷新
@property (nonatomic, assign) BOOL canRefresh;

// 进度条颜色
@property (nonatomic, weak) UIColor *progressViewColor;

// 打开js的复制黏贴功能
@property (nonatomic, assign) BOOL canCopy;

// 脚本字符串(cookie)
@property (nonatomic, copy) NSString *sourceStr;

// 重新刷新图片
@property (nonatomic, copy) NSString *reloadButtonImage;

// 开启侧滑手势
@property (nonatomic, assign) BOOL offPopGesture;

// 设置 cookieValue
@property (nonatomic, copy) NSString *cookieValue;

// 隐藏垂直滚动条
@property (nonatomic, assign) BOOL hideVScIndicator;
// 隐藏水平滚动条
@property (nonatomic, assign) BOOL hideHScIndicator;


// 设置 cookie
- (void)setCookieWithName:(NSString *)cookieName cookieValue:(NSString *)cookieValue cookieDomain:(NSString *)cookieDomain cookieCommentURL:(NSString *)cookieCommentURL cookiePort:(NSString *)cookiePort;


@end
