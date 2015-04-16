//
//  SDBaseProgressView.h
//  SDProgressView
//
//  Created by aier on 15-2-19.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SDColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define SDProgressViewItemMargin 10

#define SDProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 20)

// 背景颜色
#define SDProgressViewBackgroundColor SDColorMaker(0, 240, 0, 0.9)

//#define SDProgressViewBackgroundColor SDColorMaker(255, 255, 255, 0.9)



@interface SDBaseProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic,assign) CGFloat dataendprogress;



- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes;

- (void)dismiss;

+ (id)progressView;

@end
