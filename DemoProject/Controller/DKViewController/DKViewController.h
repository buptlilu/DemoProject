//
//  ViewController.h
//  sw-reader
//
//  Created by lilu on 4/4/16.
//  Copyright © 2016 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersion.h"

//#define DKColor_White DKColorWithRGB(0xffffff, 0x28282a);
//#define DKColor_f3f3f3 DKColorWithRGB(0xf3f3f3, 0x28282a);
#define DKColor_f2f2f2 DKColorWithRGB(0xf2f2f2, 0x28282a);
//#define DKColor_e1e1e1 DKColorWithRGB(0xe1e1e1, 0x28282a);
//#define DKColor_f0f0f0 DKColorWithRGB(0xf0f0f0, 0x3a3a3d);
//#define DKColor_1e1f20 DKColorWithRGB(0x1e1f20, 0x8f969b);
//单词子标题
//#define DKColor_666666 DKColorWithRGB(0x666666, 0x767c81);
//单词标题
//#define DKColor_333333 DKColorWithRGB(0x333333, 0x6f757a);
//#define DKColor_F0EBE5 DKColorWithRGB(0xF0EBE5, 0x2b2b2b);
#define DKColor_f7f7f7 DKColorWithRGB(0xf7f7f7, 0x2e2e30);
//#define DKColor_808080 DKColorWithRGB(0x808080, 0x28282a);
//#define DKColor_191919 DKColorWithRGB(0x191919, 0x191919);
//首页子标题
//#define DKColor_4D4D4D DKColorWithRGB(0x4D4D4D, 0x767c81);
//#define DKColor_02b884 DKColorWithRGB(0x02b884, 0x28282a);
//#define DKColor_d6d6d6 DKColorWithRGB(0xd6d6d6, 0x28282a);
//#define DKColor_eeeeee DKColorWithRGB(0xeeeeee, 0x28282a);
//#define DKColor_555555 DKColorWithRGB(0x555555, 0x28282a);
//#define DKColor_aaaaaa DKColorWithRGB(0xaaaaaa, 0x28282a);
#define DKColor_f5f5f5 DKColorWithRGB(0xf5f5f5, 0x28282a);
#define DKColor_ffcc00 DKColorWithRGB(0xffcc00, 0x28282a);
//#define DKColor_fcfcfc DKColorWithRGB(0xfcfcfc, 0x28282a);
//首页大标题
//#define DKColor_000000 DKColorWithRGB(0x000000, 0x8f969b);
//#define DKColor_cccccc DKColorWithRGB(0xcccccc, 0x28282a);
//#define DKColor_b6b6b6 DKColorWithRGB(0xb6b6b6, 0x28282a);
//#define DKColor_909090 DKColorWithRGB(0x909090, 0x28282a);
//#define DKColor_404040 DKColorWithRGB(0x404040, 0x28282a);
#define DKColor_f8f8f8 DKColorWithRGB(0xf8f8f8, 0x28282a);
//#define DKColor_f6f6f6 DKColorWithRGB(0xf6f6f6, 0xf6f6f6);
//#define DKColor_dddddd DKColorWithRGB(0xdddddd, 0x6a6a6a);
//#define DKColor_f1f1f1 DKColorWithRGB(0xf1f1f1, 0x303033);

//背景
#define DKColor_BACKGROUND DKColorWithRGB(0xFFFFFF, 0x232226);
#define DKColor_BACKGROUND_Dialog DKColorWithRGB(0xFFFFFF, 0x303033);
#define DKColor_BACKGROUND_FEED DKColorWithRGB(0xF2F3F5, 0x2E2E30);
#define DKColor_BACKGROUND_FAFAFA DKColorWithRGB(0xFAFAFA, 0x222224);

