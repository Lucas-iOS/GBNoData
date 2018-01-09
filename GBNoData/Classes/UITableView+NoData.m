//
//  UITableView+NoData.m
//  GBNoDataView
//
//  Created by Lucas on 2018/1/8.
//  Copyright © 2018年 Lucas. All rights reserved.
//

#import "UITableView+NoData.h"
#import <objc/runtime.h>
#import "GBRuntimeUtil.h"

@implementation UITableView (NoData)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"gb_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        [GBRuntimeUtil swizzMethod:[self class] oriSel:originalSelector newSel:swizzledSelector];
    }
}

- (void)gb_reloadData {
    [self gb_reloadData];
    [self showNoDataView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gb_tapDefalutNoDataView:)];
    [self.customNoDataView addGestureRecognizer:tap];
}

- (void)gb_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_insertSections:sections withRowAnimation:animation];
    [self showNoDataView];
}

- (void)gb_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_deleteSections:sections withRowAnimation:animation];
    [self showNoDataView];
}

- (void)gb_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_reloadSections:sections withRowAnimation:animation];
    [self showNoDataView];
}

- (void)gb_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showNoDataView];
}

- (void)gb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showNoDataView];
}

- (void)gb_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self gb_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showNoDataView];
}

- (void)showNoDataView {
    if (self.showNoData) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource tableView:self numberOfRowsInSection:i];
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
