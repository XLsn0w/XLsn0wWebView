
#import "XLsn0wWebView.h"
#import <Foundation/Foundation.h>

//是否是空对象
#define isObjectNull(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

///对象不为空
#define isNotNull(obj)   (!isObjectNull(obj))

@interface XLsn0wWebView () {
    BOOL _displayHTML;  //  显示页面元素
    BOOL _displayCookies;// 显示页面Cookies
    BOOL _displayURL;// 显示即将调转的URL
}

//  交互对象，使用它给页面注入JS代码，给页面图片添加点击事件
@property (nonatomic, strong) WKUserScript *userScript;

@end


@implementation XLsn0wWebView {
    NSString *_imgSrc;//  预览图片的URL路径
}

//  MARK: - init
- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];
    self.URLString = urlString;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setDefaultValue];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    WKWebViewConfiguration *configer = [[WKWebViewConfiguration alloc] init];
    configer.userContentController = [[WKUserContentController alloc] init];
    configer.preferences = [[WKPreferences alloc] init];
    configer.preferences.javaScriptEnabled = YES;
    configer.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    configer.allowsInlineMediaPlayback = YES;
    [configer.userContentController addUserScript:self.userScript];
    self = [super initWithFrame:frame configuration:configer];
    return self;
}

- (void)loadURLString:(NSString*)url {
    if (isNotNull(url)) {
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    [self setDefaultValue];
}

- (void)setDefaultValue {
    _displayHTML = YES;
    _displayCookies = NO;
    _displayURL = YES;
    self.UIDelegate = self;
    self.navigationDelegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
}

//  MARK: - 加载本地URL
- (void)loadLocalHTMLWithFileName:(nonnull NSString *)htmlName {
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:htmlName
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self loadHTMLString:htmlCont baseURL:baseURL];
}

- (void)setJsHandlers:(NSArray<NSString *> *)jsHandlers {
    _jsHandlers = jsHandlers;
    [jsHandlers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [self.configuration.userContentController addScriptMessageHandler:self name:obj];
    }];
}

//  MARK: - js调用原生方法 可在此方法中获得传递回来的参数
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if(self.webDelegate !=nil && [self.webDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]){
        [self.webDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

//  MARK: - 检查cookie及页面HTML元素
//页面加载完成后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //获取图片数组
    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self->_imgSrcArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"+"]];
        if (self->_imgSrcArray.count >= 2) {
            [self->_imgSrcArray removeLastObject];
        }
        NSLog(@"%@",self->_imgSrcArray);
    }];
    
    [webView evaluateJavaScript:@"registerImageClickAction();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
    
    if (_displayCookies) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [cookieJar cookies]) {
            NSLog(@"%@", cookie);
        }
    }
    if (_displayHTML) {
        NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
        [webView evaluateJavaScript:jsToGetHTMLSource completionHandler:^(id _Nullable HTMLsource, NSError * _Nullable error) {
            NSLog(@"%@",HTMLsource);
        }];
    }
    if (![self.webDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        return;
    }
    if([self.webDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]){
        [self.webDelegate webView:webView didFinishNavigation:navigation];
    }
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
        CGFloat height = [data floatValue];
        //ps:js可以是上面所写，也可以是document.body.scrollHeight;在WKWebView中前者offsetHeight获取自己加载的html片段，高度获取是相对准确的，但是若是加载的是原网站内容，用这个获取，会不准确，改用后者之后就可以正常显示，这个情况是我尝试了很多次方法才正常显示的
        CGRect webFrame = webView.frame;
        webFrame.size.height = height;
//        XLsn0wLog(@"height = %f", height);
        webView.frame = webFrame;
    }];
}

//  MARK: - 页面开始加载就调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (self.webDelegate != nil && [self.webDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [self.webDelegate webView:webView didStartProvisionalNavigation:navigation];
    }
}

//  MARK: - 导航每次跳转调用跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //预览图片
    if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [navigationAction.request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _imgSrc = path;
        [self previewPicture];
    }
    if (_displayURL) {
        NSLog(@"-----------%@",navigationAction.request.URL.absoluteString);
        if (self.webDelegate != nil && [self.webDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
            [self.webDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - 移除jsHandler
- (void)removejsHandlers {
    NSAssert(_jsHandlers, @"未找到jsHandler!无需移除");
    if (_jsHandlers) {
        for (NSString *handlerName in _jsHandlers) {
            [self.configuration.userContentController removeScriptMessageHandlerForName:handlerName];
        }
    }
}

//  MARK: - 进度条
- (UIProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        _progressView.tintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        [self addSubview:_progressView];
    }
    return _progressView;
}
//  MARK: - 清除cookie
- (void)removeCookies {
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records) {
                             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                       forDataRecords:@[record]
                                                                    completionHandler:^{
                                                                        NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                    }];
                         }
                     }];
}

- (void)removeCookieWithHostName:(NSString *)hostName {
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records) {
                             if ( [record.displayName containsString:hostName]) {
                                 [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes:record.dataTypes
                                                                          forDataRecords:@[record]
                                                                       completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                          }];
                             }
                         }
                     }];
}

//  MARK: - 调用js方法
- (void)callJavaScript:(NSString *)jsMethodName {
    [self callJavaScript:jsMethodName handler:nil];
}

- (void)callJavaScript:(NSString *)jsMethodName handler:(void (^)(id _Nullable))handler {
    
    NSLog(@"call js:%@",jsMethodName);
    [self evaluateJavaScript:jsMethodName completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (handler) {
            handler(response);
        }
    }];
}

- (void)dealloc {
    //  这里清除或者不清除cookies 按照业务要求
//    [self removeCookies];
}

// 预览图片
- (void)previewPicture {
    NSInteger currentIndex = 0;
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *imageViews = @[].mutableCopy;
    UIView *fromView = nil;
    for (NSInteger i = 0; i < self.imgSrcArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        imageView.center = self.center;
        [imageViews addObject:imageView];
        
        NSString *path = self.imgSrcArray[i];
        
//        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
//        item.thumbView = self.superview;
//        NSURL *url = [NSURL URLWithString:self.imgSrcArray[i]];
//        item.thumbView = imageView;
//        item.largeImageURL = url;
//        [items addObject:item];
        
        if ([path isEqualToString:_imgSrc]) {
            currentIndex = i;
        }
        fromView = imageViews[currentIndex];
    }
//    YYPhotoBrowseView *groupView = [[YYPhotoBrowseView alloc]initWithGroupItems:items];
//    [groupView presentFromImageView:fromView toContainer:self.superview animated:YES completion:nil];
}

- (WKUserScript *)userScript {
    if (!_userScript) {
        static  NSString * const jsGetImages =
        @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
        for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '+';\
        };\
        return imgScr;\
        };function registerImageClickAction(){\
        var imgs=document.getElementsByTagName('img');\
        var length=imgs.length;\
        for(var i=0;i<length;i++){\
        img=imgs[i];\
        img.onclick=function(){\
        window.location.href='image-preview:'+this.src}\
        }\
        }";
        _userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    }
    return _userScript;
}
@end
