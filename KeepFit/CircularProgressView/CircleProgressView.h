//
//  CircleProgressView.h
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ConstantHeaders.h"

typedef NS_ENUM(NSInteger, CircleProgressViewAnimateState)
{
    
    CircleProgressViewAnimateNone,
    CircleProgressViewAnimateStart,
    CircleProgressViewAnimating,
    CircleProgressViewAnimateStop,
   
    
};

@interface CircleProgressView : UIControl

@property (nonatomic) CGFloat expectedDistance;

@property (nonatomic) CGFloat currentDistance;

@property (nonatomic) CGFloat animateDistance;

@property (nonatomic) CGFloat currentSteps;

@property (nonatomic) CGFloat animateSteps;

@property (nonatomic, retain) NSString *status;

@property (assign, nonatomic, readonly) double percent;

@property (nonatomic) NSMutableAttributedString *distancetext;

-(void)animateLabelProgress;

@end
