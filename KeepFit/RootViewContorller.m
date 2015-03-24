//
//  RootViewContorller.m
//  KeepFit
//
//  Created by Leo on 15/3/24.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "RootViewContorller.h"
#import "ConstantValues.h"
#import "ViewControllerIDs.h"
@interface RootViewContorller ()

@end

@implementation RootViewContorller

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    BOOL hadShowWelComeView = [[[NSUserDefaults standardUserDefaults ] objectForKey:kHadShowWelComeView]boolValue];
    
    // if (!hadShowWelComeView)
    {
        
        [[NSUserDefaults standardUserDefaults ] setObject:@(1) forKey:kHadShowWelComeView];
        
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        UINavigationController *nav =(UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:kWelComeNav];
        
        [self presentViewController:nav animated:YES completion:nil];
        
        
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

        
        
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
