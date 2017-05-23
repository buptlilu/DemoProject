//
//  YDFullScreenGesManager.m
//  sw-reader
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 YouDao. All rights reserved.
//

#import "YDFullScreenGesManager.h"

@implementation YDFullScreenGesManager
+ (instancetype)sharedInstance {
    static YDFullScreenGesManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YDFullScreenGesManager alloc] init];
    });
    return manager;
}
@end
