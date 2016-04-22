//
//  DetailWheatherTableDataSource.h
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface DetailWheatherTableDataSource : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView cityID:(NSString *)cityID andViewController:(UIViewController *)vc;

@end
