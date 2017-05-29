//
//  ViewController.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/5/28.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button];
    [button setFrame:CGRectMake(16, 30, 200, 50)];
    [button setCenter:self.view.center];
    [button setEnabled:YES];
    
    [button.layer setCornerRadius:5.0];
    [button.layer setMasksToBounds:YES];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"BUTTON"];
    NSRange strRange = {0,[attributedString length]};
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnPressed:(UIButton *)sender
{
    NSLog(@"hello wolrd");
}

@end
