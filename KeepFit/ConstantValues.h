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

#define BarWith       315.0

#define BarBottomPADDING    10


//barView height
#define kBarViewHeight   (kScreenHeight - HeadtextlabelsHeight - TapBarHeight - BarBottomPADDING )

//字体
#define kTextFontName_Helvetica     @"HelveticaNeue"
#define kHelveticaNeue_Bold  @"HelveticaNeue-Bold"

//字体颜色
#define kTextColor      [UIColor colorWithRed:78.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0]


/*===============CircleProgressView================*/
#define kLabelHeight 20.0
#define kHelveticaNeue    @"HelveticaNeue"

#define kTimerschduleInterval  0.01
//动画环颜色
#define kCircleProgressViewColor    [UIColor colorWithRed:67.0/255.0 green:211.0/255.0 blue:255.0/255.0 alpha:1.0]

/*==================================================*/

//背景灰色  统一使用
#define kGrayBackgroundColor    [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]

/*====================GraphView================*/
//graph 填充色
#define kGraphFillColors  @[[UIColor colorWithRed:223.0/255.0 green:252.0/255.0 blue:231.0/255.0 alpha:1.0],[UIColor colorWithRed:223.0/255.0 green:252.0/255.0 blue:231.0/255.0 alpha:1.0]]

//graph 线条颜色
#define kGraphLineColor  [UIColor colorWithRed:100.0/255.0 green:233.0/255.0 blue:122.0/255.0 alpha:1.0]

/*=============================================*/

/*================BottomBar=============*/

//耗能
#define kEnergyBottomBarColor  [UIColor colorWithRed:255.0/255.0 green:219.0/255.0 blue:52.0/255.0 alpha:1.0]

//燃脂
#define kFatBottomBarColor  [UIColor colorWithRed:255.0/255.0 green:163.0/255.0 blue:108.0/255.0 alpha:1.0]



//体重quantitytype
#define kWeightQuantityType  [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]

//步数quantitytype
#define kStepsQuantityType    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]

//距离 quantitytype
#define kWalkingRunningDistantQuantityType        [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]

//骑自行车 quantitytype
#define kCyclingDistantQuantityType          [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling]




