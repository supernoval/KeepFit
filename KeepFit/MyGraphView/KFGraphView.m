//
//  KFGraphView.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/5/30.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFGraphView.h"

@implementation KFGraphView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        _linePath = [UIBezierPath bezierPath];
        
        _sharpPath = [UIBezierPath bezierPath];
        
    
    }
    
    return self;
    
}
-(void)setPoints:(NSArray *)points
{

}

-(void)setSharpLineColor:(UIColor *)sharpLineColor
{
    [self setNeedsDisplay];
    
}
-(void)createpath
{
    
        self.muPoints = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _points.count; i++)
    {
        
        CGFloat oneValue = [[_points objectAtIndex:i]floatValue];
        
        if (i > 0)
        {
            CGFloat beforeValue = [[_muPoints objectAtIndex:i - 1]floatValue];
            
            oneValue += beforeValue;
            
        }
        
        [_muPoints addObject:@(oneValue)];
        
        
    }
    
    self.points = _muPoints;
    for (int i = 0; i < self.points.count; i ++)
    {
        
        CGPoint pointAtI = [self getPointWithIndex:i];
        
        if (i == 0)
        {
            
            [_sharpPath moveToPoint:pointAtI];
            
            return;
            
        }
        
        [_sharpPath addLineToPoint:pointAtI];
        
    }
    

    
   // [_sharpPath closePath];
    
    [self setNeedsDisplay];
    
    
    
}
-(void)animate
{
    [self createpath];
    
}


-(CGPoint)getPointWithIndex:(NSInteger)i
{
    CGFloat oneValue = [[self.points objectAtIndex:i]floatValue];
    

    
    
    
    CGFloat perLength = self.frame.size.width/self.points.count;
    
    CGPoint onePoint = CGPointMake(perLength*i, oneValue/_expectValue * self.frame.size.height);
    
    
    return onePoint;
    
    
}



- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    if (self.sharpPath && _points.count > 0)
    {
        
        ((CAShapeLayer*)self.layer).path = self.sharpPath.CGPath;
        
        
        
    }
    
    if (self.sharpLineColor) {
        
        ((CAShapeLayer*)self.layer).strokeColor = self.sharpLineColor.CGColor;
        
    }
    
}


@end
