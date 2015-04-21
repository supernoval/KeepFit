//
//  OneDayViewController.h
//  KeepFit
//
//  Created by Haikun Zhu on 15/4/21.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDayViewController : UIViewController



@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic) NSDate *showDate;

@property (nonatomic) CGFloat currentSteps;

@property (nonatomic)  CGFloat currentDistance;

@property (nonatomic) CGFloat expectedDistance;

-(void)startAnimation;

-(id)init;

@end
