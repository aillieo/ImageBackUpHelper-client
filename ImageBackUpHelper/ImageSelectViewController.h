//
//  ImageSelectViewController.h
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/1.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import <CTAssetsPickerController/CTAssetsPageViewController.h>

@interface ImageSelectViewController : UITableViewController
<CTAssetsPickerControllerDelegate>

@property (nonatomic, copy) NSArray *assets;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) PHImageRequestOptions *requestOptions;

@end
