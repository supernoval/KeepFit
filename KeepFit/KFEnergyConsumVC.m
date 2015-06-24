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

#import "CircleProgressView.h"
#import "KFTranslateWorkOutEnergyToFat.h"

#import "OneDayDataView.h"
#import "OneWeekDataView.h"
#import "OneMonthDataView.h"
#import "SPBottonProgressView.h"
#import "MPPlot.h"
#import "MPGraphView.h"
#import "NSDate+DateHelper.h"
#import "CommentMeths.h"
#import "KFGraphView.h"

static NSString *todayStepKey = @"todaysteps";
static NSString *yesterStepKey = @"yesterdaysteps";
static NSString *lastsevendaysStepKey = @"lastsevendayssteps";
static NSString *lastonemonthStepKey = @"lastonemonthsteps";

static NSString *todaydistanceKey = @"todaydistance";
static NSString *yesterdaydistanceKey = @"yesterdaydistance";
static NSString *lastsevendaysdistanceKey = @"lastsevendaysdistance";
static NSString *lastonemonthdistanceKey = @"lastonemonthdistance";

@interface KFEnergyConsumVC ()<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITapGestureRecognizer *_resignTapGesture;
    
    double _userWeight; //体重
    
    double _targetWeight; //目标体重
    
    
   
    
    NSTimer *onecetimer;
    
    
   
    NSMutableDictionary *_stepsMuDict; //步数加距离
    
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
    
    
    OneDayDataView *_todayDataView;
    OneDayDataView *_yesterDayDataView;
    OneWeekDataView *_lastWeekDataView;
    OneMonthDataView  *_lastMonthDataView;
    
    
    NSInteger currentScrollViewPageIndex;
    
    
    SPBottonProgressView *_todayBottonView;
    SPBottonProgressView *_yesterDayBottonView;
    SPBottonProgressView *_lastWeekBottonView;
    SPBottonProgressView *_lastMonthBottonView;
    
    MPGraphView *_todayPlotView;
    MPGraphView *_yesterdayPlotView;
    MPGraphView *_lastWeekPlotView;
    MPGraphView *_lastMonthPlotView;
    
  
   
    
    NSMutableArray *_todayStepsArray;
    
    NSMutableArray *_yesterStepsArray;
    
    NSMutableArray *_lastWeekStepsArray;
    
    NSMutableArray *_lastMonthStepsArray;
    
    
    
    KFGraphView *_todayGraphView;
    
    
    UIAlertView *requestAlert;
    
    
    
    
    
    
    
}

@property (nonatomic) KFHealthStore *myHealthStore;
@property (nonatomic,assign) CGFloat averageDistance;
@property (nonatomic,assign) BOOL   isNeedRefreshAVG; //是否需要更新平均值

@end

@implementation KFEnergyConsumVC
-(void)dealloc
{
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  
    
    
    
 



    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _userWeight = 0.0;
    
    _stepsMuDict = [[NSMutableDictionary alloc]init];
    
    _todayStepsArray = [[NSMutableArray alloc]init];
    _yesterStepsArray = [[NSMutableArray alloc]init];
    _lastWeekStepsArray = [[NSMutableArray alloc]init];
    _lastMonthStepsArray = [[NSMutableArray alloc]init];
    
    
    
    self.title = NSLocalizedString(@"title", nil);
    
    
    //添加从后台返回 通知接收
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(appWillEnterForword) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    

  
    _arrow_leftButton.hidden = YES;
    
    
    _activetyIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(kScreenWith/2 - 22.5, kScreenHeight/2 - 22.5, 45, 45)];
    
    _activetyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.tabBarController.view addSubview:_activetyIndicator];
    
    [_activetyIndicator startAnimating];
    _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
    
    [self requestHealthAuthorization];
    
    [self initScrollViews];
    
    
  

    
}

