//
//  GBRuntimeUtil.m
//  GBNoDataView
//
//  Created by Lucas on 2018/1/9.
//  Copyright © 2018年 Lucas. All rights reserved.
//

#import "GBRuntimeUtil.h"
#import <objc/runtime.h>

@implementation GBRuntimeUtil
void swizzMethod(Class class, SEL oriSel, SEL newSel) {
    
    Method oriMethod = class_getInstanceMethod(class, oriSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL success = class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) {
        class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

+ (void)swizzMethod:(Class)viewClass oriSel:(SEL)oriSel newSel:(SEL)newSel {
    swizzMethod(viewClass, oriSel, newSel);
}

@end
