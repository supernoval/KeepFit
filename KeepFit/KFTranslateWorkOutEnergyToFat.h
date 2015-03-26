//
//  KFTranslateWorkOutEnergyToFat.h
//  KeepFit
//
//  Created by Leo on 15/3/26.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h> 

#import "NSUserDefaultsKeys.h"


typedef NS_ENUM(NSInteger, KFWorkOutEnergyType)
{
     KFWorkOutEnergyTypeWalking,
    
     KFWorkOutEnergyTypeCycling,
    
    
};

@interface KFTranslateWorkOutEnergyToFat : NSObject
{
    
}


+(KFTranslateWorkOutEnergyToFat*)shareEnergyToFat;


-(CGFloat)wakingDistanceToFat:(CGFloat)distance;


@end
