//
//  AppDelegate.m
//  DemoProject
//
//  Created by lilu on 2017/5/16.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "AppDelegate.h"
#import "YDNavigationController.h"
#import "DKViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.window = window;
    [window makeKeyAndVisible];
    [self setupViewControllers];
    return YES;
}

- (void)setupViewControllers {
    DKViewController *firstViewController = [[DKViewController alloc] init];
    YDNavigationController *firstNavigationController = [[YDNavigationController alloc] initWithRootViewController:firstViewController];
    firstNavigationController.currentShowVC = firstViewController;
    
    //    WMPageController *secondViewController = [BookViewUtil getPageController];
    //    BookMainViewController *secondViewController = [[BookMainViewController alloc] init];
    DKViewController *secondViewController = [[DKViewController alloc] init];
    YDNavigationController *secondNavigationController = [[YDNavigationController alloc] initWithRootViewController:secondViewController];
    
    DKViewController *thirdViewController = [[DKViewController alloc] init];
    YDNavigationController *thirdNavigationController = [[YDNavigationController alloc] initWithRootViewController:thirdViewController];
    
    
    DKViewController *fourthViewController = [[DKViewController alloc] init];
    YDNavigationController *fourthNavigationController = [[YDNavigationController alloc] initWithRootViewController:fourthViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    tabBarController.tabBar.dk_backgroundColorPicker = DKColor_BACKGROUND_TABBAR;
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]];
    [self customizeTabBarForController:tabBarController];
    self.window.rootViewController = tabBarController;
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"zhuye", @"book", @"vc_import", @"vc_mineTab"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blur",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.dk_backgroundColorPicker = DKColor_BACKGROUND_TABBAR;
        index++;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
