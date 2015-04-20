//
//  CircleProgressView.h
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIControl

@property (nonatomic) CGFloat expectedDistance;

@property (nonatomic) CGFloat currentDistance;

@property (nonatomic, retain) NSString *status;

@property (assign, nonatomic, readonly) double percent;

@property (nonatomic) NSMutableAttributedString *distancetext;

@end
