//
//  YDFullScreenGesManager.h
//  sw-reader
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 YouDao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDFullScreenGesManager : NSObject
@property (nonatomic, assign) BOOL isForbidFullScreenGes;
/**
 *  单例构造方法
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;
@end
