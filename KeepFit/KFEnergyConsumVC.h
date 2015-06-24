//
//  ViewController.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/29.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantHeaders.h"
#import "DataHelper.h"
@import HealthKit;



typedef NS_ENUM(NSInteger, ActivityIndicatorAnimatingStatus)
{
    ActivityIndicatorAnimatingStatusAnimating,
    ActivityIndicatorAnimatingStatusStop,
    
};

@interface KFEnergyConsumVC : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;


@property (weak, nonatomic) IBOutlet UIButton *arrow_right;

- (IBAction)right_scroAction:(id)sender;


- (IBAction)left_scrolAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *arrow_leftButton;

@property (nonatomic) HKHealthStore *healthStore;
@end

