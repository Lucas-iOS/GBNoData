//
//  GBRuntimeUtil.h
//  GBNoDataView
//
//  Created by Lucas on 2018/1/9.
//  Copyright © 2018年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GBRuntimeUtil : NSObject
+ (void)swizzMethod:(Class)viewClass oriSel:(SEL)oriSel newSel:(SEL)newSel;

@end
