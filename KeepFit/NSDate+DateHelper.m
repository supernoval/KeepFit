//
//  DateHelper.m
//  KeepFit
//
//  Created by Haikun Zhu on 15/5/14.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "NSDate+DateHelper.h"

@implementation NSDate(DateHelper)

+(NSString*)HHmmStringWithDate:(NSDate *)date
{
    
    NSString *dateStr = @"";
    
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger uinitFlag =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [currentCalendar components:uinitFlag fromDate:date];
    
//    NSInteger year = [components year];
//    NSInteger month = [components month];
//    NSInteger day = [components day];
    
    NSInteger hour = [components hour];
    
    NSInteger minute = [components minute];
    
    dateStr = [NSString stringWithFormat:@"%ld:%ld",hour,minute];
    
    
    
    
    return dateStr;
    
}

+(NSString*)HHStringWithDate:(NSDate *)date
{
    
    NSString *dateStr = @"";
    
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger uinitFlag =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [currentCalendar components:uinitFlag fromDate:date];
    
//    NSInteger year = [components year];
//    NSInteger month = [components month];
//    NSInteger day = [components day];
    
    NSInteger hour = [components hour];
    
//    NSInteger minute = [components minute];
    
    dateStr = [NSString stringWithFormat:@"%ld",hour];
    
    
    
    
    return dateStr;
}

+(NSString*)mmStringWithDate:(NSDate *)date
{
    
    NSString *dateStr = @"";
    
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger uinitFlag =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [currentCalendar components:uinitFlag fromDate:date];
    
//    NSInteger year = [components year];
//    NSInteger month = [components month];
//    NSInteger day = [components day];
//    
//    NSInteger hour = [components hour];
    
    NSInteger minute = [components minute];
    
    dateStr = [NSString stringWithFormat:@"%ld",minute];
    
    
    
    
    return dateStr;
}

@end
