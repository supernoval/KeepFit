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

-(BOOL)isHealthDataTypeArivable
{
    
    BOOL available = YES;
    
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
 
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *walkingrunningDistanceType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    
    NSInteger weight = [_kfHealthStore authorizationStatusForType:weightType ];
    NSInteger step = [_kfHealthStore authorizationStatusForType:stepCountType];
    NSInteger walk = [_kfHealthStore authorizationStatusForType:walkingrunningDistanceType];
    
   
    NSLog(@"weightType:%ld,step:%ld,walk:%ld",(long)weight,(long)step,(long)walk);
    
    
    
    if (weight == HKAuthorizationStatusSharingAuthorized && step == HKAuthorizationStatusSharingAuthorized && walk == HKAuthorizationStatusSharingAuthorized)
    {
        
        available = YES;
        
    }
    
    else
    {
        available = NO;
      
        
        
    }
    
    return available;
    
    
}
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
            

        }];
    }
    else
    {
        
    }
}

#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite {
  //  HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
   // HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
   // HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *walkingrunningDistanceType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects: weightType,stepCountType,walkingrunningDistanceType, nil];
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
    
//    HKQuantityType *cycleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    
   //  HKQuantityType *heartRate = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    return [NSSet setWithObjects:  weightType, stepCountType,walkingrunningDistanceType,nil];
}

-(void)mostRecentQuantitySamleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *quantity, NSError *Error))completion
{
    
     NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:quantityType predicate:predicate limit:1 sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        if (!results) {
            
            if (completion) {
                NSLog(@"error:%@",error);
                
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
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierStartDate ascending:YES];
    

    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:quantityType predicate:predicate limit:limit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        if (!results) {
            
            if (completion) {
                 NSLog(@"error:%@",error);
                completion(nil,error);
            }
            
            return;
        }
        
        if (completion)
        {
    

            HKSample *oneSample = [results firstObject];
            NSString *firstsourcename = oneSample.source.name;
            
            NSLog(@"name:%@,id:%@",oneSample.source.name,oneSample.source.bundleIdentifier);
            
            NSMutableArray *sortresults = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < results.count; i++)
            {
                
                HKSample *oneSample = [results objectAtIndex:i];
                
                if ([oneSample.source.name isEqualToString:firstsourcename])
                {
                    
                    [sortresults addObject:oneSample];
                    
                }
            }
            
            
            completion(sortresults,error);
                
            }
  
        
    }];
    
    [self executeQuery:query];
}




@end
