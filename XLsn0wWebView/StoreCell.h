//
//  StoreCell.h
//  TimeForest
//
//  Created by TimeForest on 2018/10/29.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class StoreModel;

@interface StoreCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *descr;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *exchange;

@property (nonatomic, strong) UIImageView *furnitureIcon;

- (void)addData:(StoreModel*)model;


@end

NS_ASSUME_NONNULL_END
