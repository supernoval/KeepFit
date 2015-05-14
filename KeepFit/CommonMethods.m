//
//  CommonMethods.m
//  Xianghu
//
//  Created by iMac on 14-7-7.
//  Copyright (c) 2014年 Xianghu. All rights reserved.
//

#import "CommonMethods.h"


@implementation CommonMethods


+(NSInteger)getDay:(NSString *)dateStr
{
    NSDateFormatter *fromatter = [[NSDateFormatter alloc]init];
    
    [fromatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date = [fromatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
  
    
    NSInteger dateFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:dateFlag fromDate:date];
    
    NSInteger today = [components day];
    
    
    return today;
    
                                    
    
}

+(NSDate*)getYYYMMddFromString:(NSString *)dateStr
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateformatter dateFromString:dateStr];
    
    return date;
    
}

+(NSString*)getYYYYMMddFromDefaultDateStr:(NSDate *)date
{
 
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *finalDateStr = [dateformatter stringFromDate:date];
    
    
    return finalDateStr;
    
    
}

+(NSString*)getHHmmFromDefaultDateStr:(NSDate *)date
{
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:date];
    
    return timeStr;
    
}

+(NSString*)getYYYYMMddhhmmDateStr:(NSDate *)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd  hh:mm"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:date];
    
    return timeStr;
}



#pragma mark - UILabel
+(UILabel*)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAligment:(NSTextAlignment)alignment frame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.text = text;
    
    label.textColor = textColor;
    label.font = font;
    
    label.textAlignment = alignment;
    
    
    
    return label;
    
    
}


#pragma mark - UILabel
+(UILabel*)LabelWithText:(NSString *)labeltext andTextAlgniment:(NSTextAlignment)alignment andTextColor:(UIColor *)textcolor andTextFont:(UIFont *)textFont andFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = labeltext;
    label.textAlignment = alignment;
    label.textColor = textcolor;
    label.font = textFont;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
    
}



+ (BOOL)checkTel:(NSString *)str
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3r[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    /**
     29         * 新增淘宝等号段
     30         * 170,176,177,178,147
     31         */
    NSString *TB = @"^1(7[0678]|4[7])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regexttexttb = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TB];
    
    if (([regextestmobile evaluateWithObject:str] == YES)
        || ([regextestcm evaluateWithObject:str] == YES)
        || ([regextestcu evaluateWithObject:str] == YES)
        || ([regextestct evaluateWithObject:str] == YES)
        || ([regextestphs evaluateWithObject:str] == YES)
        || [regexttexttb evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark - 判断Email格式是否正确
+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

#pragma mark - 判断用户名
+(BOOL)isRightUserName:(NSString*)Username
{
    NSString *usernameCheck = @"^[_\\w\\d\\x{4e00}-\\x{9fa5}]{2,20}$";
    
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",usernameCheck];
    
    return [usernameTest evaluateWithObject:Username];
    
    
}

#pragma mark - 密码
+(BOOL)isRightCode:(NSString*)code
{
    NSString *codeCheck = @"^[\\~!@#$%^&*()-_=+|{}\\[\\],.?\\/:;\'\"\\d\\w]{6,16}$";
    
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",codeCheck];
    
    //NSLog(@"%s,%@",__func__,code);
    
    return [codeTest evaluateWithObject:code];
    
    
}



#pragma mark - 异步请求图片
+(void)setImageViewWithImageURL:(NSString *)url imageView:(UIImageView *)imageView
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        if (image != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                imageView.image = image;
                
            });
        }
 
        
        
    });
    
}

+(void)setButtonImageWithImageURL:(NSString*)url button:(UIButton*)button
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        if (image != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [button setImage:image forState:UIControlStateNormal];
                
            });
        }
        
        
        
    });
}





#pragma mark - 对图片进行大小压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - 将中间字符变成 ****
+(NSString*)geteditedmobile:(NSString*)mobile
{
    NSString *editemobile = mobile;
    
    NSString *firstThreeStr = [editemobile substringToIndex:3];
    
    NSString *lastThreeStr = [editemobile substringFromIndex:8];
    
    editemobile = [NSString stringWithFormat:@"%@****%@",firstThreeStr,lastThreeStr];
    
    
    
    return editemobile;
    
}

+(BOOL)isBetweenTheTime:(NSString*)startTime endTime:(NSString*)endTime
{
    
    if (startTime == nil || endTime == nil) {
        
        return NO;
        
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    
    NSDate *startDate = [formatter dateFromString:startTime];
    
    NSDate *endDate = [formatter dateFromString:endTime];
    
    
    NSDate *now = [NSDate date];
    
    if ([now isEqualToDate:[now laterDate:startDate]] && [now isEqualToDate:[now earlierDate:endDate]])
    {
        
        
        return YES;
        
        
        
    }
    
    return NO;
    
    
}


#pragma mark - 截取中间矩形图片
+(UIImage*)imageWithImage:(UIImage*)image imageRect:(CGRect)rect
{
    
    UIImage *getImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
    
    return getImage;
    
    
}

@end
