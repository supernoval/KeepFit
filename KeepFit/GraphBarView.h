//
//  GraphBarView.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFEnergyConsumVC.h"

@interface GraphBarView : UIView
{
    CGFloat totalHeight; //条的总高度
    
    CGFloat backgroundViewHeight; //背景条的高度
    
    CGFloat barViewHeight; //条的高度
    
    UIView *backGroundView;
    
    UIButton *persentButton;
    
    UILabel *_persenLabel; //显示百分比
    
    NSTimer *texttimer;
    
    CGFloat  changeTime;
    
    UILabel *_timeTypeStrLabel;
    
    UILabel *_distanceLabel;
    
    UILabel *_stepsLabel;
    
    
    
    
}
-(id)initWithFrame:(CGRect)frame;



-(void)animatewithSteps:(double)steps expectedSteps:(double)expected_steps distance:(double)distance timetype:(WalkingStepsTimeType)timetype;

@property (nonatomic) UIColor *barBackGroundColor;
@property (nonatomic) UIColor *barColor;
@property (nonatomic) double steps;
@property (nonatomic) double expectedSteps;
@property (nonatomic) double distance;
@property (nonatomic) WalkingStepsTimeType timetype;



@end
