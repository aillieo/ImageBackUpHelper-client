//
//  SettingViewController.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/4.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "SettingViewController.h"
#import "ImageSelectViewController.h"

#define cellOffsetX 16.0f

@interface SettingViewController ()<UITextFieldDelegate>

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
    
    NSString *title = @"";
    
    CGRect textFieldRect = CGRectOffset(cell.contentView.frame,cellOffsetX,0);
    
    switch (section) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField* textField = [[UITextField alloc] initWithFrame:textFieldRect];
            [cell.contentView addSubview:textField];
            //textField.text = @"http://127.0.0.1:8080";
            textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"url"];
            textField.delegate = self;
            [textField setTag:0];
            [textField release];
            break;
        }
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField* textField = [[UITextField alloc] initWithFrame:textFieldRect];
            [cell.contentView addSubview:textField];
            //textField.text = @"./";
            textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"path"];
            textField.delegate = self;
            [textField setTag:1];
            [textField release];
            break;
        }
        case 2:
        {
            NSInteger rename = [[NSUserDefaults standardUserDefaults] integerForKey:@"rename"];
            
            if(row == 0){
                title = @"Use original name";
            }
            else if (row == 1){
                title = @"Use number from 1";
            }
            else if (row == 2){
                title = @"Use date and time";
            }
            
            if(rename == row)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
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
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
            [self.view endEditing:YES];
            [[NSUserDefaults standardUserDefaults] setInteger:i forKey:@"rename"];
            NSLog(@"-----%f",cell.textLabel.frame.origin.x);
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([textField tag] == 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"url"];
    }
    else if([textField tag] == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"path"];
    }
    
    return true;
}

@end
