//
//  CommentMeths.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommentMeths : NSObject


+(NSDate*)getYYYYMMddDateWithDate:(NSDate*)date;


+(NSDate*)getYYYYMMdd0000DateWithDate:(NSDate*)date;

+(NSDate*)getYYYYMMddHHmmssWithString:(NSString*)dateStr;


+(UILabel*)labelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textcolor frame:(CGRect)frame;


@end
