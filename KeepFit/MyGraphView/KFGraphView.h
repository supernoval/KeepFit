//
//  KFGraphView.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/5/30.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFGraphView : UIView
{
    
}
@property (nonatomic,copy) NSArray*points;
@property (nonatomic,strong) NSMutableArray *muPoints;

@property (nonatomic,assign) CGFloat expectValue;
@property (nonatomic,strong) UIBezierPath *linePath;
@property (nonatomic,strong) UIBezierPath *sharpPath;
@property (nonatomic,strong) NSArray *fillColors;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,strong) UIColor *sharpLineColor;

-(id)initWithFrame:(CGRect)frame;
-(void)animate;

@end
