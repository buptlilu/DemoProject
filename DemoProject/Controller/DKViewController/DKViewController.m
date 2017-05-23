//
//  ViewController.m
//  sw-reader
//
//  Created by lilu on 4/4/16.
//  Copyright © 2016 lilu. All rights reserved.
//

#import "DKViewController.h"
#import "DKNightVersion.h"

static dispatch_queue_t bs_operation_processing_queue;
static dispatch_queue_t operation_processing_queue() {
    if (bs_operation_processing_queue == NULL) {
        bs_operation_processing_queue = dispatch_queue_create("operation.bisheng.youdao.com", 0);
    }
    return bs_operation_processing_queue;
}

@interface DKViewController ()

@end

@implementation DKViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColor_BACKGROUND_NAVBAR;
    //self.navigationController.navigationBar.dk_tintColorPicker = DKColor_BACKGROUND_NAVBAR;
    //self.navigationController.navigationBar.dk_backgroundColorPicker = DKColor_BACKGROUND_NAVBAR;
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.dk_backgroundColorPicker = DKColor_BACKGROUND;
}

#pragma mark - functions
- (NSOperationQueue *)queue {
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    _queue = queue;
    return _queue;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)addOperation:(BSBasicBlock)operation beginBlock:(BSBasicBlock)begin finishBlock:(BSBasicBlock)finish {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (begin) {
            begin();
        }
        dispatch_async(operation_processing_queue(), ^{
            if (operation) {
                operation();
            }
            dispatch_async(dispatch_get_main_queue(),^{
                if (finish) {
                    finish();
                }
            });
        });
    });
}

- (void)setUpNavBarLeftView {
    CGSize barSize = CGSizeMake(24,24);
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width * 82 /640, kTopBarHeight)];
    UIImageView *leftPicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kTopBarHeight - barSize.height - 9, barSize.width, barSize.height)];
    leftPicView.dk_imagePicker = DKImageWithNames(@"index_ic_BackArrow_day", @"index_ic_BackArrow_day_night");
    [leftView addSubview:leftPicView];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backIndex)];
    [leftView addGestureRecognizer:leftTap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navBarLeftView = leftView;
}

- (void)setUpNavBarTitleView:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = NavBarTitleFont;
    [titleLabel setTextColor:[XUtil hexToRGB:@"333333"]];
    titleLabel.dk_textColorPicker = DKColor_TEXTCOLOR_TITLE;
    NSString *titleStr = [NSString stringWithFormat:@" %@ ", title];
    CGSize titleStrSize = [XUtil sizeWithString:titleStr font:NavBarTitleFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    titleLabel.frame = CGRectMake(0,50, titleStrSize.width,titleStrSize.height);
    titleLabel.text = titleStr;
    self.navigationItem.titleView = titleLabel;
    self.navBarTitleView = titleLabel;
}

- (void)setUpNavBarRightView:(DKImagePicker)imagePicker;{
    CGSize barSize = CGSizeMake(24, 24);
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTopBarHeight, kTopBarHeight)];
    UIImageView *rightPicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kTopBarHeight - barSize.height - 9, barSize.width, barSize.height)];
    rightPicView.dk_imagePicker = imagePicker;
    [rightView addSubview:rightPicView];
    [rightPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(barSize);
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.right.equalTo(rightView);
    }];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBarRightViewTap)];
    [rightView addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navBarRightView = rightView;
}

- (void)navBarRightViewTap {
    
}

- (void)backIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - 播放器相关
//// 哪些页面支持自动转屏
//- (BOOL)shouldAutorotate{
//    RDVTabBarController *rootVc = (RDVTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    YDLog(@"rootVc class:%@", NSStringFromClass([rootVc class]));
//    if (rootVc == nil || ![rootVc isKindOfClass:[RDVTabBarController class]] || rootVc.viewControllers.count == 0) {
//        return NO;
//    }
//    UINavigationController *nav = rootVc.viewControllers[rootVc.selectedIndex];
//    // MoviePlayerViewController 、ZFTableViewController 控制器支持自动转屏
//    //这里由于在用动画的时候对vc包了一层nav和另一个vc，所以这里处理就比较复杂，需要把vc层级都取出来
//    UIViewController *vc = nav.topViewController;// vcclass:JTWrapViewController
//    if (vc == nil || vc.childViewControllers.count == 0) {
//        return NO;
//    }
//    JTWrapNavigationController *subNav = (JTWrapNavigationController *)vc.childViewControllers.lastObject;
//    UIViewController *subVc = subNav.topViewController;
//    YDLog(@"vcclass:%@", NSStringFromClass([subVc class]));
//    if ([subVc isKindOfClass:[VideoViewController class]]) {
//        // 调用ZFPlayerSingleton单例记录播放状态是否锁定屏幕方向
//        if (ZFPlayerShared.isLockScreen) {
//            return NO;
//        }
//        return YES;
//    }
//    return NO;
//}
//
//// viewcontroller支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    RDVTabBarController *rootVc = (RDVTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    YDLog(@"rootVc class:%@", NSStringFromClass([rootVc class]));
//    if (rootVc == nil || ![rootVc isKindOfClass:[RDVTabBarController class]] || rootVc.viewControllers.count == 0) {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    UINavigationController *nav = rootVc.viewControllers[rootVc.selectedIndex];
//    //这里由于在用动画的时候对vc包了一层nav和另一个vc，所以这里处理就比较复杂，需要把vc层级都取出来
//    UIViewController *vc = nav.topViewController;// vcclass:JTWrapViewController
//    if (vc == nil || vc.childViewControllers.count == 0) {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    JTWrapNavigationController *subNav = (JTWrapNavigationController *)vc.childViewControllers.lastObject;
//    UIViewController *subVc = subNav.topViewController;
//    if ([subVc isKindOfClass:[VideoViewController class]]) { // VideoViewController这个页面支持转屏方向
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    // 其他页面
//    return UIInterfaceOrientationMaskPortrait;
//}

//-(void) dkNightModel{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *dkNight = [userDefaults objectForKey:@"dkNight"];
//    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
//    if (dkNight == nil || [dkNight isEqualToString:@""] || [dkNight isEqualToString:@"0"]) {
//        dkNight = @"0";
//        [userDefaults setObject:dkNight forKey:@"dkNight"];
//        manager.themeVersion = DKThemeVersionNormal;
//        [DKNightVersionManager dawnComing];
//    }else{
//        manager.themeVersion = DKThemeVersionNight;
//        [DKNightVersionManager nightFalling];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
