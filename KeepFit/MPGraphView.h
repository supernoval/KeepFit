//
//  MPGraphView.h
//
//
//  Created by Alex Manzella on 18/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPPlot.h"


@interface MPGraphView : MPPlot{
    
    CAGradientLayer *gradient;
    CAShapeLayer *lineLayer;
    
}
@property (nonatomic,retain) NSArray *daysArray;
@property (nonatomic,assign) BOOL curved;
@property (nonatomic,retain) NSArray *fillColors; // array of colors or CGColor
@property (nonatomic,strong) UIColor *lineColor;

@end
