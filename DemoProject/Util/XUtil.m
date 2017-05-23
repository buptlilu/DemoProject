//
//  UIImageTool.m
//  HiBuy
//
//  Created by youagoua on 15/3/21.
//  Copyright (c) 2015年 xiaoyou. All rights reserved.
//

#import "XUtil.h"
#import <objc/runtime.h>
#import "DKNightVersion.h"

@implementation XUtil

+ (NSMutableAttributedString *)stringWith:(NSString *)str keyWord:(NSString *)word font:(UIFont *)font lineSpace:(CGFloat)space {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    NSString *lword = [word lowercaseString];
    NSRange range = [[[XUtil handleStr:str] lowercaseString] rangeOfString:lword];
    if (range.length > 0) {
        long start = 0;
        while (start < str.length) {
            //需要判断左右是否都是字母
            BOOL isLeftPureLetter = YES;
            BOOL isRightPureLetter = YES;
            NSRange range = [str rangeOfString:lword options:NSCaseInsensitiveSearch range:NSMakeRange(start, str.length - start)];
            
            if ((NSInteger)range.location <= 0) {
                isLeftPureLetter = NO;
            }else if((NSInteger)range.location > 0 && range.location + range.length <= str.length){
                isLeftPureLetter = [XUtil isPureLetters:[str substringWithRange:NSMakeRange(range.location - 1, 1)]];
            }
            
            if (range.location + range.length >= str.length) {
                isRightPureLetter = NO;
            }else if ((NSInteger)range.location >=0 && range.location + range.length < str.length){
                isRightPureLetter = [XUtil isPureLetters:[str substringWithRange:NSMakeRange(range.location + range.length, 1)]];
            }
            
            if (isLeftPureLetter == NO && isRightPureLetter == NO) {
                UIColor *color = [XUtil isDay] ? [XUtil hexToRGB:@"02B884"] : [XUtil hexToRGB:@"02996E"];
                [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            start = range.location + range.length;
        }
    }
    return attrStr;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+ (NSString *)handleStr:(NSString *)str {
    str = [NSString stringWithFormat:@"%@", str];
    if (str && str.length && ![str isEqualToString:@"(null)"] && ![str isEqualToString:@"<null>"]) {
        return str;
    }else{
        return @"";
    }
}

+ (BOOL)checkString:(NSString *)strA containsString:(NSString *)strB {
    return [strA rangeOfString:strB].location != NSNotFound;
}

+ (BOOL)isPureLetters:(NSString *)str {
    for(int i=0;i<str.length;i++){
        unichar c=[str characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            return NO;
    }
    return YES;
}

+ (NSString *)stringToJson:(id)temps   //把字典和数组转换成json字符串
{
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:temps
                                                      options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs=[[NSString alloc] initWithData:jsonData
                                         encoding:NSUTF8StringEncoding];
    return strs;
}

+ (NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time{
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    
    if (second > 9) {
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    return [NSString stringWithFormat:@"%d:0%d",minute,second];
}
+ (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL)isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString *)getWordReviewJs {
    return [XUtil getPluginJsWithName:@"initial"];
}

+ (NSString*)getCatchPluginJs {
    return [XUtil getPluginJsWithName:@"browser"];
}

+ (NSString*)getInitialPluginJs {
    return [XUtil getPluginJsWithName:@"jquery-1.4.4.min"];
}

+ (NSString*)getAnnotationPluginJs {
    return [XUtil getPluginJsWithName:@"annotation"];
}

+ (NSString*)getPluginJsWithName:(NSString*)name {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:name ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    return js;
}

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
//    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (long)dateToLong:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return [strDate longLongValue];
}

+ (NSDate *)stringToDate:(NSString *)strDate
{
    //设置转换格式
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy.MM.dd"];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:strDate];
    return date;
}

+ (NSString *) returnAddrTimeToString:(NSDate *)startTime endTime:(NSDate *)endTime returnAddr:(NSString*)addr
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    double nowTime=time;      //NSTimeInterval返回的是double类型
    double endTimeSince1970 = endTime.timeIntervalSince1970;
    double startTimeSince1970 = startTime.timeIntervalSince1970;
    if(nowTime<startTimeSince1970){
        int interval = (startTimeSince1970-nowTime)/86400;
        if(interval==1){
            return [NSString stringWithFormat:@"今天从%@出发",addr];
        }
        return [NSString stringWithFormat:@"%i天后从%@出发",interval,addr];

    }else if(nowTime < endTimeSince1970){
        int  interval = (endTimeSince1970-nowTime)/86400 +1;
        if(interval==1){
            return [NSString stringWithFormat:@"今天回到%@",addr];
        }
        return [NSString stringWithFormat:@"%i天后回到%@",interval,addr];
    }else if(nowTime >= endTimeSince1970){
        int  interval = (nowTime-endTimeSince1970)/86400 +1;
        if(interval==1){
            return [NSString stringWithFormat:@"今天回到%@",addr];
        }
        return [NSString stringWithFormat:@"已回到%@%i天",addr,interval];
    }
    return @"未知";
}

+ (NSString *)dateToSimpleString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM.dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (int)isSameDay:(NSDate *)date otherDay:(NSDate *)otherDate{
    NSString * dateStr =[XUtil dateToSimpleString:date];
    NSString * aDateStr =[XUtil dateToSimpleString:otherDate];
    if([dateStr isEqualToString:aDateStr] ){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)dateToTimeString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (UIColor *) hexToRGB:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2 ;
    range.location = 0 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&red];
    range.location = 2 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&green];
    range.location = 4 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:1.0f ];
}

+ (UIColor *) hexToRGB:(NSString *)hexColor setAlpha:(CGFloat)alpha;
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2 ;
    range.location = 0 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&red];
    range.location = 2 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&green];
    range.location = 4 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:alpha ];
}

+ (UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (BOOL) containsObject:(NSMutableArray *)arrays getObject:(NSString *)object
{
    for (NSString *tmp in arrays) {
        if ([[NSString stringWithFormat:@"%@",tmp] isEqualToString:[NSString stringWithFormat:@"%@",object]]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isDay{
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    BOOL isDay = (manager.themeVersion == DKThemeVersionNormal) ? YES: NO;
    return  isDay;
}

+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity) {
        
        for (NSString *keyName in [dict allKeys]) {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            //如果是description，转为descriptions
            if([keyName isEqualToString:@"description"]){
                destMethodName = [NSString stringWithFormat:@"set%@:",[@"descriptions" capitalizedString]];
            }
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector]) {
                NSString *data = [dict objectForKey:keyName];
                [entity performSelector:destMethodSelector withObject:data];
            }
            
        }//end for
        
    }//end if
}

+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        NSString *property = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        if([property isEqualToString:@"content"] || [property isEqualToString:@"isFavor"] || [property isEqualToString:@"isDownload"]){
            continue;
        }
        id value;
        @try {
            value =  [entity performSelector:NSSelectorFromString(property)];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        if(value !=nil){
            [valueArray addObject:value];
            [propertyArray addObject:property];
        }
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    YDLog(@"%@", returnDic);
    
    return returnDic;
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        YDLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


@end
