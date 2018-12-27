//
//  ViewController.m
//  XLsn0wWebView
//
//  Created by TimeForest on 2018/12/27.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "ViewController.h"
#import "StoreCell.h"
//#import "StoreModel.h"
#import "XLsn0wWebViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *newsUrls;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *headPics;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefreshing) name:@"endRefreshing" object:nil];
    [self addTableViewWithFrame:self.view.bounds];
//    [self addTableHeaderView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)endRefreshing {
//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    [AlertShow showAlertText:@"没有更多数据"];
//}

///加载数据
- (void)loadDataFromModelArray:(NSMutableArray *)modelArray {
    self.dataArray = modelArray;
    [self.tableView reloadData];
}

- (void)addTableViewWithFrame:(CGRect)frame {
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = ViewBgColor;
    [self.tableView registerClass:[StoreCell class] forCellReuseIdentifier:@"StoreCell"];
//    [self.tableView estimated_iPhone_X];
    
//    @WeakObj(self);
//    [self.tableView.nullImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(216);
//        make.height.mas_equalTo(92);
//        make.top.mas_equalTo(300);
//        make.centerX.mas_equalTo(selfWeak.tableView);
//    }];
//    self.tableView.nullHeight = 188;
//    self.tableView.nullLabel.hidden = YES;
//
//    [self.tableView addHeaderRefresh:YES animation:YES headerAction:^() {
//        [selfWeak.delegate addHeaderRefresh];
//    }];
//
//    [self.tableView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
//        NSLog(@"pageIndex:%zd",pageIndex);
//        [selfWeak.delegate addFooterRefreshFromIndex:pageIndex];
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    if (self.dataArray.count > 0) {
        [cell addData:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 312;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.cellAction) {
//        self.cellAction(self.dataArray[indexPath.row]);
//    }
    
  
    
     XLsn0wWebViewController *web = [[XLsn0wWebViewController alloc]init];
     // 隐藏导航条 注意隐藏导航条要在 appDelegate.m 中发送一个通知 SHOW_NAVBAR_NOTIFI, 以防在程序进入前台时导航条没有显示
     web.isHideNavigationBar = NO;
     
     //    web.canRefresh = YES;// 是否刷新
     //    web.canCopy = YES;
     //    // 1. 传 cookie
     //    web.cookieValue = [NSString stringWithFormat:@"%@=%@",@"testWKcookie", @"testWKcookievalue"];
     //    // WKUserScript 的 source 字符串
     //    web.sourceStr = [NSString stringWithFormat:@"document.cookie ='token=%@';document.cookie = 'os=ios';",@"你的token"];
     web.url = @"https://www.ithome.com/";
     [self.navigationController pushViewController:web animated:YES];
  
    
    
}

//- (void)addTableHeaderView {
//    UIView *tableHeaderView = [UIView new];
//    tableHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 188);
//    tableHeaderView.backgroundColor = ViewBgColor;
//
//    _cycle = [XLsn0wCycle cycleWithFrame:tableHeaderView.bounds imageURLs:@[]];
//    [tableHeaderView addSubview:_cycle];
//    _cycle.delegate = self;
//    _cycle.pageControlStyle = PageContolStyleClassic;
//    _cycle.currentPageDotColor = AppThemeColor;
//    _cycle.placeholderImage = [UIImage imageCompressForSize:[UIImage imageNamed:@"placeholderImageName"] targetSize:(CGSizeMake(kScreenWidth, 188))];
//
//    self.tableView.tableHeaderView = tableHeaderView;
//}

@end
