//
//  YDNavigationController.h
//  sw-reader
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTNavigationController.h"

@interface YDNavigationController : JTNavigationController
@property(nonatomic,weak) UIViewController *currentShowVC;
@end
