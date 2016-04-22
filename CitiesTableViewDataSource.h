//
//  CitiesTableViewDataSource.h
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitiesTableViewDelegate <NSObject>

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@end


@interface CitiesTableViewDataSource : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView searchBar:(UISearchBar *)searchBar andView:(UIView *)view;

@property (nonatomic, weak) id <CitiesTableViewDelegate> delegate;


@end