- (void)requestHealthAuthorization
{
  
    
    BOOL isHealthDataEnable = [HKHealthStore isHealthDataAvailable];
    
    if (isHealthDataEnable)
    {
        
       
        _myHealthStore = [KFHealthStore shareHealthStore];
       
    
        [_myHealthStore requestAuthorization:^(BOOL isSucess)
            {
                 
                 if (isSucess)
                 {
                     
                        [self getOneMonthData];
                     
                     
                  
                     
                 }
                 else
                 {
                     requestAlert =  [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"HealthCenterTips", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [requestAlert show];
                     
                 }
                 
             }];
        
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"HealthCenterNotAri", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show ];
    }
}
#pragma mark - 先获取一个月的数据 得到平均值
-(void)getOneMonthData
{
    
    _averageDistance = [[[NSUserDefaults standardUserDefaults ] objectForKey:kAverageDistance]floatValue];
    NSDate *saveDate = [[NSUserDefaults standardUserDefaults ] objectForKey:kAverageSaveDate];
    
    BOOL isAWeekAgo = [NSDate isAWeekAgo:saveDate];
    
//    // 没有值 就先请求一个月的数据 ，再请求一天的数据
//    _isNeedRefreshAVG = YES;
//    [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastMonth];
    //如果有值
    if (_averageDistance > 0 && !isAWeekAgo)
    {
        NSLog(@"%s,_averageDistance:%f",__func__,_averageDistance);
        
      
        
        [self requestDataFromHealhStore];
        
        
    }
    else
    {
        
//        _activetyIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(kScreenWith/2 - 22.5, kScreenHeight/2 - 22.5, 45, 45)];
//        
//        _activetyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        [_myscrollView  addSubview:_activetyIndicator];
//        [_activetyIndicator startAnimating];
//        
//        _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
//        
//        [_myscrollView bringSubviewToFront:_activetyIndicator];
        
        // 没有值 就先请求一个月的数据 ，再请求一天的数据
        //显示加载view
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.view addSubview:_activetyIndicator];
            [_activetyIndicator startAnimating];
            _activityStatus = ActivityIndicatorAnimatingStatusAnimating;
            
        });
        
          _isNeedRefreshAVG = YES;
        [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastMonth];
    
    

        
    }
}

#pragma mark - 请求数据
-(void)requestDataFromHealhStore
{
    
    [self getWeight];
    
    [self getWalkingStepsWithDayType:WalkingStepsTimeTypeLastTwodays];
    [self getwalkingDistanceWithDayType:WalkingStepsTimeTypeLastTwodays];
    
    [self getWalkingStepsWithDayType:WalkingStepsTimeTypeLastMonth];
  
    
    
}

#pragma mark - 从后台返回
-(void)appWillEnterForword
{
    [self requestDataFromHealhStore];
    
}
//初始化scrollview
-(void)initScrollViews
{
   


    _myscrollView.contentSize = CGSizeMake(kScreenWith *4, _myscrollView.frame.size.height);
    
    _myscrollView.delegate = self;
    
   
    _todayDataView = [[OneDayDataView alloc]initWithFrame:CGRectMake(0, -64, kScreenWith, _myscrollView.frame.size.height)];
    
    _yesterDayDataView = [[OneDayDataView alloc]initWithFrame:CGRectMake(kScreenWith, -64, kScreenWith, _myscrollView.frame.size.height)];
    
    _lastWeekDataView = [[OneWeekDataView alloc]initWithFrame:CGRectMake(kScreenWith *2, -64, kScreenWith, _myscrollView.frame.size.height)];
    
    _lastMonthDataView = [[OneMonthDataView alloc]initWithFrame:CGRectMake(kScreenWith *3, -64, kScreenWith, _myscrollView.frame.size.height)];
    
    CGFloat BottonViewHeight = 250.0;
    CGFloat BottonViewY = kScreenHeight - BottonViewHeight + 30;
    
  //  NSLog(@"myscrollviewHeight:%.2f",_myscrollView.frame.size.height);
    
    _todayBottonView = [[SPBottonProgressView alloc]initWithFrame:CGRectMake(0, BottonViewY, kScreenWith, BottonViewHeight)];
    
    
    _yesterDayBottonView = [[SPBottonProgressView alloc]initWithFrame:CGRectMake(kScreenWith, BottonViewY, kScreenWith, BottonViewHeight)];
    
    _lastWeekBottonView = [[SPBottonProgressView alloc]initWithFrame:CGRectMake(kScreenWith*2, BottonViewY, kScreenWith, BottonViewHeight)];
    
    _lastMonthBottonView = [[SPBottonProgressView alloc]initWithFrame:CGRectMake(kScreenWith*3, BottonViewY, kScreenWith, BottonViewHeight)];
    
    CGFloat graphViewHeight = 150 - BarBottomPADDING;
    
    CGFloat graphViewY = BottonViewY - graphViewHeight - BarBottomPADDING *3;
    
    CGFloat barWith = kScreenWith - 60;
    
    CGFloat barPadding = (kScreenWith - barWith)/2;
    
    
    _todayPlotView = [self getGraphViewWithFrame:CGRectMake(barPadding,graphViewY, barWith, graphViewHeight)];

    _yesterdayPlotView = [self getGraphViewWithFrame:CGRectMake(barPadding  + kScreenWith,graphViewY,barWith, graphViewHeight )];
  
    _lastWeekPlotView = [self getGraphViewWithFrame:CGRectMake(barPadding + kScreenWith *2, graphViewY, barWith, graphViewHeight)];
    
    _lastMonthPlotView = [self getGraphViewWithFrame:CGRectMake(barPadding + kScreenWith *3, graphViewY, barWith, graphViewHeight)];
    
    
    
}

