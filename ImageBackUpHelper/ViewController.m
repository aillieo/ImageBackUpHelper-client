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
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [session GET:@"http://127.0.0.1:8080" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"GET downloadProgress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"GET success:%@", responseObject);
        _labelState.text = @"connected";
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET failure:%@", error);
        _labelState.text = @"connect error";
    }];
    
}
- (IBAction)btnSelectPressed:(id)sender
{
    ImageSelectViewController *view = [ImageSelectViewController new];
    
    [self.navigationController pushViewController:view animated:YES];
}

@end
