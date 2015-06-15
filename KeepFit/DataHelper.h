//
//  DataHelper.h
//  KeepFit
//
//  Created by Haikun Zhu on 15/6/5.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "NSDate+DateHelper.h"
#import "CommentMeths.h"

typedef NS_ENUM(NSInteger, WalkingStepsTimeType)
{
    
    WalkingStepsTimeTypeToday,
    
    WalkingStepsTimeTypeYesterday,
    
    WalkingStepsTimeTypeLastTwodays,
    
    WalkingStepsTimeTypeTheDayBeforeYesterday,
    
    WalkingStepsTimeTypeLastSevendays,
    
    WalkingStepsTimeTypeLastMonth
    
};


@interface DataHelper : NSObject

+(NSMutableArray*)sortDataValue:(NSMutableArray*)values withTimeType:(NSInteger)timtype;

+(NSMutableArray*)getDate:(NSMutableArray*)values withTimeType:(NSInteger)timetype;


@end
