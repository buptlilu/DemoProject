//
//  YDNavigationController.m
//  sw-reader
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 lilu. All rights reserved.
//

#import "YDNavigationController.h"
#import "UIViewController+JTNavigationExtension.h"

@interface YDNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@end

@implementation YDNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    // Do any additional setup after loading the view.
    
    
//    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
//    gesture.enabled = NO;
//    UIView *gestureView = gesture.view;
//    
//    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
//    popRecognizer.delegate = self;
//    popRecognizer.maximumNumberOfTouches = 1;
//    [gestureView addGestureRecognizer:popRecognizer];
//    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
//    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
    // 获取系统自带滑动手势的target对象
//    id target = self.interactivePopGestureRecognizer.delegate;
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
//    self.interactivePopGestureRecognizer.enabled = NO;
}


#pragma mark - UIGestureRecognizerDelegate
//这个方法在视图控制器完成push的时候调用
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
//    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
//    if (self.childViewControllers.count == 1 || [[self valueForKey:@"_isTransitioning"] boolValue]) {
//        // 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//    }else if([self.childViewControllers.lastObject isKindOfClass:[MyChannelViewController class]]){
//        return NO;
//    }else if([self.childViewControllers.lastObject isKindOfClass:[BrowserViewController class]]){
//        return NO;
//    }
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return NO;
//}
@end
