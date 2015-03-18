//
//  ViewController.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/1/29.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFEnergyConsumVC.h"
#import <HealthKit/HealthKit.h>
#import "KFHealthStore.h"

#import "GraphBarView.h"




static NSString *todayStepKey = @"todaysteps";
static NSString *yesterStepKey = @"yesterdaysteps";
static NSString *lastsevendaysStepKey = @"lastsevendayssteps";
static NSString *lastonemonthStepKey = @"lastonemonthsteps";

static NSString *todaydistanceKey = @"todaydistance";
static NSString *yesterdaydistanceKey = @"yesterdaydistance";
static NSString *lastsevendaysdistanceKey = @"lastsevendaysdistance";
static NSString *lastonemonthdistanceKey = @"lastonemonthdistance";

@interface KFEnergyConsumVC ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    UITapGestureRecognizer *_resignTapGesture;
    
    double _userWeight; //体重
    
    double _targetWeight; //目标体重
    
    
   
    
    NSTimer *onecetimer;
    
    UIScrollView *_totalScrollView; //总的 scrollview
    
   
    UIView *_todayView;
    
    GraphBarView *_barView_today;
    
    
    UIView *_yesterdayView;
    
    GraphBarView *_barView_yesterday;
    
    
    UIView *_lastsevendaysView;
    
    GraphBarView *_barView_lastsevendays;
    
    
    UIView *_lastonemonthview;
    
    GraphBarView *_barView_lastonemonth;
    
    
    NSMutableDictionary *_stepsMuDict;
    
    UIActivityIndicatorView *_activetyIndicator;
    ActivityIndicatorAnimatingStatus _activityStatus;
    
    
    BOOL hadShowedTodayData;
    BOOL hadShowedYesterdayData;
    BOOL hadShowedLastSevenDaysData;
    BOOL hadShowedLastOneMonthData;
    
    
    BOOL hadGetLastTwoDaysSteps;
    BOOL hadGetLastTwoDaysDistance;
    
    BOOL hadGetLastSevenDaysSteps;
    BOOL hadGetLastSevenDaysDistance;
    
    BOOL hadGetLastOneMonthSteps;
    BOOL hadGetLastOneMonthDistance;
    
    
    
    
    
    
    
    
}

@property (nonatomic) KFHealthStore *myHealthStore;

@end

@implementation KFEnergyConsumVC
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification) name:UIKeyboardDidShowNotification object:nil];
    
 
   


    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _userWeight = 0.0;
    
    _stepsMuDict = [[NSMutableDictionary alloc]init];
    
    
    
    //添加从后台返回 通知接收
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(appWillEnterForword) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
    //目标体重
    _targetWeight = [[[NSUserDefaults standardUserDefaults ] objectForKey:kTargetWeight]doubleValue];
    
    
    
    _resignTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    

    _weghtTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _weghtTextField.delegate = self;
    
    _targetWeightTF.keyboardType = UIKeyboardTypeDecimalPad;
    _targetWeightTF.delegate = self;
    
    if (_targetWeight > 0) {
        
        _targetWeightTF.text = [NSString stringWithFormat:@"%.1f",_targetWeight];
        
    }
    
    _activetyIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(kScreenWith/2 - 22.5, kScreenHeight/2 - 22.5, 45, 45)];
    
    _activetyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.tabBarController.view addSubview:_activetyIndicator];
    
    [_activetyIndicator startAnimating];
    _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
    
    
    [self initScrollViews];
    
    
    BOOL isHealthDataEnable = [HKHealthStore isHealthDataAvailable];
    
    if (isHealthDataEnable) {
        
        _myHealthStore = [KFHealthStore shareHealthStore];
        
       
        [_myHealthStore requestAuthorization:^(BOOL isSucess) {
            
            if (isSucess) {
          
                [self requestDataFromHealhStore];
                
            }
            else
            {
                
            }
            
        }];
    }
    else
    {
        
    }

    
}


#pragma mark - 请求数据
-(void)requestDataFromHealhStore
{
    
    [self getWeight];
    
    [self getWalkingStepsWithDayType:WalkingStepsTimeTypeLastTwodays];
    [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastTwodays];
    
}

