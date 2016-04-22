//
//  DetailWheatherViewController.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "DetailWheatherViewController.h"
#import "DetailWheatherTableDataSource.h"

@interface DetailWheatherViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property DetailWheatherTableDataSource *dataSource;
@end

@implementation DetailWheatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}
- (void)setUpView{
    self.navigationController.topViewController.title = self.nameOfCity;
//    [self.navigationController.title settextcol]
    
    self.dataSource = [[DetailWheatherTableDataSource alloc] initWithTableView:self.tableView cityID:self.cityID andViewController:self];
}

@end
