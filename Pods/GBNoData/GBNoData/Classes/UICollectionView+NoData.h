//
//  UICollectionView+NoData.h
//  GBNoDataView
//
//  Created by Lucas on 2018/1/9.
//  Copyright © 2018年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoadDataCallBack)(UIView *view);

@interface UICollectionView (NoData)

//自定义无数据提示View
@property (nonatomic, strong) UIView *customNoDataView;
//Click回调
@property (nonatomic, copy) LoadDataCallBack callBack;

@end