#pragma mark -从后台返回
-(void)appWillEnterForword
{
    [self requestDataFromHealhStore];
    
}
//初始化scrollview
-(void)initScrollViews
{
    CGFloat scrollviewHeight = kScreenHeight - HeadtextlabelsHeight - TapBarHeight;

    
    
    _totalScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HeadtextlabelsHeight, kScreenWith, scrollviewHeight )];
    
    _totalScrollView.delegate = self;
    
    _totalScrollView.contentSize = CGSizeMake(kScreenWith *4, scrollviewHeight);
    
    _totalScrollView.pagingEnabled = YES;
    
    _totalScrollView.showsHorizontalScrollIndicator = NO;
    _totalScrollView.scrollEnabled = NO;
    
    
    [self.view addSubview:_totalScrollView];
    
    
    _todayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, scrollviewHeight)];
    
    _todayView.backgroundColor = [UIColor clearColor];
    
   
    _barView_today = [self barViewinit];
    
    [_todayView addSubview:_barView_today];
    
    [_totalScrollView addSubview:_todayView];
    
   
    
    
    
    _yesterdayView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWith, 0, kScreenWith, scrollviewHeight)];
    _yesterdayView.backgroundColor = [UIColor clearColor];
    
    _barView_yesterday = [self barViewinit];
    
    [_yesterdayView addSubview:_barView_yesterday];
    
    [_totalScrollView addSubview:_yesterdayView];
    
    _lastsevendaysView = [[UIView alloc]initWithFrame:CGRectMake( kScreenWith *2,0, kScreenWith, scrollviewHeight)];
    _lastsevendaysView.backgroundColor = [UIColor clearColor];
    
    _barView_lastsevendays = [self barViewinit];
    [_lastsevendaysView addSubview:_barView_lastsevendays];
    
    [_totalScrollView addSubview:_lastsevendaysView];
    
    _lastonemonthview = [[UIView alloc]initWithFrame:CGRectMake( kScreenWith *3, 0,kScreenWith, scrollviewHeight)];
    
    _lastonemonthview.backgroundColor = [UIColor clearColor];
    
    _barView_lastonemonth = [self barViewinit];
    [_lastonemonthview addSubview:_barView_lastonemonth];
    
    [_totalScrollView addSubview:_lastonemonthview];
    
    
    
    
    
    
    
    
}


#pragma mark - 显示数据
-(void)showdatasWithTimeType:(WalkingStepsTimeType)timetype
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self animateBarViewWithTimeType:timetype];
        
        
        
    });
}

#pragma mark - 添加 barview

-(void)animateBarViewWithTimeType:(WalkingStepsTimeType)timetype
{
    double steps = 0.0;
    double expectedSteps = 1000.0;
    double distance = 0.0;
    
    if (_activityStatus == ActivityIndicatorAnimatingStatusAnimating) {
        
        [_activetyIndicator stopAnimating];
        [_activetyIndicator removeFromSuperview];
        
        _activityStatus = ActivityIndicatorAnimatingStatusStop;
        
    }
    
    switch (timetype) {
        case WalkingStepsTimeTypeToday:
        {
            
          
            
            
            steps = [[_stepsMuDict objectForKey:todayStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:todaydistanceKey]doubleValue];
            
            [_barView_today animatewithSteps:steps expectedSteps:expectedSteps distance:distance timetype:timetype];
            
            _totalScrollView.scrollEnabled = YES;
            
            
        }
            break;
        case WalkingStepsTimeTypeYesterday:
        {
             steps = [[_stepsMuDict objectForKey:yesterStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:yesterdaydistanceKey]doubleValue];
            
             [_barView_yesterday animatewithSteps:steps expectedSteps:expectedSteps distance:distance timetype:timetype];
        }
            break;
        case WalkingStepsTimeTypeLastSevendays:
        {
             steps = [[_stepsMuDict objectForKey:lastsevendaysStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:lastsevendaysdistanceKey]doubleValue];
            
             [_barView_lastsevendays animatewithSteps:steps expectedSteps:expectedSteps distance:distance timetype:timetype];
        }
            break;
        case WalkingStepsTimeTypeLastMonth:
        {
             steps = [[_stepsMuDict objectForKey:lastonemonthStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:lastonemonthdistanceKey]doubleValue];
            
             [_barView_lastonemonth animatewithSteps:steps expectedSteps:expectedSteps distance:distance timetype:timetype];
        }
            break;
            
            
        default:
            break;
    }
    

    
    
    
}

 //初始化barView
