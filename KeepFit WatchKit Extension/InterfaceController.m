//
//  InterfaceController.m
//  KeepFit WatchKit Extension
//
//  Created by ZhuHaikun on 15/1/29.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "InterfaceController.h"
#import "CommonMethods.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [WKInterfaceController openParentApplication:@{@"action":@"1"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        
        
    }];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
   // CGFloat persent = [CommonMethods getPersent ];
    
    
    [self showPersent];
    
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


-(void)showPersent
{

  

    //self.persentLabel.text = [NSString stringWithFormat:@"%.1f%@",persent,@"%"];


    
   
    
}

@end



