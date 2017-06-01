//
//  ViewController.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/5/28.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AFHttpSessionManager.h"
#import "ImageSelectViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];

    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                _labelState.text = @"no network";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                _labelState.text = @"use wifi";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                _labelState.text = @"use cellular data";
                break;
            }
            default:
                break;
        }
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckPressed:(id)sender
{
    _labelState.text = @"connecting";
    
    NSString *URLString = @"localhost:8080";
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
    
}
- (IBAction)btnSelectPressed:(id)sender
{
    NSLog(@"select");
    
    ImageSelectViewController *view = [ImageSelectViewController new];
    
    if(self.navigationController != nil)
    {
        NSLog(@"navigationController");
    }
    [self.navigationController pushViewController:view animated:YES];
    
}

@end
