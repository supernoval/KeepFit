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
    
    dateStr = [NSString stringWithFormat:@"%ld:%ld",(long)hour,(long)minute];
    
    
    
    
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
    
    dateStr = [NSString stringWithFormat:@"%ld",(long)hour];
    
    
    
    
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
    
    dateStr = [NSString stringWithFormat:@"%ld",(long)minute];
    
    
    
    
    return dateStr;
}

+(NSString*)MMddStringWithDate:(NSDate *)date
{
    
  
    NSString *dateStr = @"";
    
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger uinitFlag =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [currentCalendar components:uinitFlag fromDate:date];
    
    
    NSInteger month = [components month];
    NSInteger day = [components day];


    dateStr = [NSString stringWithFormat:@"%ld/%ld",(long)month,(long)day];
    
    return dateStr;
}

@end
