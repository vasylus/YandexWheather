//
//  WheatherCell.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WheatherCell.h"

@interface WheatherCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureTo;
@property (weak, nonatomic) IBOutlet UILabel *temperatureFrom;
@property (weak, nonatomic) IBOutlet UILabel *wheatherDescription;

@end

@implementation WheatherCell

- (void)fillWithObject:(WheatherModel *)wheatherInfo atIndex:(NSIndexPath *)indexPath{
    self.dayLabel.text = wheatherInfo.date;
    self.temperatureFrom.text  = [NSString stringWithFormat:@"%@°C",wheatherInfo.temperatureFrom];
    self.temperatureTo.text  = [NSString stringWithFormat:@"%@°C",wheatherInfo.temperatureTo];
    self.wheatherDescription.text = wheatherInfo.wheatherDescription;
}

@end
