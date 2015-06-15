//
//  DataHelper.m
//  KeepFit
//
//  Created by Haikun Zhu on 15/6/5.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "DataHelper.h"
#import "NSDate+DateHelper.h"

@implementation DataHelper

#pragma mark - 24小时排序 或者按天顺序排序
+(NSMutableArray*)sortDataValue:(NSMutableArray *)values withTimeType:(NSInteger)timtype
{
    
    NSMutableArray *muDataArray = [[NSMutableArray alloc]init];
    
    if (timtype == WalkingStepsTimeTypeToday || timtype == WalkingStepsTimeTypeYesterday) // 1天
    {
        NSMutableArray *sorthourArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i = 0; i < values.count; i++)
        {
            
            NSDictionary *oneValueDict = [values objectAtIndex:i];
            
            NSInteger hour = [[oneValueDict objectForKey:@"hour"]integerValue];
            CGFloat oneValue = [[oneValueDict objectForKey:@"value"]floatValue];
            
            if (i == 0)
            {
        
                
                NSDictionary *oneDict = @{@"hour":@(hour),@"value":@(oneValue)};
                
                [sorthourArray addObject:oneDict];
                
                
            }
            
            else
            {
                BOOL excited = NO;
                for (int d = 0; d < sorthourArray.count; d++)
                {
                    
                    NSDictionary *savedDict = [sorthourArray objectAtIndex:d];
                    
                    NSInteger saveHour = [[savedDict objectForKey:@"hour"]integerValue];
                    
                    if (saveHour == hour)
                    {
                        
                        excited = YES;
                        
                        
                        CGFloat savedValue =[[savedDict objectForKey:@"value"]floatValue];
                        
                        
                        savedValue += oneValue;
                        
                        savedDict =  @{@"hour":@(hour),@"value":@(savedValue)};
                        
                        [sorthourArray replaceObjectAtIndex:d withObject:savedDict];
                        
                    }
                    
                }
                
                
                if (!excited)
                {
                    NSDictionary *oneDict = @{@"hour":@(hour),@"value":@(oneValue)};
                    
                    [sorthourArray addObject:oneDict];
                    
                }
                
                
            }
        }
        
        //添加没有运动量的时间段
         NSMutableArray *musorthourArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < 24; i++)
        {
            
           
            
            BOOL inside = NO;
            
            NSDictionary *oneHourData;
            
            for (int d = 0; d < sorthourArray.count; d ++)
            {
               
                NSDictionary *temHourData = [sorthourArray objectAtIndex:d];
                
                NSInteger hour = [[temHourData objectForKey:@"hour"]integerValue];
                
                if (hour == i)
                {
                    inside = YES;
                    
                    oneHourData = [sorthourArray objectAtIndex:d];
                   

                }
                
            }
            
            if (inside)
            {
                
                [musorthourArray addObject:oneHourData];
                
            }
            else
            {
                oneHourData = @{@"hour":@(i),@"value":@(0)};
                
                [musorthourArray addObject:oneHourData];
                
            }
            
            
        }
        
        NSSortDescriptor *des = [[NSSortDescriptor alloc]initWithKey:@"hour" ascending:YES];
        
        [musorthourArray sortUsingDescriptors:@[des]];
        
       
        
        
        for (int i = 0; i < musorthourArray.count ; i ++)
        {
            
            NSDictionary *oneDict = [musorthourArray objectAtIndex:i];
            
            CGFloat oneValue = [[oneDict objectForKey:@"value"]floatValue];
            
            [muDataArray addObject:@(oneValue)];
            
            
        }
        
        return muDataArray;
        
     }
    else // 一个星期  一个月
    {
        
        
        NSMutableArray *noSortDataArray = [self getSortedDaysData:values];
        
          //NSLog(@"%s,%@",__func__,noSortDataArray);
      
        for (int h = 0; h < noSortDataArray.count; h++) {
            
            NSDictionary *oneData = [noSortDataArray objectAtIndex:h];
            
            CGFloat onevalue = [[oneData objectForKey:@"value"]floatValue];
            
            [muDataArray addObject:@(onevalue)];
            
        }
        
        
        
        
    }
   
    
    return muDataArray;
    
}