-(GraphBarView*)barViewinit
{
     CGFloat scrollviewHeight = kScreenHeight - HeadtextlabelsHeight - TapBarHeight;
    
   GraphBarView * tembarView = [[GraphBarView alloc]initWithFrame:CGRectMake(0,scrollviewHeight - kBarViewHeight - BarBottomPADDING, kScreenWith, kBarViewHeight)];
    
    tembarView.barColor = [UIColor redColor];
    
    
    return tembarView;
    
}


#pragma mark - 获取距离
-(void)getwalkingDistanceWithDayType:(WalkingStepsTimeType)timetype
{
    NSDate *onedaydate = [[NSDate date] dateByAddingTimeInterval:-24*60*60*1];
    
    onedaydate = [CommentMeths getYYYYMMdd0000DateWithDate:onedaydate];
    
    NSDate *twodaysdate = [[NSDate date] dateByAddingTimeInterval:-24*60*60*2];
    
    twodaysdate = [CommentMeths getYYYYMMdd0000DateWithDate:twodaysdate];
    
    NSDate *lastSevendays = [[NSDate date] dateByAddingTimeInterval:- 24*60*60*7];
    
    lastSevendays = [CommentMeths getYYYYMMdd0000DateWithDate:lastSevendays];
    
    
    NSDate *lastOneMonth = [[NSDate date]dateByAddingTimeInterval:-24*60*60*30];
    lastOneMonth = [CommentMeths getYYYYMMdd0000DateWithDate:lastOneMonth];
    
    
    NSDate *now = [NSDate date];
    
    
    
    
    NSDate *startDate = nil;
    NSDate *endDate = nil;
    
    
    switch (timetype) {
        case WalkingStepsTimeTypeLastTwodays:
        {
            startDate = onedaydate;
            
            endDate = now;
            
            
        }
            break;
            
            
            
            
        case WalkingStepsTimeTypeLastSevendays:
        {
            startDate = lastSevendays;
            
            endDate = now;
        }
            break;
        case WalkingStepsTimeTypeLastMonth:
        {
            startDate = lastOneMonth;
            
            endDate = now;
            
        }
            break;
            
            
            
        default:
            break;
    }
    
    NSLog(@"startdate:%@,enddate:%@",startDate,endDate);
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    [_myHealthStore mostRecentQuantitySamleOfType:kWalkingRunningDistantQuantityType limit:HKObjectQueryNoLimit predicate:predicate completion:^(NSArray *quantitys, NSError *Error)  {
        
        
        if (quantitys.count == 0) {
            
            NSLog(@"%s,fail to get steps,error:%@",__func__,Error);
            
        }
        else
        {
            
            double todaydistance = 0.0;
            double yesterdistance = 0.0;
            
            double totaldistance = 0.0;
            
            for (NSInteger i = 0; i < quantitys.count; i++)
            {
                
                HKSample *onesample = [quantitys objectAtIndex:i];
                
                NSDate *today = [CommentMeths getYYYYMMddDateWithDate:[NSDate date]];
                
                NSDate *yesterday = [CommentMeths getYYYYMMdd0000DateWithDate:[today dateByAddingTimeInterval:-24*60*60]];
                
                
                NSDate *startDate = [CommentMeths getYYYYMMddDateWithDate:[onesample startDate]];
                
                
                HKQuantitySample *oneSample = [quantitys objectAtIndex:i];
                HKQuantity *quantity = oneSample.quantity;
                
                HKUnit *countUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                
                double distance = [quantity  doubleValueForUnit:countUnit];
                
                if (timetype == WalkingStepsTimeTypeLastTwodays)
                {
                    
                    
                    
                    if ([today isEqualToDate:startDate])
                    {
                        
                   
                        todaydistance += distance;
                        
                        
                        
                    }
                    
                    
                    
                    if ([yesterday isEqualToDate:startDate])
                    {
                        
                        yesterdistance += distance;
                        
                        
                    }
                    
                    
                 }
                
               
                
                totaldistance += distance;
                
                
                
            }
            
            NSLog(@"%s,totaldistacne:%.2f",__func__,totaldistance);
            
            switch (timetype) {
                case WalkingStepsTimeTypeLastTwodays:
                {
              
                    
                  
                    [_stepsMuDict setObject:@(todaydistance) forKey:todaydistanceKey];
                    
                    [_stepsMuDict setObject:@(yesterdistance) forKey:yesterdaydistanceKey];
                    
                    hadGetLastTwoDaysDistance = YES;
                    
                    if (hadGetLastTwoDaysSteps) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeToday];
                        
                    }
                    
                    
                }
                    break;
                    
                case WalkingStepsTimeTypeLastSevendays:
                {
                    [_stepsMuDict setObject:@(totaldistance) forKey:lastsevendaysdistanceKey];
                    
                    hadGetLastSevenDaysDistance = YES;
                    
                    if (hadGetLastSevenDaysSteps) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastSevendays];
                        
                        hadShowedLastSevenDaysData = YES;
                        
                        
                    }
                    
                }
                    break;
                    
                case WalkingStepsTimeTypeLastMonth:
                {
                    
                   [_stepsMuDict setObject:@(totaldistance) forKey:lastonemonthdistanceKey];
                    
                    hadGetLastOneMonthDistance = YES;
                    
                    if (hadGetLastOneMonthSteps) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastMonth];
                        
                        hadShowedLastOneMonthData = YES;
                        
                    }
                    
                }
                    break;
                    
                    
                default:
                    break;
             }
        }
        

                
    
    }];
    
}

