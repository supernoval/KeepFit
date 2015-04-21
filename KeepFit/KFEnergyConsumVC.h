//
//  ViewController.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/29.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantHeaders.h"

@import HealthKit;

typedef NS_ENUM(NSInteger, WalkingStepsTimeType)
{
 
    WalkingStepsTimeTypeToday,
    
    WalkingStepsTimeTypeYesterday,
    
    WalkingStepsTimeTypeLastTwodays,
    
    WalkingStepsTimeTypeTheDayBeforeYesterday,
    
    WalkingStepsTimeTypeLastSevendays,
    
    WalkingStepsTimeTypeLastMonth
    
};

typedef NS_ENUM(NSInteger, ActivityIndicatorAnimatingStatus)
{
    ActivityIndicatorAnimatingStatusAnimating,
    ActivityIndicatorAnimatingStatusStop,
    
};

@interface KFEnergyConsumVC : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (weak, nonatomic) IBOutlet UITextField *targetWeightTF;
@property (weak, nonatomic) IBOutlet UITextField *weghtTextField;
@property (nonatomic) HKHealthStore *healthStore;
@end

