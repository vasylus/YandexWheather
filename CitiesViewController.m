//
//  ViewController.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 20.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesTableViewDataSource.h"
#import "DetailWheatherViewController.h"

@interface CitiesViewController ()<CitiesTableViewDelegate>

@property CitiesTableViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
}

- (void)setUpTableView {
    
    self.dataSource = [[CitiesTableViewDataSource alloc] initWithTableView:self.tableView searchBar:self.searchBar andView:self.view];
    self.dataSource.delegate = self;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    DetailWheatherViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailWheatherViewController"];
    
    vc.cityID = [object valueForKey:@"cityID"];
    vc.nameOfCity = [object valueForKey:@"cityName"];

    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
