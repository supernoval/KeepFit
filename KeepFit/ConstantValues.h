//
//  ConstantValues.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

//屏幕宽度
#define kScreenWith    [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#define TopBarHeight 64

#define TapBarHeight  49

#define HeadtextlabelsHeight  100

#define BarBottomPADDING   10

//barView height
#define kBarViewHeight   (kScreenHeight - HeadtextlabelsHeight - TapBarHeight - BarBottomPADDING )


//字体
#define kTextFontName_Helvetica     @"Helvetica"

//体重quantitytype
#define kWeightQuantityType  [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]

//步数quantitytype
#define kStepsQuantityType    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]

//距离 quantitytype
#define kWalkingRunningDistantQuantityType        [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]

//骑自行车 quantitytype
#define kCyclingDistantQuantityType          [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling]

//graph 填充色
#define kGraphFillColors  @[[UIColor colorWithRed:0.251 green:0.232 blue:1.000 alpha:1.000],[UIColor colorWithRed:0.282 green:0.945 blue:1.000 alpha:1.000]]

//graph 线条颜色
#define kGraphColor  [UIColor colorWithRed:0.500 green:0.158 blue:1.000 alpha:1.000]

//graph 背景颜色
#define kGraphDetailBackGroundColor [UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000]


