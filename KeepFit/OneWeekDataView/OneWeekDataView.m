//
//  OneWeekDataView.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/4/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "OneWeekDataView.h"

@implementation OneWeekDataView


-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        
        [self addsubviews];
        
    }
    
    return self;
    
    
}
-(void)addsubviews
{
    self.circleProgressView = [self getCircleProgress];
    
    [self addSubview:self.circleProgressView];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWith, 40)];
    _dateLabel.textColor = [UIColor blackColor];
    _dateLabel.font = [UIFont systemFontOfSize:18];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];
    
    
    
}

-(void)setCurrentDis:(CGFloat)currentDis
{
    self.circleProgressView.currentDistance = currentDis;
}
-(void)setCurrentSteps:(CGFloat)currentSteps
{
    self.circleProgressView.currentSteps = currentSteps;
}
-(void)setExpectedDis:(CGFloat)expectedDis
{
    self.circleProgressView.expectedDistance = expectedDis;
    
}

-(void)setShowDate:(NSDate *)showDate
{
    NSString *lastSixdateStr = [CommentMeths getMMddDateStrWithDate:[showDate dateByAddingTimeInterval:-6*24*60*60]];
    NSString *todaydateStr = [CommentMeths getddDateStrWithDate:showDate];
    
    _dateLabel.text = [NSString stringWithFormat:@"%@~%@",lastSixdateStr,todaydateStr];
    
    
}
-(CircleProgressView*)getCircleProgress
{
    
    
    CircleProgressView *temcircle;
    
    CGFloat  circleX = 80;
    CGFloat offset = 80;
    
    
    temcircle = [[CircleProgressView alloc]initWithFrame:CGRectMake(circleX, offset, kScreenWith - offset*2, kScreenWith - offset*2)];
    
    return temcircle;
    
    
}
-(void)animate
{
    [self.circleProgressView animateLabelProgress];
    
}
@end
