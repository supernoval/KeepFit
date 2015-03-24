//
//  KFWelComeSecondViewController.m
//  KeepFit
//
//  Created by Leo on 15/3/24.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFWelComeSecondViewController.h"
#import "TAlertView.h"
#import "ConstantValues.h"
#import "NSUserDefaultsKeys.h"

@interface KFWelComeSecondViewController ()
{
    UITapGestureRecognizer *_tap;
    
}
@end

@implementation KFWelComeSecondViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowed) name:UIKeyboardDidShowNotification object:nil];
    
    
    
    
}

-(void)keyboardHide
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tap];
    
    
}
-(void)keyboardShowed
{
    [self.view addGestureRecognizer:_tap];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneAction:(id)sender {
    
    
    NSString *weight = _mubiaotizhongTextfield.text;
    
    if (weight.length == 0)
    {
        
    
        [[[TAlertView alloc]showFadeOutAlertWithTitle:nil andMessage:@"请填写目标体重"]showAsMessage];
        
        return;
        
        
    }
    
    
    [self.view endEditing:YES];
    
    [[NSUserDefaults standardUserDefaults ] setObject:@(1) forKey:kHadShowWelComeView];
    
    [[NSUserDefaults standardUserDefaults ] synchronize];
    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
