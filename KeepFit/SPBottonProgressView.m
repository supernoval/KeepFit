//
//  SPBottonProgressView.m
//  BottomProgressView
//
//  Created by ZhuHaikun on 15/4/26.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//



#import "SPBottonProgressView.h"
#import "ConstantValues.h"
CGFloat offset = 5.0;
CGFloat labelHeight = 20.0;
CGFloat titleLabelHeight = 15.0;
CGFloat titleLabelWidth = 60.0;


#define kCalAnimateBarColor [UIColor orangeColor]
#define kTextFont    [UIFont systemFontOfSize:15]


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
    UILabel *energyTitleLabel = [self getLabelWithFrame:CGRectMake(offset, offset*2, titleLabelWidth, labelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10] textAligment:NSTextAlignmentCenter text:NSLocalizedString(@"Consumption", nil)];
    
    [self addSubview:energyTitleLabel];
    
    
  
    energyBackGroundLabel = [self getLabelWithFrame:CGRectMake(offset+titleLabelWidth, offset*2, self.frame.size.width - 2*offset - 2*titleLabelWidth, labelHeight) TextColor:kGrayBackgroundColor  font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    energyBackGroundLabel.backgroundColor = kGrayBackgroundColor;
    energyBackGroundLabel.layer.cornerRadius = labelHeight/2;
    energyBackGroundLabel.clipsToBounds = YES;
    
    [self addSubview:energyBackGroundLabel];
    
    calLabel  = [self getLabelWithFrame:CGRectMake(energyBackGroundLabel.frame.origin.x, energyBackGroundLabel.frame.origin.y, 0, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    [self addSubview:calLabel];
    calLabel.layer.cornerRadius = CGRectGetHeight(calLabel.frame)/2;
    calLabel.clipsToBounds = YES;
    calLabel.backgroundColor = kEnergyBottomBarColor;
    
    calHeadLabel = [self getLabelWithFrame:CGRectMake(energyBackGroundLabel.frame.origin.x, energyBackGroundLabel.frame.origin.y  - titleLabelHeight, titleLabelWidth, titleLabelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10]
                              textAligment:NSTextAlignmentCenter text:nil];
    

    [self addSubview:calHeadLabel];
    
    
    UILabel *energyUnittitleLabel = [self getLabelWithFrame:CGRectMake(self.frame.size.width - CGRectGetWidth(energyTitleLabel.frame) - offset, offset*2, CGRectGetWidth(energyTitleLabel.frame), labelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10] textAligment:NSTextAlignmentCenter text:NSLocalizedString(@"Kcal", nil)];
    
    [self  addSubview:energyUnittitleLabel];
    
    
    //脂肪消耗
    UILabel *fatTitleLabel = [self getLabelWithFrame:CGRectMake(offset, calLabel.frame.origin.y + CGRectGetHeight(calLabel.frame) + offset *3 , titleLabelWidth, labelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10]textAligment:NSTextAlignmentCenter text:NSLocalizedString(@"FatBurned", nil)];
    
    [self addSubview:fatTitleLabel];
    
    
    UILabel *fatUnitLabel = [self getLabelWithFrame:CGRectMake(self.frame.size.width - titleLabelWidth - offset, fatTitleLabel.frame.origin.y, titleLabelWidth, labelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10] textAligment:NSTextAlignmentCenter text:NSLocalizedString(@"g", nil)];
    
    [self addSubview:fatUnitLabel];
    
    //背景
    UILabel *fatBackGroundLabel = [self getLabelWithFrame:CGRectMake(offset+titleLabelWidth, fatTitleLabel.frame.origin.y, self.frame.size.width - 2*offset - 2*titleLabelWidth, labelHeight) TextColor:kGrayBackgroundColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    fatBackGroundLabel.backgroundColor = kGrayBackgroundColor;
    fatBackGroundLabel.layer.cornerRadius = CGRectGetHeight(fatBackGroundLabel.frame)/2;
    fatBackGroundLabel.clipsToBounds = YES;
    
    [self addSubview:fatBackGroundLabel];
    
    fatLabel = [self getLabelWithFrame:CGRectMake(fatBackGroundLabel.frame.origin.x, fatTitleLabel.frame.origin.y, 0, labelHeight) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    fatLabel.layer.cornerRadius = CGRectGetHeight(fatLabel.frame)/2;
    fatLabel.clipsToBounds = YES;
    fatLabel.backgroundColor = kFatBottomBarColor;
    
    [self addSubview:fatLabel];
    
    fatHeadLabel = [self getLabelWithFrame:CGRectMake(fatBackGroundLabel.frame.origin.x,fatBackGroundLabel.frame.origin.y + titleLabelHeight +offset*1.5, titleLabelWidth, titleLabelHeight) TextColor:kTextColor font:[UIFont fontWithName:kTextFontName_Helvetica size:10] textAligment:NSTextAlignmentCenter text:nil];
    
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
    
    if (_calPersent > 1) {
        
        _calPersent = 1.0;
        
    }
    if (_fatPersent > 1) {
        
        _fatPersent = 1.0;
        
    }
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
      //  NSLog(@"%.2f",fatTextValue);
        
        
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
