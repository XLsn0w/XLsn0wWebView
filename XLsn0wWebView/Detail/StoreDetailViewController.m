//
//  StoreDetailViewController.m
//  TimeForest
//
//  Created by TimeForest on 2018/10/30.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "StoreDetailViewController.h"

#import "CycleImgCell.h"
#import "WebViewCell.h"

@interface StoreDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSDictionary *shareData;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, assign) int loadNumber;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeCellHeight:) name:@"ChangeCellHeight" object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addTableView];
}

- (void)ChangeCellHeight:(NSNotification *)noti {
    NSString *info = [[noti userInfo] objectForKey:@"frame"];
    _cellHeight = [info floatValue];
    if (!_isLoad) {
        [self.tableView reloadData];
        if (_loadNumber == 1) {
            _isLoad = YES;
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                self.tableView.alpha = 1;
            });
        }
        _loadNumber += 1;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];//
    view.backgroundColor = UIColor.redColor;
    return view;
}

//自定义section头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = ViewBgColor;
    [self.tableView registerClass:[CycleImgCell class] forCellReuseIdentifier:@"HomeDetailTopImgCell"];
    [self.tableView registerClass:[WebViewCell class] forCellReuseIdentifier:@"HomeDetailWebCell"];
//    [self.tableView estimated_iPhone_X];
    
//    @WeakObj(self);
//    [self.tableView addHeaderRefresh:YES animation:YES headerAction:^{
//        [selfWeak loadHeaderData];
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CycleImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeDetailTopImgCell"];
        [cell loadImageURLs:self.data];
        return cell;
    } else {
        WebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeDetailWebCell"];
        [cell loadURL:self.data];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else {
        XLsn0wLog(@"cellHeight = %f", _cellHeight);
        if (_cellHeight == 0) {
            return 0.1;
        } else {
            return _cellHeight;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
