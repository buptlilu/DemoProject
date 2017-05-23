//
//  JTNavigationController.m
//  JTNavigationController
//
//  Created by Tian on 16/1/23.
//  Copyright © 2016年 TianJiaNan. All rights reserved.
//

#import "JTNavigationController.h"
#import "UIViewController+JTNavigationExtension.h"
#import "YDFullScreenGesManager.h"

#define kDefaultBackImageName @"backImage"

#pragma mark - JTWrapNavigationController



@implementation JTWrapNavigationController

/*
 //获得导航栏子vc方式
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 JTNavigationController *jt_navigationController = self.jt_navigationController;
 NSInteger index = jt_navigationController.jt_viewControllers.count - 1 - 2;
 for (int i = 0; i < jt_navigationController.jt_viewControllers.count; i++) {
 YDLog(@"class1:%d----%@", i, NSStringFromClass([jt_navigationController.jt_viewControllers[i] class]));
 YDLog(@"class2:%d----%@", i, NSStringFromClass([jt_navigationController.viewControllers[i] class]));
 }
 //pop至指定索引vc方式
 [self.navigationController popToViewController:jt_navigationController.jt_viewControllers[index] animated:YES];
 }
 */

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    JTNavigationController *jt_navigationController = viewController.jt_navigationController;
    NSInteger index = [jt_navigationController.jt_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:jt_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.jt_navigationController = (JTNavigationController *)self.navigationController;
    viewController.jt_fullScreenPopGestureEnabled = viewController.jt_navigationController.fullScreenPopGestureEnabled;
    
    UIImage *backButtonImage = viewController.jt_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
//    [self.navigationController pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[JTWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.jt_navigationController=nil;
}

@end

#pragma mark - JTWrapViewController

static NSValue *jt_tabBarRectValue;

@implementation JTWrapViewController

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    JTWrapNavigationController *wrapNavController = [[JTWrapNavigationController alloc] init];
//    JTWrapNavigationController *wrapNavController = [[JTWrapNavigationController alloc] initWithRootViewController:viewController];
    wrapNavController.viewControllers = @[viewController];
    JTWrapViewController *wrapViewController = [[JTWrapViewController alloc] init];
    viewController.view.frame = [UIScreen mainScreen].bounds;
    wrapNavController.view.frame = [UIScreen mainScreen].bounds;
    wrapViewController.view.frame = [UIScreen mainScreen].bounds;
//    wrapViewController.view.backgroundColor = [UIColor redColor];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    YDLog(@"warp:frame:%@", NSStringFromCGRect(wrapViewController.view.frame));
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !jt_tabBarRectValue) {
        jt_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    YDLog(@"viewDidAppear:frame:%@", NSStringFromCGRect(self.view.frame));
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    YDLog(@"viewWillAppear:frame:%@", NSStringFromCGRect(self.view.frame));
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && jt_tabBarRectValue) {
        self.tabBarController.tabBar.frame = jt_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)jt_fullScreenPopGestureEnabled {
    return [self rootViewController].jt_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    JTWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end

#pragma mark - JTNavigationController

@interface JTNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@end

@implementation JTNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:rootViewController]];
        self.title = rootViewController.title;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.delegate = self;
    self.popPanGesture.maximumNumberOfTouches = 1;
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.jt_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.popPanGesture.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UIGestureRecognizerDelegate
//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
//}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if ([YDFullScreenGesManager sharedInstance].isForbidFullScreenGes) {
        return NO;
    }
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}
#pragma mark - Getter

- (NSArray *)jt_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (JTWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

@end
