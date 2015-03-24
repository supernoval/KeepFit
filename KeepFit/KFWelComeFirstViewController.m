//
//  KFWelComeFirstViewController.m
//  KeepFit
//
//  Created by Leo on 15/3/24.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFWelComeFirstViewController.h"
#import "KFWelComeSecondViewController.h"
#import "ViewControllerIDs.h"
#import "TAlertView.h"
#import "NSUserDefaultsKeys.h"

@interface KFWelComeFirstViewController ()
{
    UITapGestureRecognizer *_tap;
    
}
@end

@implementation KFWelComeFirstViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardDidShowNotification object:nil];
    
    
    
    
}

-(void)keyboardShow
{
    [self.view addGestureRecognizer:_tap];
    
    
}
-(void)hideKeyBoard
{
    
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tap];
    
    
}



- (IBAction)nextAction:(id)sender {
    
//NSString *height = _bodyheightTextField.text;
    
    NSString *weight = _bodyweightTextField.text;
//    
//    if (height.length == 0) {
//        
//        [[[TAlertView alloc]showFadeOutAlertWithTitle:nil andMessage:@"请填写身高"]showAsMessage];
//        
//        return;
//        
//    }
    
    if (weight.length == 0) {
        
        [[[TAlertView alloc]showFadeOutAlertWithTitle:nil andMessage:@"请填写体重"]showAsMessage];
        
        return;
        
    }
    
    
   // [[NSUserDefaults standardUserDefaults ] setObject:height forKey:kCurrentHeight];
    
    [[NSUserDefaults standardUserDefaults ] setObject:weight forKey:kCurrentWeiht];
    
    
    [self.view endEditing:YES];
    
    KFWelComeSecondViewController *_welcomeSec = [self.storyboard instantiateViewControllerWithIdentifier:kKFWelComeSecondViewController];
    

    
    [self.navigationController pushViewController:_welcomeSec animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