-(MPGraphView*)getGraphViewWithFrame:(CGRect)frame
{
    MPGraphView *mympgraphView = [MPGraphView plotWithType:MPPlotTypeGraph frame:frame];
    mympgraphView.fillColors = kGraphFillColors;
    mympgraphView.graphColor = [UIColor clearColor];
    mympgraphView.detailBackgroundColor = kGrayBackgroundColor;
    mympgraphView.lineColor = kGraphLineColor;
    mympgraphView.detailTextColor = kTextColor;
    mympgraphView.curved = YES;
    
    return mympgraphView;
    
}
#pragma mark - 显示数据波形图
-(void)showChartViewWithView:(MPGraphView*)plotView values:(NSMutableArray*)values timeType:(WalkingStepsTimeType)timetype
{
    

    //先将数据按时间排序
    NSSortDescriptor *des = [[NSSortDescriptor alloc]initWithKey:@"startdate" ascending:YES];
    [values sortUsingDescriptors:@[des]];
    
    NSMutableArray *temNewValue = [DataHelper sortDataValue:values withTimeType:timetype];
    
   // NSLog(@"%s,%@",__func__,values);
    
    
    NSMutableArray *dateValues = [DataHelper getDate:values withTimeType:timetype];
    
  //  NSLog(@"%s,%@",__func__,temNewValue);
    
    if (temNewValue.count > 0) {
        
          plotView.daysArray = dateValues;
        
          plotView.values = temNewValue;
        //NSLog(@"newValues:%@,values:%@",newValues,muValues);
        
        
        [_myscrollView addSubview:plotView];
        
        [plotView animate];
    }

    

    
}

- (NSMutableArray*)sortValues:(NSMutableArray*)newValues
{
    
    NSMutableArray *temNewValue = [[NSMutableArray alloc]init];
    
    NSInteger N = 0;
    
    if (newValues.count > 24 && newValues.count < 100)
    {
        
        
        N = 5;
        
    }
    else if (newValues.count >= 100 && newValues.count < 400 )
    {
        
        N = 20;
        
    }
    else if (newValues.count >= 400)
    {
        N = 40;
        
    }
    else
    {
        N = 1;
        
    }
    
    for (NSInteger i = 0; i < newValues.count; i++)
    {
        
        if (i%N == 0)
        {
            
            CGFloat value = [[newValues objectAtIndex:i]floatValue];
            
            [temNewValue addObject:@(value)];
            
            
            
        }
        
        if (i == newValues.count - 1 && i%N != 0)
        {
            
            CGFloat value = [[newValues objectAtIndex:i]floatValue];
            
            [temNewValue addObject:@(value)];
            
        }
        
        
        
    }
    
    return temNewValue;
    
}

