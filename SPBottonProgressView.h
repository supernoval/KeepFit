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
    
}
-(id)initWithFrame:(CGRect)frame;

@property (nonatomic) CGFloat calValue;
@property (nonatomic) CGFloat fatValue;

-(void)animate;

@end
