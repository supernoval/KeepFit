//
//  OneWeekDataView.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/4/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
#import "ConstantHeaders.h"
@interface OneWeekDataView : UIView
{
    
}


@property (nonatomic,strong) CircleProgressView *circleProgressView;
@property (nonatomic) CGFloat currentDis;
@property (nonatomic) CGFloat expectedDis;
@property (nonatomic) CGFloat currentSteps;
@property (nonatomic,strong) NSDate *showDate;

@property (nonatomic,strong) UILabel *dateLabel;

-(id)initWithFrame:(CGRect)frame;
-(void)animate;

@end