#pragma mark - 显示底部数据条
-(void)showBottonViewWithTimeType:(SPBottonProgressView*)bottonView currentSteps:(CGFloat)currentSteps currentDis:(CGFloat)currentDis expectedDis:(CGFloat)expectedDis
{
    CGFloat fat = [[KFTranslateWorkOutEnergyToFat shareEnergyToFat] wakingDistanceToFat:currentDis];
    CGFloat persent = currentDis/expectedDis;
    
    CGFloat calNum = [[KFTranslateWorkOutEnergyToFat shareEnergyToFat] walkingDistanceToCal:currentDis];
    
    //NSLog(@"%s,fat:%.2f,currentDis:%.2f",__func__,fat,currentDis);
    
    bottonView.fatNum = fat;
    bottonView.fatPersent = persent;
    
    bottonView.calPersent = persent;
    bottonView.calNum = calNum;
    
    [_myscrollView addSubview:bottonView];
    
    [bottonView animate];
    
    
}


#pragma mark - 显示一天的数据动画
-(void)showOneDayData:(OneDayDataView*)onedayview currentsteps:(CGFloat)steps currentDistance:(CGFloat)currentDis expectDistance:(CGFloat)expectDistance date:(NSDate*)date
{
    onedayview.currentSteps = steps;
    onedayview.currentDis = currentDis;
    onedayview.expectedDis = expectDistance;
    onedayview.showDate = date;
    
    [_myscrollView addSubview:onedayview];
    
    [onedayview animate];
    
    
}
#pragma mark - 显示一个星期数据动画
-(void)showOneWeekData:(OneWeekDataView*)oneWeekData currentsteps:(CGFloat)steps currentDistance:(CGFloat)currentDis expectDistance:(CGFloat)expectDistance date:(NSDate*)date
{
    oneWeekData.currentSteps = steps;
    oneWeekData.currentDis = currentDis;
    oneWeekData.expectedDis = expectDistance;
    oneWeekData.showDate = date;
    
    [_myscrollView addSubview:oneWeekData];
    
    [oneWeekData animate];
    
    
}
#pragma mark - 显示一个月数据动画
-(void)showOneMonthData:(OneMonthDataView*)oneMonthData currentsteps:(CGFloat)steps currentDistance:(CGFloat)currentDis expectDistance:(CGFloat)expectDistance date:(NSDate*)date
{
    oneMonthData.currentSteps = steps;
    oneMonthData.currentDis = currentDis;
    oneMonthData.expectedDis = expectDistance;
    oneMonthData.showDate = date;
    
    [_myscrollView addSubview:oneMonthData];
    
    [oneMonthData animate];
}
#pragma mark - 显示数据
-(void)showdatasWithTimeType:(WalkingStepsTimeType)timetype
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self animatecircleViewWithTimeType:timetype];
        
        
        
    });
}

#pragma mark - show progressview animation

