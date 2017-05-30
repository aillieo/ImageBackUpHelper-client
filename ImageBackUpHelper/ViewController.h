//
//  ViewController.h
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/5/28.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)btnCheckPressed:(id)sender;

- (IBAction)btnSelectPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textServer;

@property (weak, nonatomic) IBOutlet UILabel *labelState;

@end

