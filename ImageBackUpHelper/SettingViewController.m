//
//  SettingViewController.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/4.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "SettingViewController.h"
#import "ImageSelectViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 3;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Server url";
        case 1:
            return @"Server file path";
        case 2:
            return @"Rename";
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *title;
    
    switch (section) {
        case 0:
        {
            title = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
            CGRect textFieldRect = cell.contentView.frame;
            UITextField* textField = [[UITextField alloc] initWithFrame:textFieldRect];
            [cell.contentView addSubview:textField];
            //textField.center = cell.center;
            textField.text = @"http://127.0.0.1:8080";
            break;
        }
        case 1:
        {
            title = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
            CGRect textFieldRect = cell.contentView.frame;
            UITextField* textField = [[UITextField alloc] initWithFrame:textFieldRect];
            [cell.contentView addSubview:textField];
            //textField.center = cell.center;
            textField.text = @"./";
            break;
        }
        case 2:
            if(row == 0){
                title = @"Use original name";
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else if (row == 1){
                title = @"Use number from 1";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else if (row == 2){
                title = @"Use date and time";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        default:
            break;
    }

    cell.textLabel.text = title;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row;
    if(section!= 2)
    {
        return;
    }
    for(int i = 0 ; i < 3; i++)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
        if(i == row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}


@end
