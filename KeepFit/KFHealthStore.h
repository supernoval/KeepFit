//
//  KFHealthStore.h
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <HealthKit/HealthKit.h>
#import "ConstantHeaders.h"


typedef void (^KFHealthStoreRequestBlock)(BOOL isSucess);


@interface KFHealthStore : HKHealthStore

-(BOOL)isHealthDataTypeArivable;

+(KFHealthStore*)shareHealthStore;

//请求授权
-(void)requestAuthorization:(KFHealthStoreRequestBlock)block;

//获取数据
-(void)mostRecentQuantitySamleOfType:(HKQuantityType*)quantityType  predicate:(NSPredicate*)predicate completion:(void (^)(HKQuantity *quantity, NSError *Error))completion;

-(void)mostRecentQuantitySamleOfType:(HKQuantityType *)quantityType limit:(NSInteger)limit predicate:(NSPredicate*)predicate completion:(void (^)(NSArray *quantitys, NSError *Error))completion;

@end
