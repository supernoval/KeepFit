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
#define kTextColor   [UIColor darkGrayColor]
#define kTextFont    [UIFont systemFontOfSize:15]

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
    UILabel *energyTitleLabel = [self getLabelWithFrame:CGRectMake(offset, offset, 60, 20) TextColor:kTextColor font:kTextFont textAligment:NSTextAlignmentCenter text:@"耗能"];
    
    [self addSubview:energyTitleLabel];
    
    
    UILabel *energyBackGroundLabel = [self getLabelWithFrame:CGRectMake(offset, offset, self.frame.size.width, labelHeight) TextColor:kTextColor  font:kTextFont textAligment:NSTextAlignmentCenter text:nil];
    
    [self addSubview:energyBackGroundLabel];
    
    
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