#pragma mark - 获取步数
-(void)getWalkingStepsWithDayType:(WalkingStepsTimeType)timetype
{
    
    NSDate *onedaydate = [[NSDate date] dateByAddingTimeInterval:-24*60*60*1];
    
    onedaydate = [CommentMeths getYYYYMMdd0000DateWithDate:onedaydate];
    
    NSDate *twodaysdate = [[NSDate date] dateByAddingTimeInterval:-24*60*60*2];
    
    twodaysdate = [CommentMeths getYYYYMMdd0000DateWithDate:twodaysdate];
    
    NSDate *lastSevendays = [[NSDate date] dateByAddingTimeInterval:- 24*60*60*7];
    
    lastSevendays = [CommentMeths getYYYYMMdd0000DateWithDate:lastSevendays];
    
    
    NSDate *lastOneMonth = [[NSDate date]dateByAddingTimeInterval:-24*60*60*30];
    lastOneMonth = [CommentMeths getYYYYMMdd0000DateWithDate:lastOneMonth];
    
    
    NSDate *now = [NSDate date];
    
   
    
    
    NSDate *startDate = nil;
    NSDate *endDate = nil;
    
    
    switch (timetype) {
        case WalkingStepsTimeTypeLastTwodays:
        {
            startDate = onedaydate;
            
            endDate = now;
            
            
        }
            break;
    
  

            
        case WalkingStepsTimeTypeLastSevendays:
        {
            startDate = lastSevendays;
            
            endDate = now;
        }
            break;
        case WalkingStepsTimeTypeLastMonth:
        {
            startDate = lastOneMonth;
            
            endDate = now;
            
        }
            break;
            
     
            
        default:
            break;
    }
    
      NSLog(@"startdate:%@,enddate:%@",startDate,endDate);
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    [_myHealthStore mostRecentQuantitySamleOfType:kStepsQuantityType limit:HKObjectQueryNoLimit predicate:predicate completion:^(NSArray *quantitys, NSError *Error)  {
        
        
        if (quantitys.count == 0) {
            
            NSLog(@"%s,fail to get steps,error:%@",__func__,Error);
            
        }
        
        else
        {
            
            double totalSteps = 0.0;
            
            double todaySteps = 0.0;
            
            double yestdaySteps = 0.0;
            
            for (NSInteger i = 0; i < quantitys.count; i++) {
                
                HKSample *onesample = [quantitys objectAtIndex:i];
                
                NSDate *today = [CommentMeths getYYYYMMddDateWithDate:[NSDate date]];
                
                NSDate *yesterday = [CommentMeths getYYYYMMdd0000DateWithDate:[today dateByAddingTimeInterval:-24*60*60]];
                
                
                NSDate *startDate = [CommentMeths getYYYYMMddDateWithDate:[onesample startDate]];
                
                
                HKQuantitySample *oneSample = [quantitys objectAtIndex:i];
                HKQuantity *quantity = oneSample.quantity;
                
                HKUnit *countUnit = [HKUnit countUnit];
                
                double steps = [quantity doubleValueForUnit:countUnit];
     
               // NSLog(@"startDate:%@",startDate);
                
                
                if (timetype == WalkingStepsTimeTypeLastTwodays)
                {
                    
                    
                
                if ([today isEqualToDate:startDate])
                {
                    
                        
                        todaySteps += steps;
                    
                        
                    
                }
           
                
                
                if ([yesterday isEqualToDate:startDate])
                {
                    
                       yestdaySteps += steps;
                    
                }
           
                
                }
                
                totalSteps +=steps;
                
                
            
                
            }
            
            
            switch (timetype) {
                case WalkingStepsTimeTypeLastTwodays:
                {
                    [_stepsMuDict setObject:@(todaySteps) forKey:todayStepKey];
                    
                    [_stepsMuDict setObject:@(yestdaySteps) forKey:yesterStepKey];
                    
                    
                    hadGetLastTwoDaysSteps = YES;
                    
                    
                    if (hadGetLastTwoDaysDistance) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeToday];
                        
                    }
                 
                    
              
                    
                    
                }
                    break;
            
                case WalkingStepsTimeTypeLastSevendays:
                {
                    [_stepsMuDict setObject:@(totalSteps) forKey:lastsevendaysStepKey];
                    
                    hadGetLastSevenDaysSteps = YES;
                    
                    if (hadGetLastSevenDaysDistance) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastSevendays];
                        
                        hadShowedLastSevenDaysData =YES;
                        
                        
                    }
                }
                    break;
                case WalkingStepsTimeTypeLastMonth:
                {
                    
                    [_stepsMuDict setObject:@(totalSteps) forKey:lastonemonthStepKey];
                    
                    hadGetLastOneMonthSteps = YES;
                    
                    if (hadGetLastOneMonthDistance) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastMonth];
                        hadShowedLastOneMonthData = YES;
                        
                        
                    }
                }
                    break;
                    
                    
                default:
                    break;
             }
            
            
            
              NSLog(@"todaySteps steps:%f",todaySteps);
            
              NSLog(@"yesterday steps:%f",yestdaySteps);
            
            NSLog(@"totalSteps:%f",totalSteps);
            
            
        }
    }];
    
    
}

