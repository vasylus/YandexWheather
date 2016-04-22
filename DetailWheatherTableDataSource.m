//
//  DetailWheatherTableDataSource.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "DetailWheatherTableDataSource.h"
#import "AFHTTPSessionManager.h"
#import "XMLReader.h"
#import "WheatherModel.h"
#import "WheatherCell.h"

@interface DetailWheatherTableDataSource ()<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property UITableView *tableView;
@property NSString *cityID;
@property NSMutableArray *arrayOfWeather;
@property UIViewController *vc;
@end

@implementation DetailWheatherTableDataSource



- (instancetype)initWithTableView:(UITableView *)tableView cityID:(NSString *)cityID andViewController:(UIViewController *)vc{
    if (self = [super init]){
        self.cityID = cityID;
        self.vc = vc;
        self.arrayOfWeather = @[].mutableCopy;
        [self configureTableView:tableView];
        [self loadWheather];
    }
    return self;
    
}

- (void)configureTableView:(UITableView *)tableView{
    [tableView setContentInset:UIEdgeInsetsMake(-35, 0, 0, 0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"WheatherCell" bundle:nil] forCellReuseIdentifier:@"WheatherCell"];
    
    self.tableView = tableView;
}

- (void)loadWheather{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://export.yandex.ru/weather-ng/forecasts/%@.xml",self.cityID];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *xmlReader = [XMLReader dictionaryForXMLString:string error:nil];
        for (NSDictionary *day in [[xmlReader valueForKey:@"forecast"] valueForKey:@"day"]){
            WheatherModel *wModel = [[WheatherModel alloc] initWithDictionary:day];
            [self.arrayOfWeather addObject:wModel];
        }
        
        [self.tableView beginUpdates];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Oops"  message:[NSString stringWithFormat:@"%@ Please try again later", error.localizedDescription]  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.vc dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self.vc presentViewController:alertController animated:YES completion:nil];
        
    }];
    
}

#pragma mark - TableView DataSource-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfWeather.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       WheatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WheatherCell" forIndexPath:indexPath];
        [cell fillWithObject:self.arrayOfWeather[indexPath.row] atIndex:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
