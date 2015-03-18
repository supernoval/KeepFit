//
//  KFTakePotoBasicViewController.m
//  KeepFit
//
//  Created by ZhuHaikun on 15/3/11.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "KFTakePotoBasicViewController.h"
#import "KFTakingPictureViewController.h"
#import "CommentMeths.h"
#import "AppDelegate.h"


typedef NS_ENUM(NSInteger, TakePotoState)
{
    TakePotoStateNone,
    TakePotoStateIsTaking,
    TakePotoStateHadTaked
    
};
@interface KFTakePotoBasicViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_pickPotoVC;
    
    NSInteger _state;
    
}
@end

@implementation KFTakePotoBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
    
    _pickPotoVC = [[UIImagePickerController alloc]init];
    
    _pickPotoVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    _pickPotoVC.delegate = self;
    
    _state  = TakePotoStateNone;
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (_state == TakePotoStateNone)
    {
            _state = TakePotoStateIsTaking;
        
        [self presentViewController:_pickPotoVC animated:YES completion:nil];
        
    
        
        
    }
  
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_state == TakePotoStateHadTaked)
    {
        
        _state = TakePotoStateNone;
        
        
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _state = TakePotoStateHadTaked;
    
   
    

    
    NSDictionary *imageMediaMetadata  = [info objectForKey:UIImagePickerControllerMediaMetadata];
    NSDictionary *tiff = [imageMediaMetadata objectForKey:@"{TIFF}"];
    
     UIImage *_phototake = [info objectForKey:UIImagePickerControllerOriginalImage];
     NSString *_dateStr = [tiff objectForKey:@"DateTime"];
     NSDate *_photoDate = [CommentMeths getYYYYMMddHHmmssWithString:_dateStr];
    
    AppDelegate *_appdelegate = [[AppDelegate alloc]init];
    
 
    
     NSLog(@"%s,%@",__func__,_photoDate);
    
    [_pickPotoVC dismissViewControllerAnimated:YES completion:^{
        
        
        self.tabBarController.selectedIndex = 2;
        
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    _state = TakePotoStateHadTaked;
    
    [_pickPotoVC dismissViewControllerAnimated:YES completion:^{
        
        self.tabBarController.selectedIndex = 2;
        
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
