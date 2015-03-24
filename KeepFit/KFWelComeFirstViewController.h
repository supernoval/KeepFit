//
//  KFWelComeFirstViewController.h
//  KeepFit
//
//  Created by Leo on 15/3/24.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFWelComeFirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *bodyheightTextField;


- (IBAction)nextAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *bodyweightTextField;

@end