-(void)animatecircleViewWithTimeType:(WalkingStepsTimeType)timetype
{
    double steps = 0.0;
//    double expectedSteps = 10000.0;
    double distance = 0.0;
    double expectedDistance = _averageDistance;
    
    
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
       
        
            //NSLog(@"%s,steps:%.2f,distance:%.2f",__func__,steps,distance);
            
        
            [self showOneDayData:_todayDataView currentsteps:steps currentDistance:distance expectDistance:expectedDistance date:[NSDate date]];
            
            
            
            [self showBottonViewWithTimeType:_todayBottonView currentSteps:steps currentDis:distance expectedDis:expectedDistance];
            
            [self showChartViewWithView:_todayPlotView values:_todayStepsArray timeType:WalkingStepsTimeTypeToday];
            
            
            
        }
            break;
        case WalkingStepsTimeTypeYesterday:
        {
             steps = [[_stepsMuDict objectForKey:yesterStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:yesterdaydistanceKey]doubleValue];
            
            [self showOneDayData:_yesterDayDataView currentsteps:steps currentDistance:distance expectDistance:expectedDistance date:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]];
            
             [self showBottonViewWithTimeType:_yesterDayBottonView currentSteps:steps currentDis:distance expectedDis:expectedDistance];
            
                 [self showChartViewWithView:_yesterdayPlotView values:_yesterStepsArray timeType:WalkingStepsTimeTypeYesterday];
        }
            break;
        case WalkingStepsTimeTypeLastSevendays:
        {
            
            expectedDistance = _averageDistance *7;
            
             steps = [[_stepsMuDict objectForKey:lastsevendaysStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:lastsevendaysdistanceKey]doubleValue];
            
            [self showOneWeekData:_lastWeekDataView currentsteps:steps currentDistance:distance expectDistance:expectedDistance date:[NSDate date]];
            
             [self showBottonViewWithTimeType:_lastWeekBottonView currentSteps:steps currentDis:distance expectedDis:expectedDistance];
            
             [self showChartViewWithView:_lastWeekPlotView values:_lastWeekStepsArray timeType:WalkingStepsTimeTypeLastSevendays];
        }
            break;
        case WalkingStepsTimeTypeLastMonth:
        {
            expectedDistance = _averageDistance *30;
            
             steps = [[_stepsMuDict objectForKey:lastonemonthStepKey]doubleValue];
            distance = [[_stepsMuDict objectForKey:lastonemonthdistanceKey]doubleValue];
            
            [self showOneMonthData:_lastMonthDataView currentsteps:steps currentDistance:distance expectDistance:200 date:[NSDate date]];
            
             [self showBottonViewWithTimeType:_lastMonthBottonView currentSteps:steps currentDis:distance expectedDis:expectedDistance];
             [self showChartViewWithView:_lastMonthPlotView values:_lastMonthStepsArray timeType:WalkingStepsTimeTypeLastMonth];
            
        }
            break;
            
            
        default:
            break;
    }
    

    
    
    
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
            
            NSLog(@"lastMonthDate:%@",lastOneMonth);
            
            
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
                
                NSString *today = [CommentMeths getddDateStrWithDate:[NSDate date]];
                
                NSDate *yesterday = [CommentMeths getYYYYMMdd0000DateWithDate:[[NSDate date] dateByAddingTimeInterval:-24*60*60]];
                
                
                NSDate *startDate = [CommentMeths getYYYYMMddDateWithDate:[onesample startDate]];
                
                NSString *startDateStr = [CommentMeths getddDateStrWithDate:startDate];
                
                
                HKQuantitySample *oneSample = [quantitys objectAtIndex:i];
                HKQuantity *quantity = oneSample.quantity;
                
                HKUnit *countUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                
                double distance = [quantity  doubleValueForUnit:countUnit];
                
                if (timetype == WalkingStepsTimeTypeLastTwodays)
                {
                    
                    
                  
                    if ([today isEqualToString:startDateStr])
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
                    
                    if (hadGetLastSevenDaysSteps && currentScrollViewPageIndex == 2) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastSevendays];
                        
                        hadShowedLastSevenDaysData = YES;
                        
                        
                    }
                    
                }
                    break;
                    
                case WalkingStepsTimeTypeLastMonth:
                {
                    
                  
                    if (_isNeedRefreshAVG)
                    {
                        
                       
                        
                        //只请求一次
                        _averageDistance = totaldistance/30.0*1.2;
                        
                        NSLog(@"%s,_averageDistance:%f,totalDistance:%f",__func__,_averageDistance,totaldistance);
                        
                        [[NSUserDefaults standardUserDefaults ] setFloat:_averageDistance forKey:kAverageDistance];
                        
                        [[NSUserDefaults standardUserDefaults ] setObject:[NSDate date] forKey:kAverageSaveDate];
                        
                        [[NSUserDefaults standardUserDefaults ] synchronize];
                        
                          [self requestDataFromHealhStore];
                    }
                  
                    
                   [_stepsMuDict setObject:@(totaldistance) forKey:lastonemonthdistanceKey];
                    
                    hadGetLastOneMonthDistance = YES;
                    
                   
                    
                    if (hadGetLastOneMonthSteps && currentScrollViewPageIndex == 3) {
                        
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
    
     // NSLog(@"startdate:%@,enddate:%@",startDate,endDate);
    
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
//                HKSampleType *type = oneSample.sampleType;
//                NSLog(@"sampleType:%@",type);
                
                
                
                double steps = [quantity doubleValueForUnit:countUnit];
                
                NSDate *quantityStartDate = oneSample.startDate;
                NSDate *quantityEndDate = oneSample.endDate;
                
                NSString *starttimeStr  = [NSDate HHmmStringWithDate:quantityStartDate];
                NSString *endtimeStr = [NSDate HHmmStringWithDate:quantityEndDate];
                
                NSString *hourStr = [NSDate HHStringWithDate:quantityStartDate];
                NSString *minuteStr = [NSDate mmStringWithDate:quantityStartDate];
                
                
//                NSLog(@"%s,time:%@",__func__,starttimeStr);
                
//                NSLog(@"startDate:%@",startDate);
                
                
                if (timetype == WalkingStepsTimeTypeLastTwodays)
                {
                    
                    
                
                if ([today isEqualToDate:startDate])
                {
                    
                        
                        todaySteps += steps;
                    
                    NSDictionary *dataDict = @{@"starttime":starttimeStr,@"endtime":endtimeStr,@"value":@(steps),@"startdate":startDate,@"hour":hourStr,@"minute":minuteStr};
                    
                    
                    [_todayStepsArray addObject:dataDict];
                    
                    
                        
                    
                }
           
                
                
                if ([yesterday isEqualToDate:startDate])
                {
                    
                       yestdaySteps += steps;
                    
                    
                    NSDictionary *dataDict = @{@"starttime":starttimeStr,@"endtime":endtimeStr,@"value":@(steps),@"startdate":startDate,@"hour":hourStr,@"minute":minuteStr};
                    
                    
                    [_yesterStepsArray addObject:dataDict];
                    
                }
           
                
                }
                
                else if (timetype == WalkingStepsTimeTypeLastSevendays)
                {
                    NSDictionary *dataDict = @{@"starttime":starttimeStr,@"endtime":endtimeStr,@"value":@(steps),@"startdate":startDate,@"hour":hourStr,@"minute":minuteStr};
                    
                    
                    [_lastWeekStepsArray addObject:dataDict];
                }
                else
                {
                    NSDictionary *dataDict = @{@"starttime":starttimeStr,@"endtime":endtimeStr,@"value":@(steps),@"startdate":startDate,@"hour":hourStr,@"minute":minuteStr};
                    
                    
                    [_lastMonthStepsArray addObject:dataDict];
                }
                
                
                totalSteps +=steps;
                
                
            
                
             }
            
            
//            NSSortDescriptor *sortDes = [[NSSortDescriptor alloc]initWithKey:@"hour" ascending:YES];
//            NSSortDescriptor *minuteDes = [[NSSortDescriptor alloc]initWithKey:@"minute" ascending:YES];
//            NSArray *sort = [[NSArray alloc]initWithObjects:sortDes, nil];
            
            
//            [_todayStepsArray sortUsingDescriptors:@[sortDes]];
            
             //[_todayStepsArray sortUsingDescriptors:@[sortDes]];
            
            
//            NSLog(@"%@",_todayStepsArray);
            
            switch (timetype) {
                case WalkingStepsTimeTypeLastTwodays:
                {
                    [_stepsMuDict setObject:@(todaySteps) forKey:todayStepKey];
                    
                    [_stepsMuDict setObject:@(yestdaySteps) forKey:yesterStepKey];
                    
                    
                    hadGetLastTwoDaysSteps = YES;
                    
                    
                    if (hadGetLastTwoDaysDistance) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeToday];
                        
                    }
                 
                    
                   //  NSLog(@"todaySteps steps:%f",todaySteps);
                    
                    
                }
                    break;
            
                case WalkingStepsTimeTypeLastSevendays:
                {
                    [_stepsMuDict setObject:@(totalSteps) forKey:lastsevendaysStepKey];
                    
                    hadGetLastSevenDaysSteps = YES;
                    
                    if (hadGetLastSevenDaysDistance && currentScrollViewPageIndex == 2) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastSevendays];
                        
                        hadShowedLastSevenDaysData =YES;
                        
                        
                    }
                    
                        //   NSLog(@"yesterday steps:%f",yestdaySteps);
                }
                    break;
                case WalkingStepsTimeTypeLastMonth:
                {
                    
                    [_stepsMuDict setObject:@(totalSteps) forKey:lastonemonthStepKey];
                    
                    hadGetLastOneMonthSteps = YES;
                    
                    if (hadGetLastOneMonthDistance && currentScrollViewPageIndex == 3) {
                        
                        [self showdatasWithTimeType:WalkingStepsTimeTypeLastMonth];
                        hadShowedLastOneMonthData = YES;
                        
                        
                    }
                }
                    break;
                    
                    
                default:
                    break;
             }
            
            
            
       
            
       
            
            //NSLog(@"totalSteps:%f",totalSteps);
            
            
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
            
         
            
          [[NSUserDefaults standardUserDefaults ] setObject:@(_userWeight) forKey:kCurrentWeiht];
            
            [[NSUserDefaults standardUserDefaults ] synchronize];
            
           
            
        }
        
        
        
    }];
    
}







