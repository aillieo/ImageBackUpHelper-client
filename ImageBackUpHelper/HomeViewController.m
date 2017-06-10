//
//  HomeViewController.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/5/28.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "AFHttpSessionManager.h"
#import "ImageSelectViewController.h"
#import "UploadManager.h"
#import "SettingViewController.h"

@interface HomeViewController () <ImageSelectViewControllerDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *settingButton =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(btnSettingPressed:)];
    
    UIBarButtonItem *space =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[space, settingButton];
    
    // Network
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];

    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [self showState : @"no network"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                [self showState : @"use wifi"];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [self showState : @"use cellular data"];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (IBAction)btnCheckPressed:(id)sender
{
    [self showState : @"connecting"];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [session GET:@"http://127.0.0.1:8080" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"GET downloadProgress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"GET success:%@", responseObject);
        [self showState : @"connected"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET failure:%@", error);
        [self showState : @"connect error"];
    }];
    
}

- (IBAction)btnSelectPressed:(id)sender
{
    ImageSelectViewController *view = [ImageSelectViewController new];
    
    [view setDelegate:self];
    
    if (self.assets) {
        view.assets = self.assets;
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)btnSettingPressed:(id)sender
{
    SettingViewController *view = [SettingViewController new];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)btnUploadPressed:(id)sender {
    
    if(self.assets == nil || self.assets.count == 0)
    {
        return;
    }
    
    [UploadManager uploadAssets:self.assets];
    
}

- (void)passAssets:(NSArray *)assets
{
    self.assets = assets;
    [self showState:[NSString stringWithFormat:@"Will upload %lu photo(s)",(unsigned long)self.assets.count]];
}

- (void)showState:(NSString *)stateString
{
    _labelState.text = stateString;
}

@end
