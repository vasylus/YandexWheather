//
//  CitiesTableViewDataSource.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CitiesTableViewDataSource.h"
#import "AFHTTPSessionManager.h"
#import "XMLReader.h"
#import "CityModel.h"



@interface CitiesTableViewDataSource ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfCities;
@property (strong, nonatomic) NSMutableArray *oldArrayOfCities;

@property UITableView *citiesTableView;
@property NSString *currentElement;
@property UIView *viewOfVC;
@property UISearchBar *searchBar;


@end

@implementation CitiesTableViewDataSource


- (instancetype)initWithTableView:(UITableView *)tableView searchBar:(UISearchBar *)searchBar andView:(UIView *)view{
    if (self = [super init]){
        self.arrayOfCities = @[].mutableCopy;
        self.oldArrayOfCities = @[].mutableCopy;
        
        self.viewOfVC = view;
        [self getCitiesList];
        [self configureTableView:tableView];
        [self configureSearchBar:searchBar];
    }
    return self;
}

- (void)configureTableView:(UITableView *)tableView{
    [tableView setContentInset:UIEdgeInsetsMake(8, 0, 0, 0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.citiesTableView = tableView;
}
- (void)configureSearchBar:(UISearchBar *)searchBar{
    self.searchBar = searchBar;
    searchBar.delegate = self;
}


- (void)getCitiesList{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIActivityIndicatorView *indicator = [UIActivityIndicatorView new];
    indicator.center = self.viewOfVC.center;
    
    indicator.hidden = NO;
    indicator.color = [UIColor blackColor];
    [self.viewOfVC addSubview:indicator];
    [indicator startAnimating];
    
    
    [manager GET:@"https://pogoda.yandex.ru/static/cities.xml" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [indicator stopAnimating];
        NSDictionary *xmlReader = [XMLReader dictionaryForXMLString:string error:nil];
        for (NSArray *city in [[xmlReader valueForKey:@"cities"] valueForKey:@"country"]){
            for (id dct in [city valueForKey:@"city"]){
                if ([dct isKindOfClass:NSDictionary.class]){
            CityModel *model = [[CityModel alloc] initWithDictionary:dct];
                [self.arrayOfCities addObject:model];
                }
            }
        }
        self.oldArrayOfCities = self.arrayOfCities;
        [self.citiesTableView beginUpdates];
        [self.citiesTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
        [self.citiesTableView endUpdates];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

#pragma mark - TableView DataSource-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfCities.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    CityModel *model = self.arrayOfCities[indexPath.row];
    cell.textLabel.text = model.cityName;
    cell.detailTextLabel.text = model.countryName;
    return cell;
}

#pragma mark - delegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]){
        CityModel* cityInfo = self.arrayOfCities[indexPath.row];
        [self.delegate didSelectObject:cityInfo atIndexPath:indexPath];
    }
}

#pragma mark - SearchBar-

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSArray *sortedArray = [self.oldArrayOfCities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(cityName  contains %@) OR (countryName contains %@)", searchText, searchText]];
    self.arrayOfCities = sortedArray.mutableCopy;
    if (searchText.length == 0){
        self.arrayOfCities = self.oldArrayOfCities;
        [self.citiesTableView reloadData];
    }
    [self.citiesTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.arrayOfCities = self.oldArrayOfCities;
    [self.citiesTableView reloadData];
    searchBar.text = nil;
}


@end
