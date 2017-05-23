//
//  UIImageTool.h
//  HiBuy
//
//  Created by youagoua on 15/3/21.
//  Copyright (c) 2015年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@interface XUtil : NSObject

/**
 ** str:     原str
 ** word:    关键词
 ** font:    字体
 ** space:   段落间隔
 **/
+ (NSMutableAttributedString *)stringWith:(NSString *)str keyWord:(NSString *)word font:(UIFont *)font lineSpace:(CGFloat)space;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 *  处理字符串，如果为nil返回@"",否者返回自身
 *
 *  @param str 参数
 *
 *  @return 返回值
 */
+ (NSString *)handleStr:(NSString *)str;
/**
 *  检查字符串A里是否包含有B
 *
 *  @param strA A
 *  @param strB B
 *
 *  @return 结果
 */
+ (BOOL)checkString:(NSString *)strA containsString:(NSString *)strB;

/**
 *  判断一个字符串是否是纯字母
 *
 *  @param str 要判断的字符串
 *
 *  @return 结果
 */
+ (BOOL)isPureLetters:(NSString*)str;

/**
 *  把字典和数组转换成json字符串
 *
 *  @param temps 字段或数组
 *
 *  @return json字符串
 */
+ (NSString *)stringToJson:(id)temps;


/**
 *  根据时间s得到00:00样式时间
 *
 *  @param time 150
 *
 *  @return 02:30
 */
+ (NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time;

/**
 *  通过颜色生成图片
 *
 *  @param color color
 *
 *  @return image
 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color;

+ (BOOL)isEmpty:(NSString *) str;

+ (UIImage*) createImageWithColor: (UIColor*) color;

+ (NSString *)getWordReviewJs;

+ (NSString*)getInitialPluginJs;

+ (NSString*)getCatchPluginJs;

+ (NSString*)getAnnotationPluginJs;

+ (NSString*)getPluginJsWithName:(NSString*)name;

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

+ (NSString *)dateToString:(NSDate *)date;

+ (long)dateToLong:(NSDate *)date;

+ (NSDate *)stringToDate:(NSString *)strDate;

+ (NSString *)dateToSimpleString:(NSDate *)date;

+ (NSString *)dateToTimeString:(NSDate *)date;

+ (int)isSameDay:(NSDate *)date otherDay:(NSDate *)otherDate;

+ (NSString *) returnAddrTimeToString:(NSDate *)startTime endTime:(NSDate *)endTime returnAddr:(NSString*)addr;

+ (UIColor *) hexToRGB:(NSString *)hexColor;

+ (UIColor *) hexToRGB:(NSString *)hexColor setAlpha:(CGFloat)alpha;

+ (UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (BOOL)isDay;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image;
@end
