//
//  LASettingViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LASettingViewController.h"

@interface LASettingViewController ()

@property(nonatomic,retain) LADBLatticeObject * dataObject;

@end

@implementation LASettingViewController

@synthesize dataObject = _dataObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(_dataObject == nil){
        self.dataObject = [self.context focusValueForKey:@"latticeObject"];
    }

}

- (void) viewDidUnload
{
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)dealloc
{
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray  *setting = [_dataObject.infoObject valueForKey:@"settings"];
    if (setting && [setting isKindOfClass:[NSArray class]]) {
        return [setting count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"%d,%d",indexPath.row,indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        NSArray  *setting = [_dataObject.infoObject valueForKey:@"settings"];
        NSDictionary *item = [setting objectAtIndex:indexPath.row];
        cell.textLabel.text = [item valueForKey:@"title"];
        
        if ([[item valueForKey:@"type"] isEqualToString:@"boolean"]) {
            UISwitch *btnSwitch = [[UISwitch alloc] init];
            [btnSwitch setOn:[[item valueForKey:[item valueForKey:@"key"]] boolValue]];
            cell.accessoryView = btnSwitch;
        }
        else if ([[item valueForKey:@"key"] isEqualToString:@"select"]){
            
            UIView *accessory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
            UILabel *classifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
            classifyLabel.textAlignment = NSTextAlignmentRight;
            classifyLabel.font = [UIFont systemFontOfSize:15];
            classifyLabel.textColor = [UIColor blackColor];
            classifyLabel.text = [item valueForKey:[item valueForKey:@"key"]];
            classifyLabel.text = @"fenlei";
            [accessory addSubview:classifyLabel];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 4, 6, 11)];
            imageView.image = [UIImage imageNamed:@"rightRow.png"];
            [accessory addSubview:imageView];
            
            cell.accessoryView = accessory;
        }
    }
    
    return cell;
}

@end
