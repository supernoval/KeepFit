//
//  GraphBarView.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "GraphBarView.h"
#import "ConstantHeaders.h"

#define PADDING  20

#define BarAnimationDuration 1.0

@implementation GraphBarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    [self.barColor setStroke];
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    
    [line moveToPoint:CGPointMake(PADDING, self.frame.size.height)];
    
    [line addLineToPoint:CGPointMake(kScreenWith - PADDING , self.frame.size.height)];
    
    [line setLineWidth:1];
    
     
    [line stroke];
    
    
    
}



-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor whiteColor];
        
     
        
  
        
        
    }
    
    return self;
    
}

-(void)initviews
{
    
    
    CGFloat topLabelsHeight = 90;
    totalHeight = kBarViewHeight - topLabelsHeight;
    

    [self backGroundViewHeight];
    
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat selfHeight = self.frame.size.height;
    
    
    CGFloat barWidth = selfWidth/3;
    
    CGFloat xPoint = selfWidth/2 - barWidth/2;
    
    CGFloat yPoint = selfHeight ;
    
    
    
    CGFloat backYpoint = selfHeight - backgroundViewHeight ;
    
    
    
    backGroundView = [[UIView alloc]initWithFrame:CGRectMake(xPoint, backYpoint, barWidth, backgroundViewHeight)];
    
    backGroundView.backgroundColor = [UIColor purpleColor];
    backGroundView.alpha = 0.0;
    
    [self addSubview:backGroundView];
    
    
    persentButton = [[UIButton alloc]initWithFrame:CGRectMake(xPoint, yPoint, barWidth, 0)];
    
    persentButton.backgroundColor = self.barColor;
    persentButton.alpha = 0.8;
    [self addSubview:persentButton];
    
    
    _persenLabel = [[UILabel alloc]initWithFrame:CGRectMake(xPoint + barWidth, yPoint - 15, 80, 30)];
    _persenLabel.textColor = kTextColor;
    _persenLabel.textAlignment = NSTextAlignmentCenter;
    _persenLabel.font = [UIFont fontWithName:kTextFontName_Helvetica size:14];
    
    [self addSubview:_persenLabel];
    
  
    UILabel *_stepstilelLabel = [CommentMeths labelWithText:NSLocalizedString(@"Steps", nil) font:[UIFont fontWithName:kTextFontName_Helvetica size:15] textColor:kTextColor frame:CGRectMake(20, 40, 65, 30)];
    
    _stepstilelLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_stepstilelLabel];
    
    _stepsLabel = [CommentMeths labelWithText:[NSString stringWithFormat:@"%.0f",_steps] font:[UIFont fontWithName:kTextFontName_Helvetica size:15] textColor:[UIColor redColor] frame:CGRectMake(90, 40, 120, 30)];
    
    [self addSubview:_stepsLabel];
    
    
    
    
    UILabel *_distancetitleLabel = [CommentMeths labelWithText:NSLocalizedString(@"Distance", nil) font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] frame:CGRectMake(kScreenWith - 65 - 118, 40, 65, 30)];
    
    _distancetitleLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_distancetitleLabel];
    
    
    _distanceLabel = [CommentMeths labelWithText:[NSString stringWithFormat:@"%.2fkm",_distance] font:[UIFont fontWithName:kTextFontName_Helvetica size:15] textColor:[UIColor redColor] frame:CGRectMake(kScreenWith - 115, 40, 110, 30)];
    
    [self addSubview:_distanceLabel];
    
    _timeTypeStrLabel = [CommentMeths labelWithText:@"" font:[UIFont fontWithName:kTextFontName_Helvetica size:15] textColor:[UIColor redColor] frame:CGRectMake(kScreenWith/2 - 60, 10, 120, 30)];
    _timeTypeStrLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeTypeStrLabel];
    
    
    switch (_timetype) {
        case WalkingStepsTimeTypeToday:
        {
            _timeTypeStrLabel.text = NSLocalizedString(@"Today", nil);
            
        }
            break;
        case WalkingStepsTimeTypeYesterday:
        {
           _timeTypeStrLabel.text = NSLocalizedString(@"Yesterday", nil);
        }
            break;
        case WalkingStepsTimeTypeLastSevendays:
        {
            _timeTypeStrLabel.text = NSLocalizedString(@"Last 7 Days", nil);
        }
            break;
        case WalkingStepsTimeTypeLastMonth:
        {
            _timeTypeStrLabel.text = NSLocalizedString(@"Last 30 Days", nil);
        }
            break;
            
        default:
            break;
    }
  
    
}

#pragma mark - 计算百分比
-(double)caculaPercentege
{
    
    return _steps/_expectedSteps;
    
}

//计算背景高度
-(void)backGroundViewHeight
{
    
    
    double persen = [self caculaPercentege];
    
    if (persen <= 1)
    {
        backgroundViewHeight = totalHeight;
        
        barViewHeight = totalHeight *persen;
        
        
    }
   else
   {
       barViewHeight = totalHeight;
       
       backgroundViewHeight = totalHeight * (1/persen);
       
       
   }
   
}


-(void)animatewithSteps:(double)steps expectedSteps:(double)expected_steps distance:(double)distance timetype:(WalkingStepsTimeType)timetype
{
    
    _steps = steps;
    
    _expectedSteps = expected_steps;
    
    _distance = distance;
    
    _timetype = timetype;
    
    [self initviews];
    
    
    [self setNeedsDisplay];
    
    
    [self backGroundViewHeight];
    
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat selfHeight = self.frame.size.height;
    
    
     CGFloat barWidth = selfWidth/3;
    
    CGFloat xPoint = selfWidth/2 - barWidth/2;
    
    CGFloat yPoint = selfHeight ;
    
    CGFloat barfinalYpoint = selfHeight - barViewHeight ;
    
    

 
    
   persentButton.frame = CGRectMake(xPoint, yPoint, barWidth, 0);
 
   _persenLabel.frame = CGRectMake(xPoint + barWidth, yPoint - 15, 80, 30);
    
  
    
    
   
    
    [UIView animateWithDuration:BarAnimationDuration animations:^{
       
        //backGroundView.frame =   CGRectMake(xPoint, backYpoint, barWidth, backgroundViewHeight);
        
        backGroundView.alpha = 1.0;
     
    } completion:^(BOOL finished) {
        
          changeTime = 0.0;
        
         texttimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeLabelText) userInfo:nil repeats:YES];
         [texttimer fire];
        [UIView animateWithDuration:BarAnimationDuration animations:^{
            
            
            persentButton.frame = CGRectMake(xPoint, barfinalYpoint, barWidth, barViewHeight);
            
            _persenLabel.frame = CGRectMake(xPoint + barWidth, barfinalYpoint -15, 80, 30);
            
            
            
            
        }];
    }];
    
    

    
    
    
}

-(void)changeLabelText
{
    changeTime +=0.1;
    
    if (changeTime >= BarAnimationDuration) {
        
        [texttimer invalidate];
        
        
    }
    
    CGFloat persen = [self caculaPercentege];
    
    CGFloat currentPersen = changeTime/BarAnimationDuration *persen *100;
    
    //NSLog(@"persen:%f",currentPersen);
    
    _persenLabel.text = [NSString stringWithFormat:@"%.0f%@",currentPersen,@"%"];
    
    
    
    
}


@end
