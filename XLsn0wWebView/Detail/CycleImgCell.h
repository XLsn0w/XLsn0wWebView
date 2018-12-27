//
//  WoodDetailTopImgCell.h
//  TimeForest
//
//  Created by TimeForest on 2018/11/7.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

NS_ASSUME_NONNULL_BEGIN

@interface CycleImgCell : UITableViewCell

@property (nonatomic, strong) XLsn0wCycle *cycle;

- (void)loadImageURLs:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
