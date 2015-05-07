//
//  SPBottonProgressView.m
//  BottomProgressView
//
//  Created by ZhuHaikun on 15/4/26.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//



#import "SPBottonProgressView.h"

CGFloat offset = 10.0;
CGFloat labelHeight = 20.0;
CGFloat titleLabelWidth = 60.0;

#define kTextColor   [UIColor darkGrayColor]
#define kCalAnimateBarColor [UIColor orangeColor]
#define kTextFont    [UIFont systemFontOfSize:15]
#define kLabelBackgroundColor  [UIColor lightGrayColor]

#define kAnimationDuration  1.0
#define kTimeInterval   0.1

@implementation SPBottonProgressView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self initLabels];
        
        
    }
    
    return self;
    
}


-(void)initLabels
{
    UILabel *energyTitleLabel = [self getLabelWithFrame:CGRectMake(offset, offset, titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:@"耗能"];
    
    [self addSubview:energyTitleLabel];
    
    
  
    energyBackGroundLabel = [self getLabelWithFrame:CGRectMake(offset+titleLabelWidth, offset, self.frame.size.width - 2*offset - 2*titleLabelWidth, labelHeight) TextColor:kTextColor  font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    energyBackGroundLabel.backgroundColor = [UIColor lightGrayColor];
    energyBackGroundLabel.layer.cornerRadius = labelHeight/2;
    energyBackGroundLabel.clipsToBounds = YES;
    
    [self addSubview:energyBackGroundLabel];
    
    calLabel  = [self getLabelWithFrame:CGRectMake(energyBackGroundLabel.frame.origin.x, energyBackGroundLabel.frame.origin.y, 0, labelHeight) TextColor:[UIColor orangeColor] font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    [self addSubview:calLabel];
    calLabel.layer.cornerRadius = CGRectGetHeight(calLabel.frame)/2;
    calLabel.clipsToBounds = YES;
    calLabel.backgroundColor = kCalAnimateBarColor;
    
    calHeadLabel = [self getLabelWithFrame:CGRectMake(energyBackGroundLabel.frame.origin.x, energyBackGroundLabel.frame.origin.y  - labelHeight, titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    
    calHeadLabel.layer.cornerRadius = CGRectGetHeight(calLabel.frame)/2;
    calHeadLabel.clipsToBounds = YES;
    [self addSubview:calHeadLabel];
    
    
    UILabel *energyUnittitleLabel = [self getLabelWithFrame:CGRectMake(self.frame.size.width - CGRectGetWidth(energyTitleLabel.frame) - offset, offset, CGRectGetWidth(energyTitleLabel.frame), labelHeight) TextColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15] textAligment:NSTextAlignmentCenter text:@"大卡"];
    
    [self  addSubview:energyUnittitleLabel];
    
    
    //脂肪消耗
    UILabel *fatTitleLabel = [self getLabelWithFrame:CGRectMake(offset, offset *2 + labelHeight , titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:@"燃脂"];
    
    [self addSubview:fatTitleLabel];
    
    
    UILabel *fatUnitLabel = [self getLabelWithFrame:CGRectMake(self.frame.size.width - titleLabelWidth - offset, offset * 2 + labelHeight, titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:@"克"];
    
    [self addSubview:fatUnitLabel];
    
    UILabel *fatBackGroundLabel = [self getLabelWithFrame:CGRectMake(offset+titleLabelWidth, offset * 2 + labelHeight, self.frame.size.width - 2*offset - 2*titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    fatBackGroundLabel.backgroundColor = kLabelBackgroundColor;
    fatBackGroundLabel.layer.cornerRadius = CGRectGetHeight(fatBackGroundLabel.frame)/2;
    fatBackGroundLabel.clipsToBounds = YES;
    
    [self addSubview:fatBackGroundLabel];
    
    fatLabel = [self getLabelWithFrame:CGRectMake(fatBackGroundLabel.frame.origin.x, offset * 2 + labelHeight, 0, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    fatLabel.layer.cornerRadius = CGRectGetHeight(fatLabel.frame)/2;
    fatLabel.clipsToBounds = YES;
    fatLabel.backgroundColor = kCalAnimateBarColor;
    
    [self addSubview:fatLabel];
    
    fatHeadLabel = [self getLabelWithFrame:CGRectMake(fatBackGroundLabel.frame.origin.x,fatBackGroundLabel.frame.origin.y + labelHeight, titleLabelWidth, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    
    [self addSubview:fatHeadLabel];
    
}

-(UILabel*)getLabelWithFrame:(CGRect)frame TextColor:(UIColor*)color font:(UIFont*)font textAligment:(NSTextAlignment)alignment text:(NSString*)text
{
    
    UILabel *temLabel = [[UILabel alloc]initWithFrame:frame];
    
    temLabel.font = font;
    temLabel.textColor = color;
    
    temLabel.textAlignment = alignment;
    temLabel.text = text;
    
    
    return temLabel;
}

-(void)animate
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
       
        CGRect calFrame = calLabel.frame;
        
        calFrame.size.width = CGRectGetWidth(energyBackGroundLabel.frame)*_calPersent ;
        calLabel.frame = calFrame;
        
        CGRect  calHeadFrame = calHeadLabel.frame;
        
        calHeadFrame.origin.x = CGRectGetWidth(calFrame);
        calHeadLabel.center = CGPointMake(calLabel.frame.size.width + calLabel.frame.origin.x, calHeadLabel.center.y);
        
        
        
        
        CGRect fatFrame = fatLabel.frame;
        
        fatFrame.size.width = CGRectGetWidth(energyBackGroundLabel.frame) *_fatPersent;
        
        fatLabel.frame = fatFrame;
        
        CGRect fatHeadFrame = fatHeadLabel.frame;
        
        fatHeadFrame.size.width = CGRectGetWidth(fatLabel.frame) *_fatPersent;
        
        fatHeadLabel.center = CGPointMake(fatLabel.frame.size.width + fatLabel.frame.origin.x, fatHeadLabel.center.y);
        
        
        
    }];
    
    calTextValue = 0.0;
    
    fatTextValue = 0.0;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(changeLabelValue) userInfo:nil repeats:YES];
    
    [timer fire];
    
}

-(void)changeLabelValue
{
    if (calTextValue < _calNum)
    {
        
        calTextValue += kTimeInterval/kAnimationDuration *_calNum;
        
         calHeadLabel.text = [NSString stringWithFormat:@"%.2f",calTextValue];
         [calHeadLabel sizeToFit];
    }
    
    if (fatTextValue < _fatNum)
    {
        
        fatTextValue +=kTimeInterval/kAnimationDuration * _fatNum;
        
       
        fatHeadLabel.text = [NSString stringWithFormat:@"%.2f",fatTextValue];
         [fatHeadLabel sizeToFit];
        NSLog(@"%.2f",fatTextValue);
        
        
    }
    
  

    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