//一个星期，一个月
+(NSMutableArray*)getSortedDaysData:(NSMutableArray*)values
{
    NSMutableArray *noSortDataArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < values.count; i++)
    {
        
        NSDictionary *oneDataDict = [values objectAtIndex:i];
        
        NSDate *date = [oneDataDict objectForKey:@"startdate"];
        CGFloat value = [[oneDataDict objectForKey:@"value"]floatValue];
        BOOL nosortHadData = NO;
        
        for (NSInteger d = 0; d < noSortDataArray.count; d++)
        {
            NSDictionary *nosortDict = [noSortDataArray objectAtIndex:d];
            
            NSDate *oneDate = [nosortDict objectForKey:@"startdate"]
            ;
            
            if ([date isEqualToDate:oneDate])
            {
                
                nosortHadData = YES;
                
                
                CGFloat savedValue = [[nosortDict objectForKey:@"value"]floatValue];
                
                savedValue += value;
                
                NSDictionary *temnosortdict = @{@"startdate":oneDate,@"value":@(savedValue)};
                
                [noSortDataArray replaceObjectAtIndex:d withObject:temnosortdict];
                
                
            }
            
            
        }
        
        if (!nosortHadData)
        {
            
            
            NSDictionary *temnosortdict = @{@"startdate":date,@"value":@(value)};
            
            [noSortDataArray addObject:temnosortdict];
            
            
        }
        
    }
    
    NSSortDescriptor *dateDes = [[NSSortDescriptor alloc]initWithKey:@"startdate" ascending:YES];
    [noSortDataArray sortUsingDescriptors:@[dateDes]];
    
    
    return noSortDataArray;
    
}
+(NSMutableArray*)getDate:(NSMutableArray *)values withTimeType:(NSInteger)timetype
{
    
    NSMutableArray *muDataArray = [[NSMutableArray alloc]init];
    
    if (timetype == WalkingStepsTimeTypeToday || timetype == WalkingStepsTimeTypeYesterday) {
        
        [muDataArray addObject:@"00:00"];
        [muDataArray addObject:@"06:00"];
        [muDataArray addObject:@"12:00"];
        [muDataArray addObject:@"18:00"];
        [muDataArray addObject:@"23:59"];
        
        
    }
    else
    {
       
        values = [self getSortedDaysData:values];
        
            
            if (values.count < 8)
            {
                for (NSInteger i = 0; i < values.count; i++)
                {
                
                NSString *getStr = [self getStr:values index:i];
                    
                    
                [muDataArray addObject:getStr];
                
                }
            }
            
            else
            {
                NSInteger  per = lround( values.count/4);
                
                NSString *firstStr = [self getStr:values index:0];
                
                [muDataArray addObject:firstStr];
                
                NSString *secStr = [self getStr:values index:per];
                
                [muDataArray addObject:secStr];
                
                NSString *thirdStr = [self getStr:values index:per*2];
                
                [muDataArray addObject:thirdStr];
                
                NSString *fourthStr = [self getStr:values index:per*3];
                
                [muDataArray addObject:fourthStr];
                
                NSString *lastStr = [self getStr:values index:values.count - 1];
                [muDataArray addObject:lastStr];
                
                
                
            }
        
    }
    
    
    
    
    return muDataArray;
    
    
    
}

+(NSString*)getStr:(NSMutableArray*)values index:(NSInteger)index
{
    NSDictionary *oneDict = [values objectAtIndex:index];
    
    NSDate *startDate = [oneDict objectForKey:@"startdate"];
    
    NSString *getStr = [NSDate MMddStringWithDate:startDate ];
    
    return getStr;
    
}

@end