//设置界面背景颜色
#define DKColor_BACKGROUND_TABBAR_SPACE DKColorWithRGB(0xCCCCCC, 0x19181C);
#define DKColor_BACKGROUND_Setting DKColorWithRGB(0xF0F0F0, 0x212024);
#define DKColor_BACKGROUND_BOOKDETAIL DKColorWithRGB(0x343F51, 0x343F51);
#define DKColor_BACKGROUND_BOOKBROWSER DKColorWithRGB(0xF5F7F8 , 0x232226);
#define DKColor_BACKGROUND_BOOKBROWSER_NAVANDBOTTOM DKColorWithRGB(0xFFFFFF, 0x2A292E);
#define DKColor_BACKGROUND_TABBAR DKColorWithRGB(0xF5F5F5 , 0x1E1D21);
#define DKColor_BACKGROUND_NAVBAR DKColorWithRGB(0xFFFFFF, 0x040405);
#define DKColor_BACKGROUND_NAVBAR_SEARCH DKColorWithRGB(0xF8F8F8, 0x09090A);
#define DKColor_BACKGROUND_SEGMENT DKColorWithRGB(0x02B884, 0x979EA5);
#define DKColor_BACKGROUND_CELL_SELECT DKColorWithRGB(0xDEDEDE, 0x3A3A3D);

//搜索热词

//三种灰度级别
//大标题，导航栏文字颜色
#define DKColor_TEXTCOLOR_TITLE DKColorWithRGB(0x333333, 0x8f969b);
#define DKColor_TEXTCOLOR_TITLE_REVERSE DKColorWithRGB(0x8f969b, 0x333333);
//图书详情标题颜色
#define DKColor_TEXTCOLOR_TITLE_DETAIL DKColorWithRGB(0xFFFFFF, 0xB3B3B3);
//段落文字颜色，例如详情页的大段文字
#define DKColor_TEXTCOLOR_SUBTITLE DKColorWithRGB(0x666666, 0x767c81);
//辅助文字颜色，例如时间日期等
#define DKColor_TEXTCOLOR_TEXT DKColorWithRGB(0x999999, 0x585d61);
#define DKColor_TEXTCOLOR_DETAIL DKColorWithRGBA(0x999999, 0xCCCCCC, 1.0, 0.5);
#define DKColor_TEXTCOLOR_NAME_HOMEPAGE DKColorWithRGB(0xFFFFFF, 0xFFFFFF);

//图书章节页码文字颜色
#define DKColor_BOOK_PAGECHAPTER DKColorWithRGB(0x999999, 0x585d61);

//导航栏标题：使用标题的颜色
#define DKColor_TEXTCOLOR_NAV_TITLE DKColor_TEXTCOLOR_TITLE;
//文本框输入提示文字颜色
#define DKColor_TEXTCOLOR_HINT DKColorWithRGB(0xCCCCCC, 0x3B3E40);
#define DKColor_TEXTCOLOR_HINT_REVERSE DKColorWithRGB(0x3B3E40, 0xCCCCCC);
//描边
#define DKColor_BORDER  DKColorWithRGB(0xE6E6E6, 0x3A3F44);
#define DKColor_BORDER_BOOKBROWSER  DKColorWithRGB(0xE6E6E6, 0x1E1D21);

//导航栏分割线
#define DKColor_BORDER_NAVBORDER DKColorWithRGB(0xCCCCCC, 0x19191C);

//绿色
#define DKColor_GREEN DKColorWithRGB(0x0ABA88, 0x0ABA88);
#define DKColor_CCCCCC DKColorWithRGB(0xCCCCCC, 0xCCCCCC);
#define DKColor_02B884 DKColorWithRGB(0x02B884, 0x02996E);
#define DKColor_888888 DKColorWithRGB(0x888888, 0x545454);


typedef void (^BSBasicBlock) (void);

@interface DKViewController : UIViewController
/**
 导航栏左view
 */
@property (nonatomic, strong) UIView *navBarLeftView;
/**
 导航栏标题view
 */
@property (nonatomic, strong) UILabel *navBarTitleView;
/**
 导航栏右view
 */
@property (nonatomic, strong) UIView *navBarRightView;
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)addOperation:(BSBasicBlock) operation beginBlock:(BSBasicBlock)begin finishBlock:(BSBasicBlock)finish;
- (void)dkNightModel;
/**
 设置导航栏左view
 */
- (void)setUpNavBarLeftView;
/**
 设置导航栏标题view

 @param title 标题
 */
- (void)setUpNavBarTitleView:(NSString *)title;
/**
 设置导航栏右view

 @param imageName 图片名称
 */
- (void)setUpNavBarRightView:(DKImagePicker)imagePicker;
/**
 导航栏右view点击事件
 */
- (void)navBarRightViewTap;
@end
