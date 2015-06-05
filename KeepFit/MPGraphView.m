//
//  MPGraphView.m
//
//
//  Created by Alex Manzella on 18/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPGraphView.h"
#import "UIBezierPath+curved.h"
#import "CommentMeths.h"


#define kcurveValue  50

@implementation MPGraphView


+ (Class)layerClass{
    return [CAShapeLayer class];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        
        currentTag=-1;
        
        
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    if (self.values.count && !self.waitToUpdate)
    {
        
        ((CAShapeLayer *)self.layer).fillColor=[UIColor clearColor].CGColor;
        ((CAShapeLayer *)self.layer).strokeColor = self.graphColor.CGColor;
        ((CAShapeLayer *)self.layer).path = [self graphPathFromPoints].CGPath;
        
        [self addLinePath];
        
        [self addLabels];
        
       
    }
}

- (void)addLinePath
{
    
    if (lineLayer)
    {
        
        [lineLayer removeFromSuperlayer];
        
    }
    
    
    lineLayer = [CAShapeLayer layer];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    for (NSInteger i=0;i<points.count;i++)
    {
        
        
        CGPoint point=[self pointAtIndex:i];
        
        if(i==0)
        {
            
            point = CGPointMake(point.x + 1.5, point.y);
            
            [path moveToPoint:point];
        }
        
    
        
        [path addLineToPoint:point];
        
        
        
    }
    
    if (self.curved)
    {
        
        path=[path smoothedPathWithGranularity:kcurveValue];
        
    }
    
    
    if (self.lineColor)
    {
        
        lineLayer.strokeColor  = self.lineColor.CGColor;
        
    }
    else
    {
        
        
       
        lineLayer.strokeColor = [UIColor clearColor].CGColor;
            
        
       
    }
    
    
    lineLayer.path = path.CGPath;
    
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:lineLayer];
    
    
}

- (UIBezierPath *)graphPathFromPoints{
    
    BOOL fill=self.fillColors.count;
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    

    
    
    for (NSInteger i=0;i<points.count;i++) {
        
        
        CGPoint point=[self pointAtIndex:i];
        
        if(i==0)
        {
            [path moveToPoint:point];
        }
        

        
        
        [path addLineToPoint:point];
        
        
        
    }
    
    
    
    
    if (self.curved) {
        
        path=[path smoothedPathWithGranularity:kcurveValue];
        
    }
    
    
    if(fill)
    {
        
        CGPoint last=[self pointAtIndex:points.count-1];
        CGPoint first=[self pointAtIndex:0];
        [path addLineToPoint:CGPointMake(last.x,self.height)];
        [path addLineToPoint:CGPointMake(first.x,self.height)];
        [path addLineToPoint:first];
        
    }
    
    if (fill)
    {
        
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        
        gradient.mask=maskLayer;
    }
    
    
    path.lineWidth=self.lineWidth ? self.lineWidth : 1;
    
    
    return path;
}

- (CGPoint)pointAtIndex:(NSInteger)index{

    CGFloat space=(self.frame.size.width)/(points.count-1);

    
    return CGPointMake((space)*index,self.height-((self.height-PADDING*2)*[[points objectAtIndex:index] floatValue]+PADDING));
//    return CGPointMake(space+(space)*index,self.height + PADDING);
}

-(void)addLabels
{
    NSInteger N = 1;
    
    for (NSInteger i = 0; i < points.count; i ++)
    {
        
        
       
        
        
    }
}

-(void)addlabelAtIndex:(NSInteger)index
{
    CGPoint labelPoint = [self pointAtIndex:index];
    
    UILabel *_label = [CommentMeths labelWithText:[NSString stringWithFormat:@"%ld",index] font:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] frame:CGRectMake(labelPoint.x, self.height, 15.0, 15)];
    
    [self addSubview:_label];
}


- (void)animate{
    
    if(self.detailView.superview)
        [self.detailView removeFromSuperview];

    
    
    gradient.hidden=0;
    
//    [UIView animateWithDuration:self.animationDuration animations:^{
//       
//        //CGRect rect = gradient.frame;
//        
//        //rect.size.width = self.frame.size.width;
//        
//        gradient.frame = self.bounds;
//        
//    }];
    
//    CABasicAnimation *gradientAnimation = [CABasicAnimation animation];
//    gradientAnimation.fromValue = @(0.0);
//    gradientAnimation.toValue = @(2);
//    gradientAnimation.duration = self.animationDuration;
//    
//    [gradient addAnimation:gradientAnimation forKey:@"gradient"];
    
    
    
    ((CAShapeLayer *)self.layer).fillColor=[UIColor clearColor].CGColor;
    ((CAShapeLayer *)self.layer).strokeColor = self.graphColor.CGColor;
    ((CAShapeLayer *)self.layer).path = [self graphPathFromPoints].CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1.0;
    animation.duration = self.animationDuration;
    animation.delegate=self;
    [self.layer addAnimation:animation forKey:@"MPStroke"];

   
    

//    for (UIButton* button in buttons) {
//        [button removeFromSuperview];
//    }
//    

    
//    buttons=[[NSMutableArray alloc] init];
//    
//    CGFloat delay=((CGFloat)self.animationDuration)/(CGFloat)points.count;
    

    
//    for (NSInteger i=0;i<points.count;i++) {
//        
//        
//        CGPoint point=[self pointAtIndex:i];
//        
//        
//        MPButton *button=[MPButton buttonWithType:UIButtonTypeCustom];
//        [button setBackgroundColor:self.graphColor];
//        button.layer.cornerRadius=3;
//        button.frame=CGRectMake(0, 0, 6, 6);
//        button.center=point;
//        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag=i;
//        button.transform=CGAffineTransformMakeScale(0,0);
//        [self addSubview:button];
//        
//        [self performSelector:@selector(displayPoint:) withObject:button afterDelay:delay*i];
//        
//        [buttons addObject:button];
//        
//        
//    }
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{

    self.waitToUpdate=NO;
    gradient.hidden=0;

}


- (void)displayPoint:(UIButton *)button{
    
        [UIView animateWithDuration:.2 animations:^{
            button.transform=CGAffineTransformMakeScale(1, 1);
        }];
    
    
}


#pragma mark Setters

-(void)setFillColors:(NSArray *)fillColors{
    
    
    
    [gradient removeFromSuperlayer]; gradient=nil;
    
    if(fillColors.count){
        
        NSMutableArray *colors=[[NSMutableArray alloc] initWithCapacity:fillColors.count];
        
        for (UIColor* color in fillColors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [colors addObject:(id)[color CGColor]];
            }else{
                [colors addObject:(id)color];
            }
        }
        _fillColors=colors;
        
        gradient = [CAGradientLayer layer];
      //  gradient.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 0, self.bounds.size.height);
        gradient.frame = self.bounds;
        
        gradient.colors = _fillColors;
        [self.layer addSublayer:gradient];
        
        
    }else     _fillColors=fillColors;
    
    
    [self setNeedsDisplay];
    
}

-(void)setCurved:(BOOL)curved{
    _curved=curved;
    [self setNeedsDisplay];
}



@end
