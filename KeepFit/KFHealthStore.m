//
//  KFHealthStore.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/31.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFHealthStore.h"




KFHealthStore *_kfHealthStore = nil;

@implementation KFHealthStore


+(KFHealthStore*)shareHealthStore
{
   static dispatch_once_t oneceToken;
    
    dispatch_once(&oneceToken, ^{
    
        _kfHealthStore = [[KFHealthStore alloc]init];
        
        
    });
    
    return _kfHealthStore;
    
    
    
}

-(void)requestAuthorization:(KFHealthStoreRequestBlock)block
{
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [_kfHealthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            
            block(success);
            
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
          
                
                return;
            }
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Update the user interface based on the current user's health information.
//                [self updateUsersAgeLabel];
//                [self updateUsersHeightLabel];
//                [self updateUsersWeightLabel];
//            });
        }];
    }
}

#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite {
  //  HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
   // HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
   // HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    return [NSSet setWithObjects: weightType, nil];
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
   // HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
   // HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
  //  HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
   // HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
   // HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *walkingrunningDistanceType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKQuantityType *cycleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    
   //  HKQuantityType *heartRate = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    return [NSSet setWithObjects:  weightType, stepCountType,walkingrunningDistanceType,cycleType,nil];
}

-(void)mostRecentQuantitySamleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *quantity, NSError *Error))completion
{
    
     NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:quantityType predicate:predicate limit:1 sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        if (!results) {
            
            if (completion) {
                
                completion(nil,error);
            }
            
            return;
        }
        
        if (completion) {
            
            HKQuantitySample *quantitySample = results.firstObject;
            
            HKQuantity *quantity = quantitySample.quantity;
            
            completion(quantity,error);
            
            
        }
        
        
    }];
    
    [self executeQuery:query];
    
    
}

-(void)mostRecentQuantitySamleOfType:(HKQuantityType *)quantityType limit:(NSInteger)limit predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *, NSError *))completion
{
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    

    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:quantityType predicate:predicate limit:limit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        if (!results) {
            
            if (completion) {
                
                completion(nil,error);
            }
            
            return;
        }
        
        if (completion) {
    
        
            completion(results,error);
            
            
        }
        
        
    }];
    
    [self executeQuery:query];
}

@end
