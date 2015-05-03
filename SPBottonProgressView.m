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

#define kAnimationDuration  2.0


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
    UILabel *energyTitleLabel = [self getLabelWithFrame:CGRectMake(offset, offset, titleLabelWidth, 20) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:@"耗能"];
    
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
    calHeadLabel = [self getLabelWithFrame:CGRectMake(energyBackGroundLabel.frame.origin.x, energyBackGroundLabel.frame.origin.y, 0, 0) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    
    calHeadLabel.layer.cornerRadius = CGRectGetHeight(calLabel.frame)/2;
    calHeadLabel.clipsToBounds = YES;
    [self addSubview:calHeadLabel];
    
    
    UILabel *energyUnittitleLabel = [self getLabelWithFrame:CGRectMake(self.frame.size.width - CGRectGetWidth(energyTitleLabel.frame) - offset, offset, CGRectGetWidth(energyTitleLabel.frame), labelHeight) TextColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15] textAligment:NSTextAlignmentCenter text:@"大卡"];
    
    [self  addSubview:energyUnittitleLabel];
    
    
    

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
        
        calFrame.size.width = CGRectGetWidth(energyBackGroundLabel.frame)*_calValue ;
        calLabel.frame = calFrame;
        
        
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
