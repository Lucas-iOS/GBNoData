//
//  UICollectionView+NoData.m
//  GBNoDataView
//
//  Created by Lucas on 2018/1/9.
//  Copyright © 2018年 Lucas. All rights reserved.
//

#import "UICollectionView+NoData.h"
#import <objc/runtime.h>
#import "GBRuntimeUtil.h"

@implementation UICollectionView (NoData)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:),
        @selector(deleteSections:),
        @selector(reloadSections:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"gb_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        [GBRuntimeUtil swizzMethod:[self class] oriSel:originalSelector newSel:swizzledSelector];
    }
}

- (void)gb_insertSections:(NSIndexSet *)sections{
    [self gb_insertSections:sections];
    [self showNoDataView];
}

- (void)gb_deleteSections:(NSIndexSet *)sections {
    [self gb_deleteSections:sections];
    [self showNoDataView];
}

- (void)gb_reloadSections:(NSIndexSet *)sections {
    [self gb_reloadSections:sections];
    [self showNoDataView];
}

- (void)showNoDataView {
    if (self.showNoData) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource collectionView:self numberOfItemsInSection:i];
        }
        if (rowCount == 0 && self.customNoDataView) {
            self.backgroundView = [self customNoDataView];
        } else {
            self.backgroundView = [[UIView alloc] init];
        }
    }
}

#pragma mark - setter && getter
- (void)setShowNoData:(BOOL)showNoData {
    objc_setAssociatedObject(self, @selector(showNoData), @(showNoData), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)showNoData {
    return objc_getAssociatedObject(self, _cmd) == nil ? YES : [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCustomNoDataView:(UIView *)customNoDataView {
    self.showNoData = YES;
    objc_setAssociatedObject(self, @selector(customNoDataView), customNoDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customNoDataView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCallBack:(LoadDataCallBack)callBack {
    self.showNoData = YES;
    objc_setAssociatedObject(self, @selector(callBack), callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIView *))callBack {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)gb_tapDefalutNoDataView:(UITapGestureRecognizer *)tap {
    self.callBack ? self.callBack(self.customNoDataView) : nil;
}

@end
