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



#define TapBarHeight  49

#define HeadtextlabelsHeight  140

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


//是否第一次打开app
#define kHadShowWelComeView    @"HadShowWelComeView"