#pragma mark - 获取体重
-(void)getWeight
{
    
    NSMassFormatter *massFormatter = [[NSMassFormatter alloc]init];
    
    massFormatter.unitStyle = NSFormattingUnitStyleLong;
    
    
    
  
    [_myHealthStore mostRecentQuantitySamleOfType:kWeightQuantityType predicate:nil completion:^(HKQuantity *quantity, NSError *Error) {
    
        if (!quantity) {
            
            NSLog(@"not query weight,error:%@",Error);
        
            return;
        }
        
        
        else
        {
            HKUnit *weightUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
            
             _userWeight = [quantity doubleValueForUnit:weightUnit];
            
            NSLog(@"get usersweight:%.1f",_userWeight);
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                
                self.weghtTextField.text = [NSString stringWithFormat:@"%.1f",_userWeight];
                
                if (self.targetWeightTF.text.length == 0) {
                    
                    self.targetWeightTF.text = [NSString stringWithFormat:@"%.1f",(_userWeight - 5.0)];
                    double targetWeight = _userWeight - 5.0;
                    
                    [[NSUserDefaults standardUserDefaults ] setObject:@(targetWeight) forKey:kTargetWeight];
                    
                    [[NSUserDefaults standardUserDefaults ] synchronize];
                    
                    
                }
                
            });
            
            
          
            
        }
        
        
        
    }];
    
}


