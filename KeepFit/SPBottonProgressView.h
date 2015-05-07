//
//  SPBottonProgressView.h
//  BottomProgressView
//
//  Created by ZhuHaikun on 15/4/26.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPBottonProgressView : UIView
{
    UILabel *energyBackGroundLabel;
    
    UILabel *calLabel;
    UILabel *calHeadLabel;
    
    UILabel *fatLabel;
    UILabel *fatHeadLabel;
    
    CGFloat calTextValue;
    CGFloat fatTextValue;
    
    
}
-(id)initWithFrame:(CGRect)frame;

@property (nonatomic) CGFloat calPersent;
@property (nonatomic) CGFloat fatPersent;

@property (nonatomic) CGFloat calNum;
@property (nonatomic) CGFloat fatNum;


-(void)animate;

@end
