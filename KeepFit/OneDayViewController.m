//
//  OneDayViewController.m
//  KeepFit
//
//  Created by Haikun Zhu on 15/4/21.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "OneDayViewController.h"
#import "CircleProgressView.h"
#import "ConstantHeaders.h"

@interface OneDayViewController ()
{
     CircleProgressView *_oneDayCircleView;
}
@end

@implementation OneDayViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(id)init
{
    if (self == [super init]) {
        
        
        
    }
    
    return self;
    
}


-(void)setShowDate:(NSDate *)showDate
{
    
    NSString *dateStr = [CommentMeths getMMddDateStrWithDate:showDate];
    
    
    self.dateLabel.text = dateStr;
    
}
-(void)addcircleView
{
    _oneDayCircleView = [self getCircleProgressView];
    
    [self.view addSubview:_oneDayCircleView];
    
}

-(CircleProgressView*)getCircleProgressView
{
    
    
    CircleProgressView *temcircle;
    
    CGFloat  circleX = 0;
    CGFloat offset = 80;
 
    
    temcircle = [[CircleProgressView alloc]initWithFrame:CGRectMake(circleX, 0, kScreenWith - offset*2, kScreenWith - offset*2)];
    
    return temcircle;
    
    
}

-(void)setCurrentSteps:(CGFloat)currentSteps
{
    _oneDayCircleView.currentSteps = currentSteps;
    
}
-(void)setCurrentDistance:(CGFloat)currentDistance
{
    _oneDayCircleView.currentDistance = currentDistance;
    
}


-(void)startAnimation
{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
