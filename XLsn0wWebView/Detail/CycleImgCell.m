//
//  WoodDetailTopImgCell.m
//  TimeForest
//
//  Created by TimeForest on 2018/11/7.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "CycleImgCell.h"

@implementation CycleImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = AppRedTextColor;
        [self drawSubviews];
//        [self noneCellSelection];
    }
    return self;
}

- (void)drawSubviews {
    _cycle = [XLsn0wCycle cycleWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageURLs:@[]];
    [self addSubview:_cycle];
    _cycle.pageControlStyle = PageContolStyleClassic;
    _cycle.currentPageDotColor = UIColor.redColor;
}

- (void)loadImageURLs:(NSDictionary *)data {
    _cycle.imageURLs = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546502819&di=e39269c351392f96d94b9ae06beed98e&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FZZ5EGyuUCp9hBPk6_s4Ehg%3D%3D%2F5727171351132208489.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545908102380&di=1feade6c92674574704493bf951e2318&imgtype=0&src=http%3A%2F%2Fpic26.nipic.com%2F20121227%2F10193203_131357536000_2.jpg"];
}

@end
