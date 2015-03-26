//
//  KFTranslateWorkOutEnergyToFat.m
//  KeepFit
//
//  Created by Leo on 15/3/26.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//


/**步行一公里消耗能量  单位 kcal/km
 ** param x 当前体重
 **/

#define kWalkingEnergyConsumePerKM(x)    100.0*(x/70.0)

/**每克脂肪释放能量  kcal
 **/
#define kEveryGFatReleaseEnergy      9.0


#import "KFTranslateWorkOutEnergyToFat.h"

@implementation KFTranslateWorkOutEnergyToFat


KFTranslateWorkOutEnergyToFat *_energytoFat = nil;

+(KFTranslateWorkOutEnergyToFat*)shareEnergyToFat
{
    

   
   static  dispatch_once_t once;
    
    dispatch_once(&once, ^{
       
        _energytoFat = [[KFTranslateWorkOutEnergyToFat alloc]init];
        
        
        
    });
    
    return _energytoFat;
    
    
}

-(CGFloat)wakingDistanceToFat:(CGFloat)distance
{
    
    
    
    
    return   [self getFatsFromWorkOutType:KFWorkOutEnergyTypeWalking andQuantity:distance];
    
    
   
    
    
}

-(CGFloat)getFatsFromWorkOutType:(KFWorkOutEnergyType)energyType andQuantity:(CGFloat)quantity
{
    
    CGFloat fats = 0.0;
    
    CGFloat currentbodyweight = [[[NSUserDefaults standardUserDefaults ] objectForKey:kCurrentWeiht] floatValue];
    
    
    CGFloat totalConsumeEnergy = quantity *kWalkingEnergyConsumePerKM(currentbodyweight);
    
    
    
    
    
    switch (energyType) {
        case KFWorkOutEnergyTypeWalking:
        {
            fats = totalConsumeEnergy/kEveryGFatReleaseEnergy;
            
            
        }
            break;
            
        case KFWorkOutEnergyTypeCycling:
            
        {
            
        }
            break;
            
            
            
        default:
            break;
    }
    
    
    
    return fats;
    
    
    
    
}

@end