#pragma mark  写入体重
-(void)writetWeightIntoHealthStore:(double)weight
{
    HKUnit *kiloGram = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:kiloGram doubleValue:weight];
    
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:kWeightQuantityType quantity:weightQuantity startDate:[NSDate date] endDate:[NSDate date]];
    
    [_myHealthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
       
        if (!success) {
            
            NSLog(@"%s,fail to save weight,error:%@",__func__,error);
            
            
        }
        else
        {
            NSLog(@"sucess save weight");
            
            
        }
        
    }];
  
}


#pragma mark -  键盘显示notification seletor
-(void)keyboardDidShowNotification
{
    [self.view addGestureRecognizer:_resignTapGesture];
    
}
//隐藏键盘
-(void)hideKeyBoard
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_resignTapGesture];
    
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
     double inputUserWeight = [textField.text doubleValue];
    
    
    if (textField == _weghtTextField) {
        
        
       
        
        if (inputUserWeight >0) {
            
            if (inputUserWeight != _userWeight)
            {
                _userWeight = inputUserWeight;
                
                [self writetWeightIntoHealthStore:inputUserWeight];
                
            }
        }
    }
    
    if (textField == _targetWeightTF) {
        
        if (inputUserWeight >0) {
            
            if (inputUserWeight != _targetWeight)
            {
                _targetWeight = inputUserWeight;
                
                [[NSUserDefaults standardUserDefaults ] setObject:@(_targetWeight) forKey:kTargetWeight];
                [[NSUserDefaults standardUserDefaults ] synchronize];
                
                
            }
        }
    }
}

#pragma mark  - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xorigin = scrollView.contentOffset.x;
    
    NSInteger pageIndex = xorigin/kScreenWith;
    
    NSLog(@"%s,pageIndex:%ld",__func__,(long)pageIndex);
    
    switch (pageIndex) {
        case 0:
        {
           
        }
            break;
        case 1:
        {
            
            
            if (!hadShowedYesterdayData && hadGetLastTwoDaysSteps && hadGetLastTwoDaysDistance) {
               
                 [self animateBarViewWithTimeType:WalkingStepsTimeTypeYesterday];
                
                hadShowedYesterdayData = YES;
            }
           
            
        }
            break;
        case 2:
        {
            if (!hadShowedLastSevenDaysData && hadGetLastSevenDaysDistance && hadGetLastSevenDaysSteps) {
                
                [self animateBarViewWithTimeType:WalkingStepsTimeTypeLastSevendays];
                
                hadShowedLastSevenDaysData = YES;
                
                
            }
            else if(!hadShowedLastSevenDaysData)
            {
                [self.view addSubview:_activetyIndicator];
                [_activetyIndicator startAnimating];
                
                _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
                
                
                [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastSevendays];
                [self getWalkingStepsWithDayType:WalkingStepsTimeTypeLastSevendays];
                
            }
        }
            break;
        case 3:
        {
            if (!hadShowedLastOneMonthData && hadGetLastOneMonthDistance && hadGetLastOneMonthSteps) {
                
                [self animateBarViewWithTimeType:WalkingStepsTimeTypeLastMonth];
                hadShowedLastOneMonthData = YES;
                
                
            }
            else if (!hadShowedLastOneMonthData)
            {
                [self.view addSubview:_activetyIndicator];
                [_activetyIndicator startAnimating];
                _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
                
                
                [self getWalkingStepsWithDayType:WalkingStepsTimeTypeLastMonth];
                [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastMonth];
                
                
            }
        }
            break;
            
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
