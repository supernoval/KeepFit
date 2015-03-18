//
//  CommentMeths.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentMeths.h"

@implementation CommentMeths


+(NSDate*)getYYYYMMddDateWithDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"YYYY MM dd"];
    
    NSString *dateStr = [dateFormater stringFromDate:date];
    
    NSDate *YYYYMMddDate = [dateFormater dateFromString:dateStr];
    
    
    return YYYYMMddDate;
    
}

+(NSDate*)getYYYYMMdd0000DateWithDate:(NSDate *)date
{
    
    NSCalendar *currentCalent = [NSCalendar currentCalendar];
    
    NSInteger dateUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute;
    
    NSDateComponents *component = [currentCalent components:dateUnit fromDate:date];
    
    NSInteger year = component.year;
    NSInteger month = component.month;
    NSInteger day = component.day;
    
    NSString *temDateStr = [NSString stringWithFormat:@"%ld %ld %ld 00:00:00",(long)year,(long)month,(long)day];
    
    
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"YYYY MM dd hh:mm:ss"];
    
    //NSString *dateStr = [dateFormater stringFromDate:date];
    
    NSDate *YYYYMMddDate = [dateFormater dateFromString:temDateStr];
    
    
    return YYYYMMddDate;
}

+(NSDate*)getYYYYMMddHHmmssWithString:(NSString *)dateStr
{
    
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc]init];
    
    [_dateFormatter setDateFormat:@"YYYY:MM:dd HH:mm:ss"];
    
    NSDate *_myDate = [_dateFormatter dateFromString:dateStr];
    
    
    return _myDate;
    
}

+(UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textcolor frame:(CGRect )frame
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.text = text;
    
    label.font = font;
    
    label.textColor = textcolor;
    
    
    return  label;
    
    
    
}


@end