#pragma mark  - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xorigin = scrollView.contentOffset.x;
    
    NSInteger pageIndex = xorigin/kScreenWith;
    
    currentScrollViewPageIndex = pageIndex;
    
   // NSLog(@"%s,pageIndex:%ld",__func__,(long)pageIndex);
    
    switch (pageIndex) {
        case 0:
        {
            _arrow_leftButton.hidden = YES;
            _arrow_right.hidden = NO;
            
        }
            break;
        case 1:
        {
            _arrow_leftButton.hidden = NO;
            _arrow_right.hidden = NO;
            
            if (!hadShowedYesterdayData && hadGetLastTwoDaysSteps && hadGetLastTwoDaysDistance) {
               
                 [self animatecircleViewWithTimeType:WalkingStepsTimeTypeYesterday];
                
                hadShowedYesterdayData = YES;
            }
           
            
        }
            break;
        case 2:
        {
            
            _arrow_leftButton.hidden = NO;
            _arrow_right.hidden = NO;
            
            if (!hadShowedLastSevenDaysData && hadGetLastSevenDaysDistance && hadGetLastSevenDaysSteps) {
                
                [self animatecircleViewWithTimeType:WalkingStepsTimeTypeLastSevendays];
                
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
            
            _arrow_leftButton.hidden = NO;
            _arrow_right.hidden = YES;
            
            if (!hadShowedLastOneMonthData && hadGetLastOneMonthDistance && hadGetLastOneMonthSteps) {
                
                [self animatecircleViewWithTimeType:WalkingStepsTimeTypeLastMonth];
                hadShowedLastOneMonthData = YES;
                
                
            }
            else if (!hadShowedLastOneMonthData)
            {
                  hadShowedLastOneMonthData = YES;
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

- (IBAction)right_scroAction:(id)sender {
    
    CGFloat oX = _myscrollView.contentOffset.x;
    CGFloat oY = _myscrollView.contentOffset.y;
    
    [UIView animateWithDuration:0.5 animations:^{
    
        _myscrollView.contentOffset = CGPointMake(oX + kScreenWith, oY);
        
        
    } completion:^(BOOL finished) {
        
        [self scrollViewDidEndDecelerating:_myscrollView];
        
    }];
    
}

- (IBAction)left_scrolAction:(id)sender {
    
    CGFloat oX = _myscrollView.contentOffset.x;
    CGFloat oY = _myscrollView.contentOffset.y;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _myscrollView.contentOffset = CGPointMake(oX - kScreenWith, oY);
        
        
    }completion:^(BOOL finished) {
        
         [self scrollViewDidEndDecelerating:_myscrollView];
    }];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == requestAlert)
    {
        
        [self requestHealthAuthorization];
        
    }
}
@end
