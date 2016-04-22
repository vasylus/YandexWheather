//
//  WheatherCell.h
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheatherModel.h"

@protocol StoreInfo <NSObject>

- (void)fillWithObject:(WheatherModel *)weatherInfo atIndex:(NSIndexPath *)indexPath;

@end


@interface WheatherCell : UITableViewCell<StoreInfo>

@end
